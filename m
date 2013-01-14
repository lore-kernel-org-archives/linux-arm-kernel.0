From: agraf@suse.de (Alexander Graf)
Date: Mon, 14 Jan 2013 22:28:52 +0100
Subject: [kvmarm] [PATCH v5 04/12] ARM: KVM: Initial VGIC infrastructure
 code
In-Reply-To: <CANM98q+y4GoHmqh-CS+fDnfbDbBQHQOY05urer5DMgy9b1X5ng@mail.gmail.com>
References: <20130108184116.46558.3558.stgit@ubuntu>
 <20130108184150.46558.35674.stgit@ubuntu>
 <20130114153107.GE18935@mudshark.cambridge.arm.com>
 <CANM98q+y4GoHmqh-CS+fDnfbDbBQHQOY05urer5DMgy9b1X5ng@mail.gmail.com>
Message-ID: <69614D59-A6C0-42AB-82C1-2BC66B6F01A2@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 14.01.2013 um 22:08 schrieb Christoffer Dall <c.dall@virtualopensystems.com>:

> On Mon, Jan 14, 2013 at 10:31 AM, Will Deacon <will.deacon@arm.com> wrote:
>> On Tue, Jan 08, 2013 at 06:41:51PM +0000, Christoffer Dall wrote:
>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>> 
>>> Wire the basic framework code for VGIC support and the initial in-kernel
>>> MMIO support code for the VGIC, used for the distributor emulation.
>> 
>> [...]
>> 
>>> +/**
>>> + * vgic_reg_access - access vgic register
>>> + * @mmio:   pointer to the data describing the mmio access
>>> + * @reg:    pointer to the virtual backing of vgic distributor data
>>> + * @offset: least significant 2 bits used for word offset
>>> + * @mode:   ACCESS_ mode (see defines above)
>>> + *
>>> + * Helper to make vgic register access easier using one of the access
>>> + * modes defined for vgic register access
>>> + * (read,raz,write-ignored,setbit,clearbit,write)
>>> + */
>>> +static void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
>>> +                           phys_addr_t offset, int mode)
>>> +{
>>> +       int shift = (offset & 3) * 8;
>>> +       u32 mask;
>>> +       u32 regval;
>>> +
>>> +       /*
>>> +        * Any alignment fault should have been delivered to the guest
>>> +        * directly (ARM ARM B3.12.7 "Prioritization of aborts").
>>> +        */
>>> +
>>> +       mask = (~0U) >> shift;
>>> +       if (reg) {
>>> +               regval = *reg;
>>> +       } else {
>>> +               BUG_ON(mode != (ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED));
>>> +               regval = 0;
>>> +       }
>>> +
>>> +       if (mmio->is_write) {
>>> +               u32 data = (*((u32 *)mmio->data) & mask) << shift;
>>> +               switch (ACCESS_WRITE_MASK(mode)) {
>>> +               case ACCESS_WRITE_IGNORED:
>>> +                       return;
>>> +
>>> +               case ACCESS_WRITE_SETBIT:
>>> +                       regval |= data;
>>> +                       break;
>>> +
>>> +               case ACCESS_WRITE_CLEARBIT:
>>> +                       regval &= ~data;
>>> +                       break;
>>> +
>>> +               case ACCESS_WRITE_VALUE:
>>> +                       regval = (regval & ~(mask << shift)) | data;
>>> +                       break;
>>> +               }
>>> +               *reg = regval;
>>> +       } else {
>>> +               switch (ACCESS_READ_MASK(mode)) {
>>> +               case ACCESS_READ_RAZ:
>>> +                       regval = 0;
>>> +                       /* fall through */
>>> +
>>> +               case ACCESS_READ_VALUE:
>>> +                       *((u32 *)mmio->data) = (regval >> shift) & mask;
>>> +               }
>>> +       }
>>> +}
>> 
>> As I mentioned previously, I suspect that this doesn't work with big-endian
>> systems. Whilst that's reasonable for the moment, a comment would be useful
>> for the unlucky soul that decides to do that work in future (or add
>> accessors for mmio->data as I suggested before).
>> 
> admittedly this really hurts my brain, but I think there's actually no
> problem with endianness: whatever comes in mmio->data will have native
> endianness

IIRC we have a local endianness flag on ppc. Once you introduce big endian guests, you can just add one too and add a CAP for it. I wouldn't worry about it now though.

Alex

> and the vgic is always little-endian, so a guest would have
> to make sure to do its own endianness conversion before writing data,
> or did I get this backwards? (some nasty feeling about if the OS is
> compiled in another endianness than the hardware everything may
> break).
> 
> Anyhow, I think there's another bug in this code though. Please take a
> look and see if you agree:
> 
> commit 3cab2b93a6f6acd3c043e584f23b94ab8f1bbd66
> Author: Christoffer Dall <c.dall@virtualopensystems.com>
> Date:   Mon Jan 14 15:55:18 2013 -0500
> 
>    KVM: ARM: Limit vgic read/writes to load/store length
> 
>    The vgic read/write operations did not consider ldrb/strb masks, and
>    would therefore unintentionally overwrite parts of a register.
> 
>    Consider for example a store of a single byte to a word-aligned address
>    of one of the priority registers, that would cause the 3 most
>    significant bytes to be overwritten with zeros.
> 
>    Cc: Marc Zyniger <marc.zyngier@arm.com>
>    Cc: Will Deacon <will.deacon@arm.com>
>    Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> 
> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
> index 25daa07..5c1bcf5 100644
> --- a/arch/arm/kvm/vgic.c
> +++ b/arch/arm/kvm/vgic.c
> @@ -233,6 +233,16 @@ static void vgic_cpu_irq_clear(struct kvm_vcpu
> *vcpu, int irq)
>              vcpu->arch.vgic_cpu.pending_shared);
> }
> 
> +static u32 mmio_data_read(struct kvm_exit_mmio *mmio, u32 mask)
> +{
> +    return *((u32 *)mmio->data) & mask;
> +}
> +
> +static void mmio_data_write(struct kvm_exit_mmio *mmio, u32 mask, u32 value)
> +{
> +    *((u32 *)mmio->data) = value & mask;
> +}
> +
> /**
>  * vgic_reg_access - access vgic register
>  * @mmio:   pointer to the data describing the mmio access
> @@ -247,8 +257,8 @@ static void vgic_cpu_irq_clear(struct kvm_vcpu
> *vcpu, int irq)
> static void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
>                phys_addr_t offset, int mode)
> {
> -    int shift = (offset & 3) * 8;
> -    u32 mask;
> +    int word_offset = (offset & 3) * 8;
> +    u32 mask = (1UL << (mmio->len * 8)) - 1;
>    u32 regval;
> 
>    /*
> @@ -256,7 +266,6 @@ static void vgic_reg_access(struct kvm_exit_mmio
> *mmio, u32 *reg,
>     * directly (ARM ARM B3.12.7 "Prioritization of aborts").
>     */
> 
> -    mask = (~0U) >> shift;
>    if (reg) {
>        regval = *reg;
>    } else {
> @@ -265,7 +274,7 @@ static void vgic_reg_access(struct kvm_exit_mmio
> *mmio, u32 *reg,
>    }
> 
>    if (mmio->is_write) {
> -        u32 data = (*((u32 *)mmio->data) & mask) << shift;
> +        u32 data = mmio_data_read(mmio, mask) << word_offset;
>        switch (ACCESS_WRITE_MASK(mode)) {
>        case ACCESS_WRITE_IGNORED:
>            return;
> @@ -279,7 +288,7 @@ static void vgic_reg_access(struct kvm_exit_mmio
> *mmio, u32 *reg,
>            break;
> 
>        case ACCESS_WRITE_VALUE:
> -            regval = (regval & ~(mask << shift)) | data;
> +            regval = (regval & ~(mask << word_offset)) | data;
>            break;
>        }
>        *reg = regval;
> @@ -290,7 +299,7 @@ static void vgic_reg_access(struct kvm_exit_mmio
> *mmio, u32 *reg,
>            /* fall through */
> 
>        case ACCESS_READ_VALUE:
> -            *((u32 *)mmio->data) = (regval >> shift) & mask;
> +            mmio_data_write(mmio, mask, regval >> word_offset);
>        }
>    }
> }
> @@ -702,6 +711,12 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu,
> struct kvm_run *run,
>        (mmio->phys_addr + mmio->len) > (base + KVM_VGIC_V2_DIST_SIZE))
>        return false;
> 
> +    /* We don't support ldrd / strd or ldm / stm to the emulated vgic */
> +    if (mmio->len > 4) {
> +        kvm_inject_dabt(vcpu, mmio->phys_addr);
> +        return true;
> +    }
> +
>    range = find_matching_range(vgic_ranges, mmio, base);
>    if (unlikely(!range || !range->handle_mmio)) {
>        pr_warn("Unhandled access %d %08llx %d\n",
> --
> 
> Thanks,
> -Christoffer
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

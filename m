From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Jan 2013 15:31:07 +0000
Subject: [PATCH v5 04/12] ARM: KVM: Initial VGIC infrastructure code
In-Reply-To: <20130108184150.46558.35674.stgit@ubuntu>
References: <20130108184116.46558.3558.stgit@ubuntu>
 <20130108184150.46558.35674.stgit@ubuntu>
Message-ID: <20130114153107.GE18935@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 06:41:51PM +0000, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Wire the basic framework code for VGIC support and the initial in-kernel
> MMIO support code for the VGIC, used for the distributor emulation.

[...]

> +/**
> + * vgic_reg_access - access vgic register
> + * @mmio:   pointer to the data describing the mmio access
> + * @reg:    pointer to the virtual backing of vgic distributor data
> + * @offset: least significant 2 bits used for word offset
> + * @mode:   ACCESS_ mode (see defines above)
> + *
> + * Helper to make vgic register access easier using one of the access
> + * modes defined for vgic register access
> + * (read,raz,write-ignored,setbit,clearbit,write)
> + */
> +static void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
> +                           phys_addr_t offset, int mode)
> +{
> +       int shift = (offset & 3) * 8;
> +       u32 mask;
> +       u32 regval;
> +
> +       /*
> +        * Any alignment fault should have been delivered to the guest
> +        * directly (ARM ARM B3.12.7 "Prioritization of aborts").
> +        */
> +
> +       mask = (~0U) >> shift;
> +       if (reg) {
> +               regval = *reg;
> +       } else {
> +               BUG_ON(mode != (ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED));
> +               regval = 0;
> +       }
> +
> +       if (mmio->is_write) {
> +               u32 data = (*((u32 *)mmio->data) & mask) << shift;
> +               switch (ACCESS_WRITE_MASK(mode)) {
> +               case ACCESS_WRITE_IGNORED:
> +                       return;
> +
> +               case ACCESS_WRITE_SETBIT:
> +                       regval |= data;
> +                       break;
> +
> +               case ACCESS_WRITE_CLEARBIT:
> +                       regval &= ~data;
> +                       break;
> +
> +               case ACCESS_WRITE_VALUE:
> +                       regval = (regval & ~(mask << shift)) | data;
> +                       break;
> +               }
> +               *reg = regval;
> +       } else {
> +               switch (ACCESS_READ_MASK(mode)) {
> +               case ACCESS_READ_RAZ:
> +                       regval = 0;
> +                       /* fall through */
> +
> +               case ACCESS_READ_VALUE:
> +                       *((u32 *)mmio->data) = (regval >> shift) & mask;
> +               }
> +       }
> +}

As I mentioned previously, I suspect that this doesn't work with big-endian
systems. Whilst that's reasonable for the moment, a comment would be useful
for the unlucky soul that decides to do that work in future (or add
accessors for mmio->data as I suggested before).

Will

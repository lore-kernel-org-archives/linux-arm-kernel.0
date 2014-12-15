From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 15 Dec 2014 11:32:25 +0000
Subject: [PATCH v5 15/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <20141213133707.GF16855@cbox>
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
 <1418042274-3246-16-git-send-email-andre.przywara@arm.com>
 <20141213133707.GF16855@cbox>
Message-ID: <548EC6C9.8020101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej Christoffer,

thanks for going through all of this ... again ;-)

On 13/12/14 13:37, Christoffer Dall wrote:
> On Mon, Dec 08, 2014 at 12:37:50PM +0000, Andre Przywara wrote:
>> With everything separated and prepared, we implement a model of a
>> GICv3 distributor and redistributors by using the existing framework
>> to provide handler functions for each register group.
>>
>> Currently we limit the emulation to a model enforcing a single
>> security state, with SRE==1 (forcing system register access) and
>> ARE==1 (allowing more than 8 VCPUs).
>>
>> We share some of the functions provided for GICv2 emulation, but take
>> the different ways of addressing (v)CPUs into account.
>> Save and restore is currently not implemented.
>>
>> Similar to the split-off of the GICv2 specific code, the new emulation
>> code goes into a new file (vgic-v3-emul.c).
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

[...]

>> diff --git a/virt/kvm/arm/vgic-v3-emul.c b/virt/kvm/arm/vgic-v3-emul.c
>> new file mode 100644
>> index 0000000..18af188
>> --- /dev/null
>> +++ b/virt/kvm/arm/vgic-v3-emul.c
>> @@ -0,0 +1,899 @@

[...]

>> +static unsigned long uncompress_mpidr(u32 value)
>> +{
>> +     unsigned long mpidr;
>> +
>> +     mpidr  = ((value >>  0) & 0xFF) << MPIDR_LEVEL_SHIFT(0);
>> +     mpidr |= ((value >>  8) & 0xFF) << MPIDR_LEVEL_SHIFT(1);
>> +     mpidr |= ((value >> 16) & 0xFF) << MPIDR_LEVEL_SHIFT(2);
>> +     mpidr |= (u64)((value >> 24) & 0xFF) << MPIDR_LEVEL_SHIFT(3);
>> +
>> +     return mpidr;
>> +}
>> +
>> +/*
>> + * Lookup the given MPIDR value to get the vcpu_id (if there is one)
>> + * and store that in the irq_spi_cpu[] array.
>> + * This limits the number of VCPUs to 255 for now, extending the data
>> + * type (or storing kvm_vcpu poiners) should lift the limit.
> 
> s/poiners/pointers/

Sorry and thanks for catching that. I accidentally merged the fix for
this in 17/19. Will fix this in the next revision.

>> + * Store the original MPIDR value in an extra array to support read-as-written.
>> + * Unallocated MPIDRs are translated to a special value and caught
>> + * before any array accesses.
>> + */
>> +static bool handle_mmio_route_reg(struct kvm_vcpu *vcpu,
>> +                               struct kvm_exit_mmio *mmio,
>> +                               phys_addr_t offset)
>> +{

[...]

>> +}
>> +
>> +static const struct kvm_mmio_range vgic_redist_sgi_ranges[] = {
>> +     {
>> +             .base           = GICR_IGROUPR0,
>> +             .len            = 0x04,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_raz_wi,
> 
> weren't we going to change this to handle_mmio_rao_wi()?

My bad, I missed this one (the distributor part is correct, though).

> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Thanks for that!

Cheers,
Andre.

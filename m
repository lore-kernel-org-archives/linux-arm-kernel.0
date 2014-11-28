From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 28 Nov 2014 15:24:11 +0000
Subject: [PATCH v4 15/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <20141125104129.GC31297@cbox>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-16-git-send-email-andre.przywara@arm.com>
 <20141123143841.GB3401@cbox> <5473562E.7060303@arm.com>
 <20141125104129.GC31297@cbox>
Message-ID: <5478939B.8010103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej Christoffer,

On 25/11/14 10:41, Christoffer Dall wrote:
> Hi Andre,
> 
> On Mon, Nov 24, 2014 at 04:00:46PM +0000, Andre Przywara wrote:
> 

[...]

>>>> +
>>>> +     /* This region only covers SPIs, so no handling of private IRQs here. */
>>>> +     spi = offset / 8;
>>>
>>> that's not how I read the spec, it says that GICD_IROUTER0 to
>>> GICD_IROUTER1 are not implemented (because they are SGIs and PPIs), and
>>> I read the 'SPI ID m' as the lowest numbered SPI ID being 32, thus you
>>> should do:
>>>
>>> spi = offset / 8 - VGIC_NR_PRIVATE_IRQS;
>>
>> Well, below I changed the description of the IROUTER range to:
> 
> oh, now it's finally coming back together for me, I think I
> misunderstodd your point from last rounds of review because I didn't
> realize that GICD_IROUTER was defined as 0x6000 (which I actually think
> is a bit backwards, but this is not the place or time).
> 
>> +     {
>> +             .base           = GICD_IROUTER + 0x100,
>> +             .len            = 0x1edc,
> 
> in that case, len should be 0x1ee0:
> 
>  $ printf '0x%x\n' $(( (0x7fd8 + 8) - 0x6100 ))

Ah yes, the spec gives the beginning of the last register, not the end
of the region. Thanks for spotting this!

[...]

>>>> +
>>>> +     if (!is_in_range(mmio->phys_addr, mmio->len, rdbase,
>>>> +         GIC_V3_REDIST_SIZE * nrcpus))
>>>> +             return false;
>>>
>>> Did you think more about the contiguous allocation issue here or can you
>>> give me a pointer to the requirement in the spec?
>>
>> 5.4.1 Re-Distributor Addressing
>>
> 
> Section 5.4.1 talks about the pages within a single re-distributor having
> to be contiguous, not all the re-deistributor regions having to be
> contiguous, right?

Ah yes, you are right. But I still think it does not matter:
1) We are "implementing" the GICv3. So as the spec does not forbid this,
we just state that the redistributor register maps for each VCPU are
contiguous. Also we create the FDT accordingly. I will add a comment in
the documentation to state this.

2) The kernel's GICv3 DT bindings assume this allocation is the default.
Although Marc added bindings to work around this (stride), it seems much
more logical to me to not use it.

>>>> +
>>>> +static int vgic_v3_init(struct kvm *kvm, const struct vgic_params *params)
>>>> +{
>>>> +     struct vgic_dist *dist = &kvm->arch.vgic;
>>>> +     int ret, i;
>>>> +     u32 mpidr;
>>>> +
>>>> +     if (IS_VGIC_ADDR_UNDEF(dist->vgic_dist_base) ||
>>>> +         IS_VGIC_ADDR_UNDEF(dist->vgic_redist_base)) {
>>>> +             kvm_err("Need to set vgic distributor addresses first\n");
>>>> +             return -ENXIO;
>>>> +     }
>>>> +
>>>> +     /*
>>>> +      * FIXME: this should be moved to init_maps time, and may bite
>>>> +      * us when adding save/restore. Add a per-emulation hook?
>>>> +      */
>>>
>>> progress on this fixme?
>>
>> Progress supplies the ISS, but not this piece of code (read: none) ;-)
>> I am more in favour of a follow-up patch on this one ...
> 
> hmmm, I'm not a fan of merging code with this kind of a comment in it,
> because it looks scary, and I dont' really understand the problem from
> just reading the comment, so something needs to be done here.

I see. What about we are moving this unconditionally into vgic_init_maps
and allocate it for both v2 and v3 guests and get rid of the whole
function? It allocates only memory for the irq_spi_mpidr, which is 4
bytes per configured SPI (so at most less than 4 KB, but usually just
128 Bytes per guest). This would be a pretty quick solution. Does that
sound too hackish?

After your comments about the per-VM ops function pointers I am a bit
reluctant to introduce another one (which would be the obvious way
following the comment) for just this simple kalloc().
On the other hand the ITS emulation may later make better use of a GICv3
specific allocation function.

What's your opinion on this?

Cheers,
Andre.

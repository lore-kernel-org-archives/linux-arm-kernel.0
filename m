From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Jan 2017 12:03:00 +0000
Subject: APM smmu implementation
In-Reply-To: <d9e40de8-82e2-0f19-5b99-d756ded21e80@arm.com>
References: <CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g@mail.gmail.com>
 <d9e40de8-82e2-0f19-5b99-d756ded21e80@arm.com>
Message-ID: <20170109120300.GC21398@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 11:34:42AM +0000, Robin Murphy wrote:
> On 06/01/17 23:21, Feng Kan wrote:
> > The APM IOMMU implementation is mostly just the ARM SMMU 500 variant.
> 
> "Mostly"? Have APM actually modified it (which I strongly doubt) or do
> you mean it's simply been integrated with the upper address lines tied
> off? MMU-500 reports a 48-bit IAS because MMU-500 has 48-bit-wide slave
> interfaces; that's all there is to it. Whether or not you use all of
> those bits is up to you as a system integrator.

That's a good point; MMU-500 doesn't appear to let you change the IAS
anyway. That should also mean that UBS and OAS are unchanged.

> > However, our internal bus is only 42 bits wide. Our IAS field is coded
> > as 48 bits, which cause IPA to truncated to 42 bits on the physical
> > bus. In order for our system to work with the arm-smmu.c, there needs
> > to be a way to force the ipa_size to 42. The current internal solution
> > is to use the cpuid, but that is quite ugly. I was thinking of using
> > the model
> > as indication to right the ipa_size, but I am not too sure of the ACPI
> > side. Would it be okay to add an APM MMU500 variant? I would also
> > appreciated it if you guys have any alternate solutions.
> 
> This is something we've been axpecting to run into for a while now - the
> appropriate solution is to use a "dma-ranges" property on the master
> device(s) to describe that they have 42 bits of address wired up, from
> which they will then inherit the appropriate DMA mask. The outstanding
> issue which remains is that we're still missing some way of preventing
> drivers simply clobbering that with a 64-bit mask later, but that's a
> more general problem[1].

I wonder if the driver is actually using IAS, OAS and UBS incorrectly.
We're using them to parameterise the DMA aperture, which is then used
to size the IOVA domain, but that's wrong because the IAS, OAS and UBS
are upper bounds and we can still end up allocating unusable/unreachable
addresses.

So I do think that this should be fixed on the SMMU firmware node, rather
than restricting the range of each master device.

Will

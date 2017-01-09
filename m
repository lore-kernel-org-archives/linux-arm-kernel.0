From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 9 Jan 2017 11:34:42 +0000
Subject: APM smmu implementation
In-Reply-To: <CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g@mail.gmail.com>
References: <CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g@mail.gmail.com>
Message-ID: <d9e40de8-82e2-0f19-5b99-d756ded21e80@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/17 23:21, Feng Kan wrote:
> Hi Will/Robin:
> 
> The APM IOMMU implementation is mostly just the ARM SMMU 500 variant.

"Mostly"? Have APM actually modified it (which I strongly doubt) or do
you mean it's simply been integrated with the upper address lines tied
off? MMU-500 reports a 48-bit IAS because MMU-500 has 48-bit-wide slave
interfaces; that's all there is to it. Whether or not you use all of
those bits is up to you as a system integrator.

> However, our internal bus is only 42 bits wide. Our IAS field is coded
> as 48 bits, which cause IPA to truncated to 42 bits on the physical
> bus. In order for our system to work with the arm-smmu.c, there needs
> to be a way to force the ipa_size to 42. The current internal solution
> is to use the cpuid, but that is quite ugly. I was thinking of using
> the model
> as indication to right the ipa_size, but I am not too sure of the ACPI
> side. Would it be okay to add an APM MMU500 variant? I would also
> appreciated it if you guys have any alternate solutions.

This is something we've been axpecting to run into for a while now - the
appropriate solution is to use a "dma-ranges" property on the master
device(s) to describe that they have 42 bits of address wired up, from
which they will then inherit the appropriate DMA mask. The outstanding
issue which remains is that we're still missing some way of preventing
drivers simply clobbering that with a 64-bit mask later, but that's a
more general problem[1].

Robin.

[1]:https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg10209.html

> 
> Thanks
> Feng Kan
> 

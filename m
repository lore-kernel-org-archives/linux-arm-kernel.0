From: lee@kernel.org (Lee Jones)
Date: Wed, 13 May 2015 09:51:19 +0100
Subject: [PATCH] ARM: bcm2835: Use 0x4 prefix for DMA bus addresses to
 SDRAM.
In-Reply-To: <87wq0mol7e.fsf@eliezer.anholt.net>
References: <1430768034-12734-1-git-send-email-eric@anholt.net>
 <55491A12.3070608@wwwdotorg.org>
 <87wq0mol7e.fsf@eliezer.anholt.net>
Message-ID: <20150513085119.GD3394@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 05 May 2015, Eric Anholt wrote:

> Stephen Warren <swarren@wwwdotorg.org> writes:
> 
> > On 05/04/2015 01:33 PM, Eric Anholt wrote:
> >> There exists a tiny MMU, configurable only by the VC (running the
> >> closed firmware), which maps from the ARM's physical addresses to bus
> >> addresses.  These bus addresses determine the caching behavior in the
> >> VC's L1/L2 (note: separate from the ARM's L1/L2) according to the top
> >> 2 bits.  The bits in the bus address mean:
> >>
> >>  From the VideoCore processor:
> >> 0x0... L1 and L2 cache allocating and coherent
> >> 0x4... L1 non-allocating, but coherent. L2 allocating and coherent
> >> 0x8... L1 non-allocating, but coherent. L2 non-allocating, but coherent
> >> 0xc... SDRAM alias. Cache is bypassed. Not L1 or L2 allocating or coherent
> >>
> >>  From the GPU peripherals (note: all peripherals bypass the L1
> >> cache. The ARM will see this view once through the VC MMU):
> >> 0x0... Do not use
> >> 0x4... L1 non-allocating, and incoherent. L2 allocating and coherent.
> >> 0x8... L1 non-allocating, and incoherent. L2 non-allocating, but coherent
> >> 0xc... SDRAM alias. Cache is bypassed. Not L1 or L2 allocating or coherent
> >>
> >> The 2835 firmware always configures the MMU to turn ARM physical
> >> addresses with 0x0 top bits to 0x4, meaning present in L2 but
> >> incoherent with L1.  However, any bus addresses we were generating in
> >> the kernel to be passed to a device had 0x0 bits.  That would be a
> >> reserved (possibly totally incoherent) value if sent to a GPU
> >> peripheral like USB, or L1 allocating if sent to the VC (like a
> >> firmware property request).  By setting dma-ranges, all of the devices
> >> below it get a dev->dma_pfn_offset, so that dma_alloc_coherent() and
> >> friends return addresses with 0x4 bits and avoid cache incoherency.
> >>
> >> This matches the behavior in the downstream 2708 kernel (see
> >> BUS_OFFSET in arch/arm/mach-bcm2708/include/mach/memory.h).
> >
> >> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
> >
> >>   		#address-cells = <1>;
> >>   		#size-cells = <1>;
> >>   		ranges = <0x7e000000 0x20000000 0x02000000>;
> >> +		dma-ranges = <0x40000000 0x00000000 0x1f000000>;
> >
> > Oh well that's a nice and simple patch; I had been avoiding looking into 
> > fixing the kernel for this since I was worried it'd be rather complex!
> >
> > I'm puzzled why the length cell of ranges and dma-ranges differs though? 
> > Assuming there's a good explanation for that,
> 
> Nope, you're right, it should be 0x20000000.  '0x1f' came from going
> back from the '0x3f' on the pi2, but pi2 just has a chunk lost to the
> bus mapping.

So are you going to fix this and send another patch?

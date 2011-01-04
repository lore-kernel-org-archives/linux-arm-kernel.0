From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Jan 2011 20:17:08 +0000
Subject: [PATCH 1/4] ARM: runtime patching of __virt_to_phys() and
	__phys_to_virt()
In-Reply-To: <8ya39p8h4ui.fsf@huya.qualcomm.com>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-2-git-send-email-nico@fluxnic.net>
	<20110104084517.GA9791@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101040926100.22191@xanadu.home>
	<20110104165347.GA24935@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101041225070.22191@xanadu.home>
	<20110104180620.GC24935@n2100.arm.linux.org.uk>
	<8yahbdoh6fs.fsf@huya.qualcomm.com>
	<alpine.LFD.2.00.1101041330450.22191@xanadu.home>
	<8ya39p8h4ui.fsf@huya.qualcomm.com>
Message-ID: <20110104201708.GD24935@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 11:00:05AM -0800, David Brown wrote:
> On Tue, Jan 04 2011, Nicolas Pitre wrote:
> 
> > On Tue, 4 Jan 2011, David Brown wrote:
> >
> >> Any idea how much it would hurt other targets to have the
> >> __virt_to_phys() and __phys_to_virt() have a 16-bit fixup, even if only
> >> the upper 8 bits are used?
> >
> > Probably not that much.  But let's make it work satisfactorily for the 
> > general case first, and then we might consider and test variations that 
> > could accommodate msm.
> 
> Sounds like a good plan.  We've got quite a few other things to clean up
> before we can build for more than one arch anyway.

Actually, we can do this quite easily.  Having a config symbol which
gets enabled when MSM is added, which then enables two consecutive
__pv_fixups gives us 16-bits to play with.

As I originally intended with my implementation, the value field of the
instruction can be used to identify what this fixup is about - and we
can put that to use by selecting either bits 31-24 or 23-16 of the
offset value.

This still allows optimizations to happen with instruction scheduling -
eg, for the MSM kernel I've just built with this enabled:

c000b320:       e2844001        add     r4, r4, #1      ; 0x1
c000b324:       e59f3264        ldr     r3, [pc, #612]  ; c000b590 <setup_arch+0x690>
c000b328:       e2844000        add     r4, r4, #0      ; 0x0
c000b32c:       e2833001        add     r3, r3, #1      ; 0x1
c000b330:       e59f5228        ldr     r5, [pc, #552]  ; c000b560 <setup_arch+0x660>
c000b334:       e2833000        add     r3, r3, #0      ; 0x0

The first and second adds comprise one translation, the second pair are
a second translation, and as you can see, the compiler scheduled the
loads inbetween.

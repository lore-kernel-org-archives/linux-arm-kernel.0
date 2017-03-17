From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Mar 2017 15:05:57 +0000
Subject: [PATCH] arm: kprobes: Align stack to 8-bytes in test code
In-Reply-To: <1489761729.3063.7.camel@linaro.org>
References: <20170316135359.23019-1-tixy@linaro.org>
 <20170317121025.GD21222@n2100.armlinux.org.uk>
 <1489755542.3063.2.camel@linaro.org>
 <20170317140610.GF21222@n2100.armlinux.org.uk>
 <1489761729.3063.7.camel@linaro.org>
Message-ID: <20170317150557.GI21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 02:42:09PM +0000, Jon Medhurst (Tixy) wrote:
> On Fri, 2017-03-17 at 14:06 +0000, Russell King - ARM Linux wrote:
> > On Fri, Mar 17, 2017 at 12:59:02PM +0000, Jon Medhurst (Tixy) wrote:
> > > 
> [...]
> > > It isn't, because GCC turns code like this
> > > 
> > > void foo(void)
> > > {
> > >         asm volatile("bl __kprobes_test_case_start"
> > >                      : : : "r0", "r1", "r2", "r3", "ip", "lr", "memory", "cc");
> > > }
> > > 
> > > into this...
> > > 
> > > 8010e4ac <foo>:
> > > 8010e4ac:       e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
> > > 8010e4b0:       eb002c99        bl      8011971c <__kprobes_test_case_start>
> > > 8010e4b4:       e49df004        pop     {pc}            ; (ldr pc, [sp], #4)
> > > 
> > > Perhaps we need a way of telling GCC we are using the stack but I've not
> > > managed to spot a way of doing that.
> > 
> > Using which compiler options?
> 
> The ones the Linux makefile picks when building with vexpress_defconfig.
> I hacked a kernel file to build the above example but the behaviour is
> what I observed with the real kprobes code. I've pasted the commanline
> produced by building with V=1 at the end of this email.
> 
> One thing I've noticed playing around just now is that if I add "sp" to
> the clobber list, and use a newer GCC (gcc-linaro-6.2.1-2016.11) then it
> does allign the stack correctly. "sp" makes no difference with GCC 5.3 or
> 4.8.

Meanwhile the kernel images I have here all have code to align the stack
after pushing registers in functions, except for __csum_ipv6_magic and
__memzero, which are both assembly.  That's gcc 4.7.4 building iMX6 only
(which is also armv7-a.)

I suspect we're into compiler behavioural differences, which can't be
relied upon, so I guess we do need to do something in
__kprobes_test_case_start() to work around it.

I'd do:

	mov	ip, sp
	tst	sp, #4
	subeq	sp, sp, #4		@ need to mis-align as we don't save
	stmfd	sp!, {r4 - r11, ip}	@ an even number of registers to end
	sub	sp, sp, #size		@ up with an aligned stack here

and when restoring:

	add	ip, sp, #size
	ldmfd	ip, {r4 - r11, sp}
	bx	r0

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

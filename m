From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 13 May 2011 09:39:39 +0200 (CEST)
Subject: [PATCH] ARM: Make sure appended device tree data won't overlap
	kernel BSS
In-Reply-To: <20110512125952.GN31483@atomide.com>
References: <alpine.LFD.2.00.1104271036520.24613@xanadu.home>
	<20110427144335.GK3755@atomide.com> <20110429102623.GX3755@atomide.com>
	<alpine.LFD.2.00.1104290909310.24613@xanadu.home>
	<20110429135334.GR5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104291509540.24613@xanadu.home>
	<20110504072317.GU2092@atomide.com>
	<alpine.LFD.2.00.1105040936040.24613@xanadu.home>
	<20110509111929.GA11410@atomide.com>
	<20110509144949.GE30958@atomide.com>
	<20110512125952.GN31483@atomide.com>
Message-ID: <alpine.LFD.2.00.1105130930330.2762@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 May 2011, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [110509 07:47]:
> > * Tony Lindgren <tony@atomide.com> [110509 14:16]:
> > > Do this before relocating the compressed kernel + device tree data.
> > > Otherwise we would have to split the copying into two parts, or copy
> > > the device tree data twice.
> > > 
> > > As we only have one register available, pass the size of kernel BSS
> > > via linker and do the following calculation using r1.
> > 
> > Blah, this still needs a bit more work.. The calculation is wrong
> > and we can get multiple relocations now.
> 
> Here's a better version that also makes the stack usable early.
> That might become handy for further changes.
> 
> Will still do a bit more testing on this on Friday.
> 
> Tony
> 
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Thu, 12 May 2011 05:29:49 -0700
> Subject: [PATCH] ARM: Make sure appended device tree data won't overlap kernel BSS
> 
> Do this before relocating the compressed kernel + device tree data.
> Otherwise we would have to split the copying into two parts, or copy
> the device tree data twice.
> 
> As we only have one register available, pass the size of kernel BSS
> via linker and do the calculation using r1, then save it to the stack.
> 
> Note that this patch now makes the stack also usable earlier for
> CONFIG_ARM_APPENDED_DTB.
> 
> Not-Yet-Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -98,6 +98,9 @@ endif
>  ccflags-y := -fpic -fno-builtin
>  asflags-y := -Wa,-march=all
>  
> +# Supply kernel BSS size to the decompressor via a linker symbol.
> +KBSS_SZ = $(shell size $(obj)/../../../../vmlinux | awk 'END{print $$3}')
> +LDFLAGS_vmlinux = --defsym _kbss_sz=$(KBSS_SZ)
>  # Supply ZRELADDR to the decompressor via a linker symbol.
>  ifneq ($(CONFIG_AUTO_ZRELADDR),y)
>  LDFLAGS_vmlinux += --defsym zreladdr=$(ZRELADDR)
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -266,6 +266,25 @@ restart:	adr	r0, LC0
>  		add	lr, lr, #7
>  		bic	lr, lr, #7
>  
> +		/*
> +		 * Compensate for the appended device tree and make stack
> +		 * usable. Note if the linker script changes so the stack is
> +		 * not after the bss section, this code will be wrong.
> +		 */
> +		add	sp, sp, lr
> +
> +		/*
> +		 * Calculate and save the offset between kernel BSS end and
> +		 * device tree data start for later use to check they won't
> +		 * overlap.
> +		 */
> +		adr	r1, kbss_sz
> +		ldr	r1, [r1, #0]		@ kernel BSS size
> +		add	r1, r1, r4		@ add inflated kernel start
> +		add	r1, r1, r9		@ add inflated kernel size
> +		sub	r1, r1, r6		@ kbss end - dt start
> +		str	r1, [sp, #0]		@ save offset into stack

This is actually outside the stack area if you want to be strictly 
correct.  Should be "str r1, [sp, #-4]!".

Anyway, both this patch tand the DT append patch won't apply or work 
correctly anymore due to my latest cleanup series without minor 
adjustments.


Nicolas

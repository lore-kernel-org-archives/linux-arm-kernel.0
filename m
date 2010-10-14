From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Thu, 14 Oct 2010 10:29:09 -0500
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <AANLkTinu3wL536szc2mxe3HTAz9yduDHnOU+oP_wOHT-@mail.gmail.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<20101008231926.GA28235@kroah.com>
	<alpine.LFD.2.00.1010082242390.3107@xanadu.home>
	<AANLkTi=BvXROFEnzYykoUQNbU05Q=mWoV3t7qKDk7+vL@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE896716203D760F19C@dlee02.ent.ti.com>
	<AANLkTinu3wL536szc2mxe3HTAz9yduDHnOU+oP_wOHT-@mail.gmail.com>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203D768A12D@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Felipe Contreras [mailto:felipe.contreras at gmail.com]
> Sent: Thursday, October 14, 2010 8:48 AM

> > On a Cortex-A8 if you enable auxcr.asa speculative accesses will be allowed
> to happen more broadly (cross outside of L2).  There are few failures which
> have been seen in testing which go away with its disable. Most Linux kernels
> have this feature off.  They still prefetch but with reduced scope.
>
> I see, do you have some pointers as how to enable this to try it out?

It is bit4 of auxcr register for cortexa8. It is in the same register which enables L2 cache. The L2 bit is banked so can be accessed with normal MCR/MRC.  The other bits in this register for OMAP3 require a trustzone management smc/smi call to access. Setting the bit in the boot loader may be good enough. Code over time accessed the register in different spots so depending on your build you might be tricked. After OFF mode for MPU the register does get restored if value was saved correctly.

On OMAP the management API to call this register may vary across EMU/HS implementations. TI provided a reference for people but that doesn't mean it was followed 100%. GP devices have the same API for access.

Something like this modified u-boot extract might work for a GP device. You need to see what your device does. A N900 likely sets parameters up differently.

        /* Save r0, r12 and restore them after usage */
        __asm__ __volatile__("mov %0, r12":"=r" (j));
        __asm__ __volatile__("mov %0, r0":"=r" (i));

        /* GP Device ROM code API usage here */
        /* r12 = AUXCR Write function and r0 value */
        __asm__ __volatile__("mov r12, #0x3");
        __asm__ __volatile__("mrc p15, 0, r0, c1, c0, 1");
        __asm__ __volatile__("orr r0, r0, #0x10");  /* or in ASA bit */
        /* SMI instruction to call ROM Code API */
        __asm__ __volatile__(".word 0xE1600070");
        __asm__ __volatile__("mov r0, %0":"=r" (i));

> However, nobody is proposing to not kill the ioremap() double alias,
> only to make it a warning for now. One argument against this is that
> would cause corruption on other parts of the system which doesn't seem
> to be the case.

Maybe in your usage it has not been an issue. I have some visibility across diverse 'communities' and their issues are not always overlapping. For A8 we did have to shut down ASA for one group, other groups never reported any issue.

The probability of the problem impacting goes up with each higher performing v7.  Someone probably could construct a failure sequence even on A8. However, it may not exist in typical code today.  With A9 and A15 coming on this kind of thing needs fixing to head off pain.

> I take it you don't have a problem with making this a warning on .36,
> and disable completely on .37 (or later). Right?

Staging it seems reasonable.  It was kind of staged but ignored.

FWIW Russell seems to doing the right thing for the v7 code base against the big picture.

> The real issue is the drivers relying on this behavior, which need to
> be fixed regardless of this decision to warn, or disable.

Yes, a few drivers need updating. If you dump a few active systems mmu tables you find a few places which need changes for attribute alias. Ioremap was one generating a lot of these and was a good fix.

Regards,
Richard W.

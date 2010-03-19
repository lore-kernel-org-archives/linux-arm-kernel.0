From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Fri, 19 Mar 2010 14:54:44 -0500
Subject: [PATCH 1/2] arm: disable L2 cache in the v7 finish function
In-Reply-To: <20100310215321.GP2900@atomide.com>
References: <1268143623-22361-1-git-send-email-saeed@marvell.com>
	<1268143623-22361-2-git-send-email-saeed@marvell.com>
	<20100310215321.GP2900@atomide.com>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203BA3AE030@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Tony Lindgren
> Sent: Wednesday, March 10, 2010 3:53 PM

> > +#ifdef CONFIG_OUTER_CACHE
> > +   mrc     p15, 0, r0, c1, c0, 1
> > +   bic     r0, r0, #0x2
> > +   mcr     p15, 0, r0, c1, c0, 1           @ disable L2 cache
> > +#endif
> >     ldmfd   sp!, {pc}
> >  ENDPROC(cpu_v7_proc_fin)
>
> This one is a bit tricky. I know of three different ways
> to disable the L2 cache depending on the hardware. One of
> them is what you have above. The second is via SMI, and
> then the first one won't work. The third is via external
> secure monitor calls used on some omaps at least. And in
> the third case the first two methods won't work.

On A8 cores with integrated L2 cache the L2EN bit is banked after r0px series (you won't find r0 systems anywhere). As such the above code is good on OMAP3 and many other A8's.  Other bits in this same register have issues which you warn of.  But not the L2EN.

On A9 which uses outer cache the above won't work.  The external PL310 (or variant) is memory mapped.  To handle a different sequence is needed all together.

Regards,
Richard W.

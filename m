From: mirq-linux@rere.qmqm.pl (=?iso-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Thu, 20 Jul 2017 18:52:10 +0200
Subject: [RFC WIP PATCH] arm: early console using bootloader framebuffer
In-Reply-To: <20170720162751.GD31807@n2100.armlinux.org.uk>
References: <2a6c81485f354415a9f91ff1ef28340844396c48.1500566451.git.mirq-linux@rere.qmqm.pl>
 <20170720162751.GD31807@n2100.armlinux.org.uk>
Message-ID: <20170720165210.aqjnossmii2dw7zb@qmqm.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 05:27:51PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 20, 2017 at 06:03:51PM +0200, Micha? Miros?aw wrote:
> > HACK WARNING:
> >  - the asm code is not tested
> >  - maybe should use fixmap?
> >  - there's something similar called efifb in x86 arch
> 
> Hi.
> 
> I guess this is useful for some people, but I have concerns.
> 
> This shouldn't be done in terms of the "DEBUG_LL" stuff.  The DEBUG_LL
> stuff is not designed to be multi-platform, it's designed as a last-ditch
> method of debugging when other forms of kernel output have failed.  The
> main requirement of the DEBUG_LL stuff is that it's usable from very
> early on in the kernel assembly code, like from the first few
> instructions in head.S, when the MMU is off.  This imposes quite a few
> restrictions on the code.
> 
> Your code is not going to work with the MMU off, since you get the
> virtual address of the 8x8 font, which is meaningless.
> 
> Rather than trying to bolt a framebuffer into the DEBUG_LL stuff,
> please instead make the early printk support switchable between a
> "DEBUG_LL" implementation and a framebuffer implementation.  It can
> then live in early_printk.c rather than being spread around.
> 
> It seems that you may have already realised that, but not cleaned the
> patch up - it's difficult to tell.  So, I think you need to remove
> everything you don't need and re-submit.
> 
> > +	.macro	senduart, rd, rx, tmp1, tmp2
> > +//	pushbyte \rd, \rx, \tmp1, \tmp2
> > +	.endm
> 
> This commenting out disables the framebuffer code.

Thanks for your review. I forgot about the font_stuff, and went on
to just drawing squares for the before-MMU debugging. I'll split
this part off.

> > +static void bootfb_stop(struct bootfd_tmp *info)
> > +{
> > +	unsigned short *p = info->ctl;
> > +	unsigned short y = info->y, xoff = info->xoff;
> > +
> > +	if (xoff >= LINE_END) {
> > +		if (++y >= FB_CHARS_HEIGHT) {
> > +			y = 0;
> > +			if (CONFIG_DEBUG_BOOTFB_PAGE_DELAY_MS)
> > +				mdelay(CONFIG_DEBUG_BOOTFB_PAGE_DELAY_MS);
> 
> printk() can be called in non-schedulable contexts, mdelay requires a
> context that can schedule.  Therefore, you can't use mdelay() here.

Wasn't msleep() the schedulable one, and mdelay() a busy-wait loop?

Best Regards,
Micha??Miros?aw

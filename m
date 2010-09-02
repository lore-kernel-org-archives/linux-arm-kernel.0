From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Sep 2010 15:55:42 +0200
Subject: [RFC] [PATCH v2] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <20100902134732.GL26319@n2100.arm.linux.org.uk>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
	<1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<20100902132641.GI14214@pengutronix.de>
	<20100902134732.GL26319@n2100.arm.linux.org.uk>
Message-ID: <20100902135542.GJ14214@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Sep 02, 2010 at 02:47:32PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 02, 2010 at 03:26:41PM +0200, Uwe Kleine-K?nig wrote:
> > I'm not very satisfied by Russell's answer.  But even if I accept that
> > it should not move to .init.text, why .ref.text?  If I'm not mistaken
> > clkdev_alloc references the following non-local symbols:
> > 
> > 	__clkdev_alloc
> > 	strlcpy
> > 	vscnprintf
> 
> __clkdev_alloc() is an inline function, so effectively it's part of this
> function.  On sh, this calls the boot time allocator which is marked as
> __init if the normal memory allocators aren't online yet.
ah, OK, so I suggest to do

	#ifdef CONFIG_SH
	__ref
	#endif

Just kidding :-)

> > Russell, would at least __module_or_init be OK?
> 
> It's a conceptual thing - we want to allow people to create aliases at
> run time.  Making it an __init thing will only encourage people to do
> silly things to work around the "it can only be used at init time"
> problem rather than taking the obvious step of removing the __init tag.
OK, thanks for your explanation.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

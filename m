From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 9 Jul 2010 21:46:38 +0200
Subject: [PATCH 2/2] pxa/spitz: Rework spitz
In-Reply-To: <20100709190741.GA1669@ucw.cz>
References: <1276238740-10640-1-git-send-email-marek.vasut@gmail.com>
	<201006111752.08130.marek.vasut@gmail.com>
	<20100709190741.GA1669@ucw.cz>
Message-ID: <201007092146.38882.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 9. ?ervence 2010 21:07:41 Pavel Machek napsal(a):
> Hi!
> 
> > > > > 1) Made every part modular, components are not built in if not
> > > > > selected. 2) Removed loads of preprocessor goo, mostly "#ifdef
> > > > > MACH_AKITA .... #endif" and similar code. The kernel size will grow
> > > > > by a few kb now, but the file is much more readable.
> > > > > 3) Reworked SD/CF power setting function and made it reentrant.
> > > > > 
> > > > > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > > > > ---
> > > > > 
> > > > >  arch/arm/mach-pxa/include/mach/spitz.h |    2 -
> > > > >  arch/arm/mach-pxa/spitz.c              |  748
> > > > > 
> > > > > ++++++++++++++++++-------------- 2 files changed, 420
> > > > > insertions(+), 330 deletions(-)
> > > > 
> > > > Pavel, Eric, I tested this on metan's Z, could you give it a go ?
> > > 
> > > quick test on 2.6.35-rc2 (of the 2nd version), and all seems
> > > well. What should I look for?
> > 
> > Nothing, the functionality should be the same ... I just felt like it
> > needs rework, it was frustrating digging in it in the state it is in
> > now. The way it is now it's much easier to hack on it. There are still
> > open issues:
> > 
> > 1) CPUfreq on Zaurus is still broken. (doesn't work on other devices -
> > causes freezes)

This is fixed, was caused by PCMCIA. Fix for that is in Eric's -fix or -devel 
branch already.

> > 2) PCMCIA driver looses interrupts. (pcmcia-sharpsl needs rework)
> 
> hda timeouts?

Yea ... PCMCIA problem as well.
> 
> > 3) We need driver for the CPU PMIC. (I already wrote it)
> 
> Can you cc me on that one? That should fix the random segfaults, right?

Segfaults were caused by pcmcia too I think. But the regulator driver is already 
in regulator tree.

> 
> > 4) Weird mess on the LCD when using DMA (also happens on other devices)
> > 
> > So we'll have at least another four following patches sometimes later.
> > 
> > Pavel, can we get this in? Can I get your Ack and get this one applied?
> > Thanks
> 
> Sorry, I was busy... 2) mixes all kinds of things together -- it would
> be better to split such patches in future, but yes, it looks ok.

Yea, I know this patch is kind of big and beefy ... I've been busy as well, 
that's why this patch is such a crap, but really, we kind of need this in. I 
believe after we have these two (zaurus-rework) patches in, things will be a 
little calmer for a while.

That is, until someone starts digging around sharpsl-pm and spitz-pm, which 
seriously is totally terrible code. The horror it gave me was worse than talking 
to tired Russell ;-)

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Oct 2010 20:42:55 +0100
Subject: [PATCH .36-rc8] arm: mm: allow, but warn, when issuing
	ioremap() on RAM
In-Reply-To: <1287153021.27165.6.camel@e102109-lin.cambridge.arm.com>
References: <1287152120-7201-1-git-send-email-felipe.contreras@gmail.com>
	<1287153021.27165.6.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20101015194255.GA12981@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 15, 2010 at 03:30:21PM +0100, Catalin Marinas wrote:
> Hi Felipe,
> 
> On Fri, 2010-10-15 at 15:15 +0100, Felipe Contreras wrote:
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > Drivers have been relying on this behavior, but done so wrongly.
> > However, rather than breaking drivers from .35 to .36, we should warn on
> > .36 and only break on .37. This way we give a chance for contributors to
> > fix the issues.
> > 
> > According to ARM, the behavior of having multiple mappings is
> > unspecified from ARMv6+. This causes real issues specially on modern
> > hardware, and specially with speculative prefetching. So drivers need to
> > be fixed.
> > 
> > Also, since current hardware has palliative meassures to deal with
> > multiple mappings with the same memory type but diferent cacheability
> > attributes, ensure that such restriction is taking place.
> > 
> > Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Richard Woodruff <r-woodruff2@ti.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> 
> I just showed a partial workaround but I did not sign off my patch. Not
> sure if just posting a code snippet counts as an explicit signed-off-by.

It doesn't, and that's a sign of bad practice.  Given the legal implications
of Signed-off-by, this is not something _anyone_ should be adding for
addresses other than their own - otherwise it's a plain and simple lie.

> And one of the reasons is that this patch is incomplete. You still
> create a mapping alias (though now with the same memory type and
> different cacheability attributes) but there isn't anything to take care
> of the potential dirty cache lines in the original alias (e.g. kernel
> linear mapping). You can easily end up with data corruption.

It seems that the overall feeling from those in the know (iow, those
who work for companies who know the processor IP) is that the behaviour
we _had_ until -rc8 was the right one.

It's now been relaxed in -rc8 against those people's better judgement,
and issues a big fat textual three line warning about it which is probably
going to make users panic about it.  (Any warn-on dump also makes users
panic, but the three lines explaining it will probably give them a heart
attack too!)

As soon as the first ARM merge hits during the merge window, I'll be
restoring the 'always fail' behaviour.

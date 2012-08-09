From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 9 Aug 2012 18:36:28 +0100
Subject: The curse of EPROBE_DEFER
In-Reply-To: <20120809163105.GU18957@n2100.arm.linux.org.uk>
References: <20120809163105.GU18957@n2100.arm.linux.org.uk>
Message-ID: <20120809173628.GY24328@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 05:31:05PM +0100, Russell King - ARM Linux wrote:

> Okay, so we have this wonderful new feature called EPROBE_DEFER.  I
> had in the back of my mind while at the meetup in Prague where this
> was discussed that it would cause problems... of the type I'm now
> having, which is:

Well, it's not really an issue in probe deferral per se - it's an issue
in ASoC and something we have to watch out for in other users.

> soc-audio soc-audio: Failed to register card

This is bitrot, should be killed.  It was a bit more useful with our
custom deferred probe but since we routinely fail it's completely
useless now, as you say we need more specific logging.

> repeated many times in the kernel messages, but there's _zero_ clue
> as to why, and unless I enable debugging in sound/soc through a kernel
> rebuild, there's little chance of finding out.

There's also the option of doing a contrast and compare between the card
definition and the lists of registered things in debugfs but that's
obviously not something we should expect the general audience to work
with.

> This is idiotic, and fragile, and completely mad.  If we're going to
> have EPROBE_DEFER at least have the curtesy to your users to say *why*
> you're failing the probe, and *not* at the (by default) invisible debug
> level.  I mean, saying that the probe failed but not saying *why* is
> utterly stupid.

The reason that the log messages are debug level is that back when
nobody though probe deferral would ever be useful people complained
about the log spam from probe deferral and didn't want to know that
anyone might need it.  Obviously this no longer applies - not only do we
now have probe deferral in the core but it's chatty anyway so we may as
well add some diagnostic information on top of it.

Anyway, thanks for noticing this.  I've just upgraded the severity of
all the logs from probe deferral to dev_err(), a patch should show up on
the list and in -next tomorrow or the day after.

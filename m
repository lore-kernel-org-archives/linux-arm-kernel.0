From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Apr 2015 19:54:20 +0100
Subject: [PATCH 0/2] Cygnus Audio Driver
In-Reply-To: <55249258.1020907@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <20150331064338.GE2869@sirena.org.uk>
 <551EEAF8.7050108@broadcom.com>
 <20150406095803.GD6023@sirena.org.uk>
 <55249258.1020907@broadcom.com>
Message-ID: <20150408185420.GH6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 07, 2015 at 07:28:40PM -0700, Lori Hikichi wrote:
> On 15-04-06 02:58 AM, Mark Brown wrote:

> >OK, then it's going to need to be a clock provider at some point - the
> >clock will be going into external devices which are going to need to be
> >able to interact with the clock (for example, to get the rate).

> Currently, the ASoC machine driver is responsible for requesting a certain
> frequency of MCLK be generated from our driver and then also sending the
> frequency information along to the external device (codec).
> This is done via the snd_soc_dai_set_sysclk.  That is the only clock
> interaction we have needed for the core part of the driver.  For enhanced

I have some passing familiarity with ASoC...  if you look at newer
drivers, especially those for DT systems, you'll see that we're
transitioning CODEC drivers to use the clock API for their clocks since
this makes integrating with both generic ASoC things like simple card
and non-ASoC clocks.

> features, we also have the need to make minor adjustments (tweaks) to the
> PLL.  The tweaks are used to make the PLLs output frequency match as closely
> as possible to a true reference frequency. As such, we would like to provide
> the finest adjustment resolution as possible. The clocking framework only
> seems to allow for a 1 Hz adjustment. This limitation and the fact that no
> other device seems to need to interact directly will the PLL are why we have
> not put it in the clocking framework.

That's going to be an issue no matter where you put the control - the
ASoC specific clocking APIs don't have any control here either.  I don't
know if we want to add the functionality for doing very fine grained
adjustments into the clock API or not (the use cases seem limited though
I'm sure they exist), though I do think we should have that discussion
if only to confirm, but that's a separate thing to how we expose any
userspace control - the clock API is a kernel internal thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150408/b5efcdbf/attachment.sig>

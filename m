From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Dec 2014 10:51:21 +0000
Subject: [PATCH 2/5] ASoC: dwc: Don't allow negative use counts
In-Reply-To: <548022B3.8050105@arm.com>
References: <547F3C9F.8080102@arm.com> <20141203172526.GC7712@sirena.org.uk>
 <548022B3.8050105@arm.com>
Message-ID: <20141204105121.GQ7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 09:00:35AM +0000, Andrew Jackson wrote:
> On 12/03/14 17:25, Mark Brown wrote:
> > On Wed, Dec 03, 2014 at 04:38:55PM +0000, Andrew Jackson wrote:

> >>  	case SNDRV_PCM_TRIGGER_STOP:
> >>  	case SNDRV_PCM_TRIGGER_SUSPEND:
> >>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> >> -		dev->active--;
> >> +		if (dev->active > 0)
> >> +			dev->active--;

> > How is this triggering - this sounds like you're papering over some
> > other bug somewhere?

> When I looked at the code paths I couldn't convince myself that STOP
> wouldn't be called more than once.  Then actuve would be negative and
> the device might not be restartable.  I didn't have a problem per se,
> it was just that it seemed to be something of a loophole.

If you're just adding the check on the off chance that it might fire you
need to add a warning message as well - what your change does is make
the code look like it's supposed to have broken reference counting since
it has a check to silently fix up and ignore problems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/151cc26e/attachment.sig>

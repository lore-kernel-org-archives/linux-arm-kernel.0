From: broonie@kernel.org (Mark Brown)
Date: Sat, 7 Feb 2015 07:09:51 +0800
Subject: [PATCH v2] ASoC: atmel_ssc_dai: Allow more rates
In-Reply-To: <1423050745-6372-1-git-send-email-peda@lysator.liu.se>
References: <1423050745-6372-1-git-send-email-peda@lysator.liu.se>
Message-ID: <20150206230951.GL31311@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 12:52:25PM +0100, Peter Rosin wrote:

> One thing remains a bit unclear, and that is the 500ppm deduction. Is
> that really warranted? The number was just pulled out of my hat...

I don't really get what this is supposed to be protecting against.

> +	case SND_SOC_DAIFMT_CBM_CFS:
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		t.min = 8000;
> +		t.max = ssc_p->mck_rate / mck_div / frame_size;
> +		/* Take away 500ppm, just to be on the safe side. */
> +		t.max -= t.max / 2000;
> +		t.openmin = t.openmax = 0;
> +		t.integer = 0;
> +		ret = snd_interval_refine(i, &t);

As I understand it this is a straight divider rather than something
that's doing dithering or anything else more fancy.  Given that it seems
as well just to trust the clock rate we've got - we don't do any error
tracking with the clock API (perhaps we should) and for many
applications some degree of divergence from the nominal rate is not
*too* bad for audio systems (for application specific values of "some"
and "too" of course).  If it is just dividers I'm not sure the situation
is really improved materially by knocking off the top frequency.

If we are doing something more fancy than divididing my analysis is off
base of course.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150207/f28520e4/attachment.sig>

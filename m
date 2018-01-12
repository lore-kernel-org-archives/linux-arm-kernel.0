From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jan 2018 22:11:26 +0000
Subject: PM regression in next
In-Reply-To: <20180112215010.GG4821@atomide.com>
References: <20180112000037.GA3875@atomide.com>
 <20180111161837.f1c1d891a1b80d97e30a9b1b@linux-foundation.org>
 <20180112002322.GB3875@atomide.com>
 <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
 <20180112012019.GA4059@atomide.com>
 <20180112190046.GD4821@atomide.com>
 <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
 <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
Message-ID: <20180112221126.GK21458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 01:50:10PM -0800, Tony Lindgren wrote:

> > I rather suspect someone would've noticed by now TBH - I suspect this is
> > more likely to be an issue with the rather baroque code that the TWL
> > drivers have possibly coupled with the whole multiple I2C devices issue.

> Hmm these calls are in sound/soc/soc-core.c though? But yeah, sure
> it could be some legacy code issue somewhere..

Most devices have one regmap per device which can be retrieved with
dev_get_regmap(), it's the attempt to use that which I suspect is
broken.  Like I said snd_soc_codec_init_regmap() ought to fix things if
that's the issue.

> sound/soc/codecs/cx20442.c
> sound/soc/codecs/tlv320dac33.c
> sound/soc/codecs/twl4030.c
> sound/soc/codecs/twl6040.c
> sound/soc/codecs/uda1380.c
> sound/soc/fsl/fsl_ssi.c

> Can you confirm that some of these are still working?

Most of the non-TWL ones have no active users I'm aware of but fsl_ssi.c
is under active development at the minute, one series was getting some
successful testing earlier today so if it's broken I'd hope someone
would have noticed although since it doesn't use DAPM or anything
snd_soc_read()/write() will never get used.  cx20442 was only in a
single archaic consumer product, uda1380 has been legacy since before I
was ever involved in ASoC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180112/f25ed362/attachment.sig>

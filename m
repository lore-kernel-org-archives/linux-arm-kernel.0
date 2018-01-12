From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jan 2018 21:38:45 +0000
Subject: PM regression in next
In-Reply-To: <20180112210706.GE4821@atomide.com>
References: <20180112000037.GA3875@atomide.com>
 <20180111161837.f1c1d891a1b80d97e30a9b1b@linux-foundation.org>
 <20180112002322.GB3875@atomide.com>
 <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
 <20180112012019.GA4059@atomide.com>
 <20180112190046.GD4821@atomide.com>
 <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
Message-ID: <20180112213845.GJ21458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 01:07:06PM -0800, Tony Lindgren wrote:

> Tturns out just adding back .read = twl4030_read fixes it..
> I added a dummy function for read and am now seeing a bunch
> of reads that now don't happen:

What's supposed to happen here is that you end up with a
component->regmap set and snd_soc_component_read() uses that to do the
read.  That normally gets retrieved via dev_get_regmap() but it looks
like this is broken here by the rather novel chip design confusing the
assumptions that code makes.  I *think* that setting the regmap to
twl_get_regmap(TWL4030_MODULE_AUDIO_VOICE) using
snd_soc_codec_init_regmap() in twl4030_soc_probe ought to do the trick
(assuming my guesses about what's going on are right) but can't test.

I'd check twl6040 too, I bet it's got the same issue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180112/b340cdc0/attachment.sig>

From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jan 2018 19:12:51 +0000
Subject: PM regression in next
In-Reply-To: <20180112190046.GD4821@atomide.com>
References: <20180112000037.GA3875@atomide.com>
 <20180111161837.f1c1d891a1b80d97e30a9b1b@linux-foundation.org>
 <20180112002322.GB3875@atomide.com>
 <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
 <20180112012019.GA4059@atomide.com>
 <20180112190046.GD4821@atomide.com>
Message-ID: <20180112191251.GE21458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 11:00:46AM -0800, Tony Lindgren wrote:

> It's commit 3bb0f7c31b1a ("ASoC: don't use snd_soc_write/read
> on twl4030"). And that is for the PMIC on my test system, so
> adding Kuninori and Mark to the thread :)

> Kuninori, it seems that commit 3bb0f7c31b1a causes higher
> power consumption on an idle system on omap3 using twl4030.
> Reverting 3bb0f7c31b1a makes things behave again. My guess
> is that twl4030_read does not do the same as snd_soc_read
> in the driver?

As far as I can tell it should end up boiling down to the same thing but
I didn't follow through in detail, they should both bottom out in
twl_i2c_read_u8() if they hit hardware - all snd_soc_read() did was call
twl4030_read(), the patch just removes the indirection through assigning
the pointer.

Could you try deleting the attempt to read from the cache in
twl4030_read() and always go to hardware?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180112/13f1b2dc/attachment.sig>

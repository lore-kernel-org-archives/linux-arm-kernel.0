From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jan 2018 22:59:47 +0000
Subject: PM regression in next
In-Reply-To: <20180112224959.GH4821@atomide.com>
References: <20180112002322.GB3875@atomide.com>
 <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
 <20180112012019.GA4059@atomide.com>
 <20180112190046.GD4821@atomide.com>
 <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
 <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
Message-ID: <20180112225947.GL21458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 02:49:59PM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [180112 22:11]:

> > Most devices have one regmap per device which can be retrieved with
> > dev_get_regmap(), it's the attempt to use that which I suspect is
> > broken.  Like I said snd_soc_codec_init_regmap() ought to fix things if
> > that's the issue.

> OK. Adding Peter to loop as it's his driver after all. Not sure
> how well mixing regmap register access to the same module with
> cached twl4030_read() would work :)

Yes, that local cache is not a super good idea any more and hopefully
redundant.

> Maybe there should also be some big warning happening if
> snd_soc_codec_init_regmap() is now needed and no regmap is
> found?

Some devices just plain don't have registers at all (perhaps GPIOs or
just stub drivers providing capability information).  However we should
be screaming loudly about the fact that the I/O we tried to do fails,
that clearly shouldn't be being ignored.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180112/170fff1f/attachment.sig>

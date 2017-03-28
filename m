From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 28 Mar 2017 14:52:46 +0300
Subject: [RFC 5/8] regulator: anatop: fix min dropout for bypass mode
In-Reply-To: <20170324125438.5wy3r2mr3g5eaxvy@sirena.org.uk>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <cd944a7223cfe68788c299082a5f262e8bea2136.1490199005.git.leonard.crestez@nxp.com>
 <20170324125438.5wy3r2mr3g5eaxvy@sirena.org.uk>
Message-ID: <1490701966.3546.24.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-24 at 12:54 +0000, Mark Brown wrote:
> On Wed, Mar 22, 2017 at 06:53:07PM +0200, Leonard Crestez wrote:
> > +	if (anatop_reg->bypass)
> > +		anatop_reg->rdesc.min_dropout_uV = 0;
> > +	else
> > +		anatop_reg->rdesc.min_dropout_uV = LDO_MIN_DROPOUT_UV;
> No, this is completely broken - you can't expect to randomly change hthe
> regulator description at runtime behind the back of the framework and
> expect things to work.??If there is a need to do this we need an
> interface for getting the current value and a way to notify of changes.
> 
> That said I would not expect the dropout voltage to be considered at
> all when the regulator is bypassed, since the regulator is not
> regulating it doesn't need any headroom.

It's a more complex solution but this could be handled in the core instead.
Basically the core would treat min_dropout_uV as zero if the regulator is
currently in bypass mode.

In theory a function could be added in regulator_ops to ask a regulator driver
what requirements it has for its supply but this does not seem necessary.

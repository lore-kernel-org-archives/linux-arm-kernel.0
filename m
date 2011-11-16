From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 16 Nov 2011 17:50:50 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <20111116173945.GG2073@localhost.localdomain>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
 <20111116154402.GE2073@localhost.localdomain>
 <4EC3E446.4030608@gmail.com>
 <1321461458.3137.374.camel@hornet.cambridge.arm.com>
 <4EC3EBEC.3020601@gmail.com>
 <1321463271.3137.380.camel@hornet.cambridge.arm.com>
 <20111116173945.GG2073@localhost.localdomain>
Message-ID: <20111116175050.GH2073@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 05:07:51PM +0000, Pawel Moll wrote:
> On Wed, 2011-11-16 at 16:59 +0000, Rob Herring wrote:
> > It has nothing to do with taste and obviously documentation changes over
> > time. I'm going to start naming everything with legacy because someday
> > it all will be...
> > 
> > It's about how you create compatible strings. They should not be
> > generic, but specific to particular hardware version. If you happen to
> > be compatible with older h/w then you can claim compatibility with that
> > older h/w.
> 
> Notice that it's not:
> 
> 	compatible=legacy
> 
> not even:
> 
> 	compatible=arm,legacy
> 
> It's:
> 	
> 	compatible=arm,vexpress-legacy
> 
> A specific variant of Versatile Express hardware. It's just that the
> "legacy" word carries some meaning. Would it looked better if it was
> called:
>
>	compatible=arm,vexpress-nalatenskap
>
> ? (thanks, google translate ;-)

(excuse the previous, half-written mail...)

Come to think of it, is the problem here that we're trying to describe
the _motherboard_ using the compatible property on the root node.
This is why I talked about universal/generic features -- the set of
features common to all platforms sharing a single motherboard
configuration.

Arguably that's wrong, and that compatible property belongs on the
motherboard node itself, so (excuse the random syntax):

/ {
	compatible = "arm,vexpress-v2p-ca9", "arm,vexpress";

	motherboard {
		compatible = "arm,vexpress-v2m-legacy", "simple-bus";
	};
};


I'm not commenting on the "legacy" name here -- it is, for better
or worse, the official name for the old memory map.  I don't feel
that calling that "arm,vexpress" is correct either, however.  There
is no such thing as a vanilla vexpress board, because the board
is not fully specified at all without _something_ in the IOFPGA.
Nor are there any prior upstream DT bindings for this platform which
we would be referring back to.

The motherboard node, including the compatible property would be defined
once per memory map, in the relevant .dtsi file.


If we don't have a generic compatible string "arm,vexpress", then we'd
start having to list every possible "arm,vexpress-v2p-*" in the
compatible lists in the code.  I'm not clear on whether that's right
or wrong, but it could certainly get cumbersome.


Thoughts?

> > > 
> > > and
> > > 
> > >>> +	compatible = "arm,vexpress-<model>", "arm,vexpress-legacy", "arm-vexpress";
> > 
> > If arm,vexpress-ca9 is the only legacy platform, then just drop
> > arm,vexpress-legacy altogether.
> 
> It's not. There is additional one, which is not publicly available, but
> is using the motherboard in legacy mode.

If putting a suitable compatible property on the motherboard node is
feasible, it should work for this case.

Cheers
---Dave

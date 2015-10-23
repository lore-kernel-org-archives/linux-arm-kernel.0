From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 Oct 2015 16:00:34 +0900
Subject: [PATCH v11 6/8] arm64: renesas: add Salvator-X board support on
 DTS
In-Reply-To: <20151015110139.GG8825@leverpostej>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
 <1444890243-6978-7-git-send-email-horms+renesas@verge.net.au>
 <20151015110139.GG8825@leverpostej>
Message-ID: <20151023070032.GA4502@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 12:01:40PM +0100, Mark Rutland wrote:
> > +/ {
> > +	model = "Renesas Salvator-X board based on r8a7795";
> > +	compatible = "renesas,salvator-x", "renesas,r8a7795";
> > +
> > +	aliases {
> > +		serial0 = &scif2;
> > +		serial1 = &scif1;
> > +	};
> > +
> > +	chosen {
> > +		bootargs = "ignore_loglevel";
> 
> Do we really need this kind of thing in the kernel DTs?

I agree this looks a bit lonely by itself, and I'm not entirely
opposed to removing it. However, I do seek consistency between
the renesas ARM and ARM64 SoCs where possible.

Further work[1] on this file outside of this series adds
"rw root=/dev/nfs ip=dhcp" to bootargs, the result being consistent
with Renesas ARM32 SoCs.

[1] [PATCH v5 4/5] arm64: dts: r8a7795: enable nfs root on Salvator-X board
    http://www.spinics.net/lists/arm-kernel/msg452743.html

> > +		stdout-path = &scif2;
> 
> No rate? It would be better to be explicit here; you should be able to
> have:
> 
> 	stdout-path = "serial0:115200n8"
> 
> Where "115200n8" is replaced with whatever configuration this board
> actually has.

I think that we have had this discussion before in relation to
a different board for a different Renesas SoC but I could be mistaken.

The r8a7795 uses the sh-sci serial driver for which the default rate is
115200. It is hard for me to conceive of a situation where that would
change without due consideration being given to the implications for DT
files.

Not specifying the baud here is consistent with what we have
been doing for ARM32 Renesas SoCs for some time.

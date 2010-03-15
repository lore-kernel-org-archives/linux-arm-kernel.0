From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 15 Mar 2010 12:53:10 -0400 (EDT)
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <4B9E5A29.1090407@st.com>
References: <4B9DB823.1040809@st.com>
	<1b68c6791003142147y200fff12vc805fbd07f1c0ef4@mail.gmail.com>
	<4B9DC239.90407@st.com> <4B9E2D7E.1020702@billgatliff.com>
	<4B9E5A29.1090407@st.com>
Message-ID: <alpine.LFD.2.00.1003151241350.31128@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Mar 2010, Armando VISCONTI wrote:

> > 
> > What I think you really want is for your board-specific code (or some
> > helper code elsewhere in your mach-* directory) to do the pin
> > assignments, and the drivers just assume that the pins are all right. That's
> > the approach used in OMAP2 and AT91, among others, and it seems
> > to work out just fine.
> >   
> 
> Bill,
> 
> What you and Russell are saying is a little bit different from what I got
> since
> now, with people suggesting to implement a single linux image which is
> then configured at runtime thru (for example) bootargs.
> 
> Now you both are saying that compile time options are better, correct?

No.

> So, we have two choices:
> 
> 1. Stay as it is, which means to use menuconfig options.
> 2. Provide board-specific code in the mach-spear directory.
> 
> You are suggesting 2, which also seems to be the pin_config stuff
> inside mach-pxa. Am I aligned?

Yes.  Another good example that you might have a look at is 
arch/arm/mach-kirkwood/*-setup.c.  Those files are defining what and how 
each of those particular machine targets should be configured.  And for 
the multiplexed pin config, there is a mpp.h which statically defines 
all the possible combinations for each pin, including the function type 
(GPIO or dedicated function), the direction, and a bitmask of specific 
SOC versions each definition may apply to.  Then a list of those is 
passed to kirkwood_mpp_conf() which performs the appropriate validation 
and configuration.

Please take the time to look at a couple examples like those.  You 
should get a good idea of the overall strategy and one of those might be 
a better example than the others to follow for your particular hardware.


Nicolas

From: J.Weitzel@phytec.de (Jan Weitzel)
Date: Tue, 5 Apr 2011 12:59:12 +0200
Subject: [PATCH] ARM: type casts update_sched_clock cyc_to_sched_clock
	cyc_to_fixed_sched_clock
In-Reply-To: <20110405083144.GN13963@pengutronix.de>
References: <1301989401-11984-1-git-send-email-j.weitzel@phytec.de>	<20110405075622.GB4699@n2100.arm.linux.org.uk>
	<20110405083144.GN13963@pengutronix.de>
Message-ID: <OFDC271AC0.D19DB9A2-ONC1257869.003AA29F-C1257869.003C5A1D@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

linux-arm-kernel-bounces at lists.infradead.org schrieb am 05.04.2011 
10:31:44:

> Von: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> An: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Kopie: rubini at unipv.it, kgene.kim at samsung.com, 
> eric.y.miao at gmail.com, ben-linux at fluff.org, tony at atomide.com, Jan 
> Weitzel <j.weitzel@phytec.de>, linux-tegra at vger.kernel.org, linux-
> omap at vger.kernel.org, kernel at pengutronix.de, 
> STEricsson_nomadik_linux at list.st.com, trivial at kernel.org, 
> kaloz at openwrt.org, linux-arm-kernel at lists.infradead.org, khc at pm.waw.pl
> Datum: 05.04.2011 10:33
> Betreff: Re: [PATCH] ARM: type casts update_sched_clock 
> cyc_to_sched_clock cyc_to_fixed_sched_clock
> Gesendet von: linux-arm-kernel-bounces at lists.infradead.org
> 
> On Tue, Apr 05, 2011 at 08:56:22AM +0100, Russell King - ARM Linux 
wrote:
> > On Tue, Apr 05, 2011 at 09:43:21AM +0200, Jan Weitzel wrote:
> > > parameter "u32 mask" type cast befor inversion
> s/befor/before/
> 
> > Nak.  I want a 32-bit all ones quantity.
> > 
> > unsigned long long vali = (unsigned short)~0;
> > unsigned long long vall = ~(unsigned short)0;
> > 
> BTW, the definiton of vall is equivalent to 
> 
>    unsigned long long valu = ~(unsigned int)0;
> 
> because ~ converts the unsigned short to unsigned int.
> 
> > compiles to:
> > 
> > vali:
> >         .word   65535
> >         .word   0
> > 
> > vall:
> >         .word   -1
> >         .word   -1
> I really wonder about that. If I take a value of 0xffffffff (i.e. a 32
> bit wide int == ~0U) and assign that to an 64-bit unsigned long long I'd
> expect it to get the value 0x00000000ffffffffULL, not
> 0xffffffffffffffffULL. What's wrong?
> 
> > So moving the ~ to be evaluated after the cast has the effect of 
making
> > the cast pointless, and produces wrong values.  (u32)~0 does the 
32-bit
> My C-Book tells that using ~ on a signed it produces implementation
> defined behaviour. That's what I pointed out to Jan and I guess that's
> the reason why he created the patch.

That's right. I tested it and got for both
static unsigned long long valuica = (unsigned int)~0;
static unsigned long long valuicb = ~(unsigned int)0;

the same:
.word   0xffffffff
.word   0x00000000

With unsigned short I see the problem. Sorry for the noise.

Kind regards 
Jan

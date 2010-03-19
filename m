From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Mar 2010 18:35:21 -0700
Subject: [PATCH] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check
	for it on V6
In-Reply-To: <20100318170021.GN2900@atomide.com>
References: <20100317175731.GE2900@atomide.com>
	<1268849278.19565.28.camel@e102109-lin.cambridge.arm.com>
	<20100317191114.GH2900@atomide.com>
	<1268910826.15334.32.camel@e102109-lin.cambridge.arm.com>
	<20100318170021.GN2900@atomide.com>
Message-ID: <20100319013521.GP2900@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100318 09:55]:
> * Catalin Marinas <catalin.marinas@arm.com> [100318 04:10]:
> > On Wed, 2010-03-17 at 19:11 +0000, Tony Lindgren wrote:
> > > * Catalin Marinas <catalin.marinas@arm.com> [100317 11:04]:
> > > > On Wed, 2010-03-17 at 17:57 +0000, Tony Lindgren wrote:
> > > > > HAS_TLS reg is only on ARM11 starting with r1p0:
> > > > >
> > > > > http://infocenter.arm.com/help/topic/com.arm.doc.ddi0211k/Babeihid.html
> > > > >
> > > > > So that explains why it won't work on omap2420 as it's r0p2.
> > > >
> > > > Same here, would it work with dynamic detection?
> > > 
> > > Hmm I believe here the problem is __switch_to in entry-armv.S.
> > > I don't think we want to dynamically test it every time.. Or
> > > at least it would have to be optimized out in most cases.
> > 
> > But if you disable this, you won't be able to use an SMP build on both
> > v6 and v7. Anyway, I don't think that dynamically checking this would
> > introduce performance penalties, the __switch_to code is pretty complex
> > already with all the notifier calls.
> 
> OK. I'll take a look at setting the TLS a HWCAP flag.

Below is a patch for convert CONFIG_HAS_TLS_REG into HWCAP_TLS.

I've tested it with V6 r0p2 with no HWCAP_TLS, and V7 that has HWCAP_TLS.
I also forced CONFIG_TLS_REG_EMUL and booted on V6 r0p2, and it booted OK.

Could somebody please test this patch on a real CONFIG_TLS_REG_EMUL
system?

Also, I wonder if the change __kuser_get_tls is safe?

I changed it to assume that if 0xffff0ff0 == 0, then we have HWCAP_TLS.

Regards,

Tony

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 13 Oct 2016 13:03:17 +0200
Subject: [PATCH 2/2] power/reset: at91-poweroff: timely shitdown LPDDR
 memories
In-Reply-To: <CACh+v5NCxPb_U8HOeczHicCD-Wp8BqBzvc1LtCzmEXZ74Cgshw@mail.gmail.com>
References: <20161007163427.11454-1-alexandre.belloni@free-electrons.com>
 <20161007163427.11454-3-alexandre.belloni@free-electrons.com>
 <CACh+v5NCxPb_U8HOeczHicCD-Wp8BqBzvc1LtCzmEXZ74Cgshw@mail.gmail.com>
Message-ID: <20161013110317.ee6by6njrvs53ztx@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2016 at 14:48:27 +0200, Jean-Jacques Hiblot wrote :
> > +static void at91_lpddr_poweroff(void)
> > +{
> > +       asm volatile(
> > +               /* Align to cache lines */
> > +               ".balign 32\n\t"
> > +
> > +               "       ldr     r6, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
> At first sight, it looks useless. I assume it's used to preload the
> TLB before the LPDDR is turned off.
> A comment to explain why this line is useful would prevent its removal.

Yes, this is the case. I can add a comment.

Anyway, I would prefer the whole thing to run from SRAM, as a PIE
instead of relying on the cache.

> > +       ddr_type = readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
> > +       if ((ddr_type == AT91_DDRSDRC_MD_LPDDR2) ||
> > +           (ddr_type == AT91_DDRSDRC_MD_LPDDR3))
> Souldn't there be something like "pm_power_off = at91_lpddr_poweroff;" here ?
> 

Indeed


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 1 Jul 2014 18:48:51 +0200
Subject: [PATCH 00/33] ARM: at91: Switch remaining SoCs and boards to CCF
In-Reply-To: <5780166.MMf0Vhnnsu@wuerfel>
References: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
 <5780166.MMf0Vhnnsu@wuerfel>
Message-ID: <20140701164851.GI3427@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/07/2014 at 18:35:50 +0200, Arnd Bergmann wrote :
> On Tuesday 01 July 2014 16:12:09 Alexandre Belloni wrote:
> Looks good overall, but I think this Kconfig snippet should be cleaned
> up a little now:
> 
> config AT91_USE_OLD_CLK
>         bool
> 
> config AT91_PMC_UNIT
>         bool
>         default !ARCH_AT91X40
> 
> config COMMON_CLK_AT91
>         bool
>         default AT91_PMC_UNIT && USE_OF && !AT91_USE_OLD_CLK
>         select COMMON_CLK
> 
> config OLD_CLK_AT91
>         bool
>         default AT91_PMC_UNIT && AT91_USE_OLD_CLK
> 
> 
> If I read this right, disabling 'USE_OF' results in still using
> the old clock interface. Is that intentional? If you want to always
> use COMMON_CLK now, the above can probably be simplified to
> 
> config AT91_PMC_UNIT
>         def_bool !ARCH_AT91X40
> 	select COMMON_CLK
> 
> and all references to AT91_USE_OLD_CLK, COMMON_CLK_AT91 and
> OLD_CLK_AT91 be removed.

Yeah, this is intentional we still have 30 or so boards that we have to
migrate to DT. Until then, we want to be able to boot a kernel without
CCF. The next step in the migration is to switch those boards to DT,
possibly using an hybrid DT/pdata approach until we can get rid of the
board files. Then, we will be able to get rid of the old clk
implementation (and a few other drivers still living in mach-at91).


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Jul 2014 18:35:50 +0200
Subject: [PATCH 00/33] ARM: at91: Switch remaining SoCs and boards to CCF
In-Reply-To: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5780166.MMf0Vhnnsu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 July 2014 16:12:09 Alexandre Belloni wrote:
> This patch set adds support for the common clock framwork to the remaining atml
> SoCs: at91rm9200, at91sam9260, at91sam9263, at91sam9g45.
> 
> It also defines the necessary main crystal and slow crystal frequencies.
> 
> I couldn't find datasheets for the following boards:
>  - mpa1600
>  - ge863-pro3
>  - animeo_ip
>  - tny_a9260
> 
> For those, I assumed the 32kHz crystal is present on the board as this is the
> most common implementation (only one board doesn't have it). Please correct me
> if this is wrong.
> 
> I could not test at91rm9200 as I don't own any board with that chip.

Looks good overall, but I think this Kconfig snippet should be cleaned
up a little now:

config AT91_USE_OLD_CLK
        bool

config AT91_PMC_UNIT
        bool
        default !ARCH_AT91X40

config COMMON_CLK_AT91
        bool
        default AT91_PMC_UNIT && USE_OF && !AT91_USE_OLD_CLK
        select COMMON_CLK

config OLD_CLK_AT91
        bool
        default AT91_PMC_UNIT && AT91_USE_OLD_CLK


If I read this right, disabling 'USE_OF' results in still using
the old clock interface. Is that intentional? If you want to always
use COMMON_CLK now, the above can probably be simplified to

config AT91_PMC_UNIT
        def_bool !ARCH_AT91X40
	select COMMON_CLK

and all references to AT91_USE_OLD_CLK, COMMON_CLK_AT91 and
OLD_CLK_AT91 be removed.

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 06 Oct 2014 22:35:26 +0200
Subject: [PATCH v1] clk: pxa clocks build system fix
In-Reply-To: <20141005204358.4379.67145@quantum>
References: <1412199569-27958-1-git-send-email-robert.jarzmik@free.fr>
 <20141005204358.4379.67145@quantum>
Message-ID: <2017199.vcTs1JkoqL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 October 2014 13:43:58 Mike Turquette wrote:
> Quoting Robert Jarzmik (2014-10-01 14:39:29)
> > Fix the building of pxa clock drivers so that the files are actually
> > compiled if and only if COMMON_CLK was selected by the architecture.
> > 
> > This prevents conflicts with mach-pxa clock legacy implementation.
> > 
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 

I seem to still hit a build error with this applied in e.g.
build/palmz72_defconfig, which enables both pxa25x and pxa27x,
so I get both the pxa250 private clock code and the pxa270
common clock code, resulting in this error message:

drivers/built-in.o:(___ksymtab_gpl+clk_enable+0x0): multiple definition of `__ksymtab_clk_enable'
arch/arm/mach-pxa/built-in.o:(___ksymtab+clk_enable+0x0): first defined here
drivers/built-in.o:(___ksymtab_gpl+clk_get_rate+0x0): multiple definition of `__ksymtab_clk_get_rate'
arch/arm/mach-pxa/built-in.o:(___ksymtab+clk_get_rate+0x0): first defined here
drivers/built-in.o:(___ksymtab_gpl+clk_round_rate+0x0): multiple definition of `__ksymtab_clk_round_rate'
arch/arm/mach-pxa/built-in.o:(___ksymtab+clk_round_rate+0x0): first defined here
drivers/built-in.o: In function `clk_set_rate':
:(.text+0x86930): multiple definition of `clk_set_rate'
arch/arm/mach-pxa/built-in.o::(.text+0x103c): first defined here
drivers/built-in.o: In function `clk_set_parent':
:(.text+0x869c4): multiple definition of `clk_set_parent'
arch/arm/mach-pxa/built-in.o::(.text+0x127c): first defined here
drivers/built-in.o: In function `clk_round_rate':
:(.text+0x85c18): multiple definition of `clk_round_rate'
arch/arm/mach-pxa/built-in.o::(.text+0x1248): first defined here
drivers/built-in.o:(___ksymtab_gpl+clk_set_parent+0x0): multiple definition of `__ksymtab_clk_set_parent'
arch/arm/mach-pxa/built-in.o:(___ksymtab+clk_set_parent+0x0): first defined here
drivers/built-in.o:(___ksymtab_gpl+clk_disable+0x0): multiple definition of `__ksymtab_clk_disable'
arch/arm/mach-pxa/built-in.o:(___ksymtab+clk_disable+0x0): first defined here
drivers/built-in.o: In function `clk_get_rate':
:(.text+0x85c64): multiple definition of `clk_get_rate'
arch/arm/mach-pxa/built-in.o::(.text+0x1014): first defined here
drivers/built-in.o:(___ksymtab_gpl+clk_set_rate+0x0): multiple definition of `__ksymtab_clk_set_rate'
arch/arm/mach-pxa/built-in.o:(___ksymtab+clk_set_rate+0x0): first defined here
drivers/built-in.o: In function `clk_get_parent':
:(.text+0x85c44): multiple definition of `clk_get_parent'
arch/arm/mach-pxa/built-in.o::(.text+0x12b0): first defined here
drivers/built-in.o: In function `clk_disable':
:(.text+0x85b08): multiple definition of `clk_disable'
arch/arm/mach-pxa/built-in.o::(.text+0x118c): first defined here
drivers/built-in.o:(___ksymtab_gpl+clk_get_parent+0x0): multiple definition of `__ksymtab_clk_get_parent'
arch/arm/mach-pxa/built-in.o:(___ksymtab+clk_get_parent+0x0): first defined here
drivers/built-in.o: In function `clk_enable':
:(.text+0x85808): multiple definition of `clk_enable'
arch/arm/mach-pxa/built-in.o::(.text+0x10d8): first defined here



	Arnd

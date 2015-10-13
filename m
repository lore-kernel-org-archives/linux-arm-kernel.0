From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 00:23:43 +0200
Subject: [PATCH v2 7/7] clk: ns2: add clock support for Broadcom Northstar
 2 SoC
In-Reply-To: <20151013220450.GO12512@broadcom.com>
References: <1444770485-11210-1-git-send-email-jonmason@broadcom.com>
 <5280890.6npshDUNFZ@wuerfel> <20151013220450.GO12512@broadcom.com>
Message-ID: <6427519.eIBEvCNlle@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 October 2015 18:04:50 Jon Mason wrote:
> 
> > On a related note, I'm seeing problems when CONFIG_CYGNUS is set but
> > CONFIG_COMMON_CLK_IPROC is disabled, as that currently leads to a link
> > failure.
> 
> I can double check, but it should be on by default when Cygnus is
> enabled.  If you send me the error, I'll be happy to fix it.


The problem is not that it's off by default but that it can be
disabled, so it breaks some 'make randconfig' builds with this
message:

drivers/built-in.o: In function `cygnus_armpll_init':
:(.init.text+0x1d290): undefined reference to `iproc_armpll_setup'
drivers/built-in.o: In function `cygnus_genpll_clk_init':
:(.init.text+0x1d2c4): undefined reference to `iproc_pll_clk_setup'
drivers/built-in.o: In function `cygnus_lcpll0_clk_init':
:(.init.text+0x1d304): undefined reference to `iproc_pll_clk_setup'
drivers/built-in.o: In function `cygnus_mipipll_clk_init':
:(.init.text+0x1d344): undefined reference to `iproc_pll_clk_setup'
drivers/built-in.o: In function `cygnus_asiu_init':
:(.init.text+0x1d370): undefined reference to `iproc_asiu_setup'

My patch fixes it by always selecting COMMON_CLK_IPROC from
ARCH_BCM_CYGNUS. I wasn't sure whether you want COMMON_CLK_IPROC
to still be user-selectable, so I left that in place. Normally
I'd expect it to be a silent option though, that just gets
implicitly enabled whenever a platform that needs it is built
into the kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 1319c3c14327..35234e563cd8 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -29,6 +29,7 @@ config ARCH_BCM_IPROC
 config ARCH_BCM_CYGNUS
 	bool "Broadcom Cygnus Support" if ARCH_MULTI_V7
 	select ARCH_BCM_IPROC
+	select COMMON_CLK_IPROC
 	help
 	  Enable support for the Cygnus family,
 	  which includes the following variants:

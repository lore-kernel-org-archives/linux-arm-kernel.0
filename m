From: s.peter@mpl.ch (Stefan Peter)
Date: Thu, 27 Dec 2012 23:57:59 +0100
Subject: [PATCH 0/2] Fixes for 3.8-rc1
In-Reply-To: <1355868838-16124-1-git-send-email-andrew@lunn.ch>
References: <1355868838-16124-1-git-send-email-andrew@lunn.ch>
Message-ID: <50DCD277.7040201@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.12.2012 23:13, Andrew Lunn wrote:
> These two patches are fixes needed for Linux 3.8.
> 
> The first patch fixes a lockup due to the missing SDIO clock. Since
> the clkdev alias is missing, the sdio driver fails to
> clk_prepare_enable() the clock. The lateinit call in the clk framework
> then disables the clock since nobody owns it. The next access to the
> SDIO register space causes the SoC to lockup.
> 
> The second patch fixes a null-pointer dereference. The conversion of
> Kirkwood to pinctrl/gpio resulted in that using GPIO calls inside the
> board-*.c file causes an exception, since the gpio driver has not yet
> been loaded. Topkick is using the GPIO to control power to the SATA0
> device. So convert the gpio to a fixed regulator, in DT, which gets
> loaded after the gpio driver is available.
> 
> Andrew Lunn (2):
>   ARM: Kirkwood: Fix missing sdio clock
>   ARM: Kirkwood: Use fixed-regulator instead of board gpio call
> 
>  arch/arm/boot/dts/kirkwood-topkick.dts     |   17 +++++++++++++++++
>  arch/arm/mach-kirkwood/board-dt.c          |    4 ++++
>  arch/arm/mach-kirkwood/board-usi_topkick.c |    4 ----
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 

Tested-by: Stefan Peter <s.peter@mplch>


-- 
MPL AG, Switzerland                     http://www.mpl.ch
Tel. +41 (0)56 483 34 34          Fax: +41(0)56 493 30 20

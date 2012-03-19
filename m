From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Mar 2012 09:44:41 -0500
Subject: i.MX: Convert v4/v5 based SoCs to common clock framework
In-Reply-To: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
References: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4F674659.40207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2012 08:35 AM, Sascha Hauer wrote:
> Hi All,
> 
> The following patches convert the i.MX v4/v5 based SoCs to the common
> clock framework.  They may not be completely ready, I am posting it now
> because I'd like to show that the function based clock initializers are
> indeed usable in real life and that the end result does not look too
> bad.
> 
> This series depends on another series not yet posted which convert the
> i.MX drivers to not depend on grouped clocks. I will follow up on this
> after the merge window. My plan for these patches is to put them into
> the arm-soc staging area after the merge window to let them stabilize
> until hopefully before the next merge window there are no regressions
> left.
> 
> Except the i.MX21 port all SoCs are runtime tested with the basic
> devices (at least uart and network; I tested more, but not
> systematically). Testers for these patches are very welcome, I will
> happily integrate fixups into this series. A branch containing Mikes
> latest clock patches, the driver fixups and this series can be found
> here:
> 
> git://git.pengutronix.de/git/imx/linux-2.6.git work/imx-clk-v4-v5
> 
> As a side note, we currently compile all i.MX v4/v5 based SoCs in a
> single defconfig. Since a kernel can only be built with or without the
> common clock framework this series is not fully bisectable, you have to
> disable the not yet converted SoCs in between.
> 
> The patch for removing the old clock support is not included in this
> post, but with the removal the overall diffstat looks like this:
> 
>  arch/arm/mach-imx/clock-imx1.c           |  636 ---------------
>  arch/arm/mach-imx/clock-imx21.c          | 1239 -------------------------------
>  arch/arm/mach-imx/clock-imx25.c          |  346 --------
>  arch/arm/mach-imx/clock-imx27.c          |  766 -------------------
>  b/arch/arm/mach-imx/Kconfig              |    4 
>  b/arch/arm/mach-imx/Makefile             |   10 
>  b/arch/arm/mach-imx/clk-imx1.c           |  118 ++
>  b/arch/arm/mach-imx/clk-imx21.c          |  177 ++++
>  b/arch/arm/mach-imx/clk-imx25.c          |  242 ++++++
>  b/arch/arm/mach-imx/clk-imx27.c          |  277 ++++++
>  b/arch/arm/mach-imx/clk-pllv1.c          |   59 +
>  b/arch/arm/mach-imx/clk.h                |   44 +
>  b/arch/arm/plat-mxc/clock.c              |   11 
>  b/arch/arm/plat-mxc/include/mach/clock.h |    4 
>  b/arch/arm/plat-mxc/time.c               |    5 
>  15 files changed, 946 insertions(+), 2992 deletions(-)
> 
> ----------------------------------------------------------------
> Sascha Hauer (7):
>       ARM i.MX: prepare for common clock framework
>       ARM i.MX timer: request correct clock
>       ARM i.MX: Add common clock support for pllv1
>       ARM i.MX1: implement clocks using common clock framework
>       ARM i.MX21: implement clocks using common clock framework
>       ARM i.MX25: implement clocks using common clock framework
>       ARM i.MX27: implement clocks using common clock framework
> 
>  arch/arm/mach-imx/Kconfig              |    4 +
>  arch/arm/mach-imx/Makefile             |   10 +-
>  arch/arm/mach-imx/clk-imx1.c           |  118 ++++++++++++++
>  arch/arm/mach-imx/clk-imx21.c          |  177 ++++++++++++++++++++
>  arch/arm/mach-imx/clk-imx25.c          |  242 ++++++++++++++++++++++++++++
>  arch/arm/mach-imx/clk-imx27.c          |  277 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/clk-pllv1.c          |   59 +++++++
>  arch/arm/mach-imx/clk.h                |   44 +++++
>  arch/arm/plat-mxc/clock.c              |   11 ++
>  arch/arm/plat-mxc/include/mach/clock.h |    4 +
>  arch/arm/plat-mxc/time.c               |    5 +-
>  11 files changed, 946 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/mach-imx/clk-imx1.c
>  create mode 100644 arch/arm/mach-imx/clk-imx21.c
>  create mode 100644 arch/arm/mach-imx/clk-imx25.c
>  create mode 100644 arch/arm/mach-imx/clk-imx27.c
>  create mode 100644 arch/arm/mach-imx/clk-pllv1.c
>  create mode 100644 arch/arm/mach-imx/clk.h
> 

Do we want to move all clock code to drivers/clk? I'm not saying it has
to be done now, but is that a goal?

Rob

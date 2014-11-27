From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 13:35:29 +0100
Subject: [PATCH 11/19] clk: samsung: exynos5433: Add clocks for
 CMU_BUS{0|1|2} domains
In-Reply-To: <54771518.1010004@samsung.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <54771173.6090408@samsung.com> <54771518.1010004@samsung.com>
Message-ID: <3556463.Me1EFEY7Zb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 13:12:08 Sylwester Nawrocki wrote:
> On 27/11/14 12:56, Chanwoo Choi wrote:
> > On 11/27/2014 08:41 PM, Arnd Bergmann wrote:
> >> > On Thursday 27 November 2014 16:35:08 Chanwoo Choi wrote:
> >>> >> +  - "samsung,exynos5433-cmu-bus0", "samsung,exynos5433-cmu-bus1"
> >>> >> +    and "samsung,exynos5433-cmu-bus2" - clock controller compatible for CMU_BUS
> >>> >> +    which generates global data buses clock and global peripheral buses clock.
> >>> >>  
> >>> >>  - reg: physical base address of the controller and length of memory mapped
> >>> >>    region.
> >>> >>
> >> > 
> >> > This looks like you are duplicating the bindings and the code, but
> >> > it's really the same hardware multiple times with minor variations
> >> > that you should be able to describe properly here. Why not make
> >> > three nodes with the same compatible string and have them handled
> >> > by the same code?
> >
> > Each CMU_BUSx domain of Exynos5433 have different base address as following:
> > - CMU_BUS0's base address and range : 0x1360_0000 ~ 0x1360_0b04
> > - CMU_BUS1's base address and range : 0x1480_0000 ~ 0x1480_0b04
> > - CMU_BUS2's base address and range : 0x1340_0000 ~ 0x1340_0b04
> > 
> > So, I implement CMU_BUSx domain which has each compatible string.

But the base address is in the reg property, not in the compatible
property. What I mean is to have multiple nodes like

	clock-controller at 113600000 {
		reg = <0 0x113600000 0 0x1000>;
		compatible = "samsung,exynos5433-cmu";
		#clock-cells = <1>;
	};

	clock-controller at 114800000 {
		reg = <0 0x114800000 0 0x1000>;
		compatible = "samsung,exynos5433-cmu";
		#clock-cells = <1>;
	};

The code will just map the local registers for each instance and then
provide the clocks of the right instance when asked for it.

> You can always have multiple entries in the reg property. I've done
> something like this for the exynos4415 CMU_ISPx units:
> 
>         cmu_isp: clock-controller at 12060000 {
>                 compatible = "samsung,exynos4415-cmu-isp";
>                 reg = <0x12060000 0xB10>, <0x12070000 0xB10>;
>                 #clock-cells = <1>;
> 
>                 assigned-clocks = <&cmu CLK_FOUT_ISP_PLL>;
>                 assigned-clock-rates = <300000000>;
>         };

This is a different problem, this is a clock controller with multiple
sets of registers that are all different. In case of the cmu, it seems
that they are all the same, you just have multiple copies at different
locations, and they are connected to different devices.

	Arnd

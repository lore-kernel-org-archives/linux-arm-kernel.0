From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 12:19:56 +0200
Subject: [PATCH v2 3/6] clk: hi6220: Document devicetree bindings for
 hi6220 clock
In-Reply-To: <552C8AFE.9040907@huawei.com>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
 <7304398.GVjUsTVoce@wuerfel> <552C8AFE.9040907@huawei.com>
Message-ID: <2456827.cDpE8M58pn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 11:35:26 Bintian wrote:
> Hello Arnd,
> 
> On 2015/4/13 23:32, Arnd Bergmann wrote:
> > On Monday 13 April 2015 17:17:37 Bintian Wang wrote:
> >> +- compatible: the compatible should be one of the following strings to
> >> +       indicate the clock controller functionality.
> >> +
> >> +       - "hisilicon,aoctrl"
> >> +       - "hisilicon,sysctrl"
> >> +       - "hisilicon,mediactrl"
> >> +       - "hisilicon,pmctrl"
> >> +
> >>
> >
> > These ones already have bindings, you can't reuse the strings.
> > Please work with someone in hisilicon to set up a registry of
> > device names so you can avoid conflicts in the future.
> All the clock registers are under above four system controllers, 
> discussed with Mark and Haojian two months ago, I think using above
> same four binding strings is enough for clk module.
> On second thoughts, there really some problems for future hisilicon
> code upstream, how about change back to the first version of this
> patch set, just like following:
> +		sys_ctrl: sys_ctrl {
> +			compatible = "hisilicon,sysctrl", "syscon";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x0 0xf7030000 0x0 0x2000>;
> +			ranges = <0 0x0 0xf7030000 0x2000>;
> +
> +			clock_sys: clock1 at 0 {
> +				compatible = "hisilicon,hi6220-clock-sys";
> +				reg = <0 0x1000>;
> +				#clock-cells = <1>;
> +			};
> +		};

Sub-nodes are fine, but you also can't have a device node that
is just 'compatible = "hisilicon,sysctrl", "syscon";' when
hisilicon,sysctrl can refer to multiple mutually incompatible
controllers.

The minimum fix would be to mandate the string to be
compatible = "hisilicon,hi6220-sysctrl", "hisilicon,sysctrl", "syscon";
for this model, and use respective compatible strings for the other
chips.

For the documentation, I think it would make sense to move that
description to "hisilicon,sysctrl" and list all the variants of that
component and the respective compatible strings there, rather than
have one document per chip and list multiple components in it.

	Arnd

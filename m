From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 18 Jul 2016 10:22:44 -0700
Subject: [PATCH] clk: zynq: avoid retrieving clock names from DT property
In-Reply-To: <20160717161110.GY3847@xsjsorenbubuntu>
References: <1468682123-1434-1-git-send-email-yamada.masahiro@socionext.com>
 <20160717161110.GY3847@xsjsorenbubuntu>
Message-ID: <20160718172244.GF3847@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-07-17 at 09:11:10 -0700, S?ren Brinkmann wrote:
> On Sun, 2016-07-17 at 00:15:23 +0900, Masahiro Yamada wrote:
> > The "clock-output-names" property is useful for generic clock
> > providers such as fixed-clock, fixed-factor-clock, etc.
> > 
> > On the other hand, it should not be used for really SoC-specific
> > clock providers like this one.  As you see in "enum zynq_clk" in
> > this driver, it is written as if it already knows all the clock
> > names.  Besides, this is instantiated only once, so no clock name
> > conflict would happen even if the clock names are hard-coded in the
> > driver.
> > 
> > The device tree (arch/arm/boot/dts/zynq-7000.dtsi) will be fixed
> > later.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> IIRC, this was the only way to allow circular clock routing. E.g. there
> are use-cases that route an FCLK back into the PS to use it as input for
> the GEM. With the introduction of deferred probing this might all be
> possible now but it would be good to verify that this kind of circular
> clock routing still works with this change.

Yep, this breaks this kind of routing. E.g. if you remove the
clk-output-names from the DT and add an EMIO clock input like this:
	clocks = <&clkc 15>;
	clock-names = "gem1_emio_clk";
the code will no longer be able to correctly obtain the clock name for that input.

	S?ren

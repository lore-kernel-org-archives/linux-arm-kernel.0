From: van.freenix@gmail.com (Peng Fan)
Date: Mon, 9 May 2016 20:41:43 +0800
Subject: [PATCH V2 3/3] nvmem: imx-ocotp: handling clock
In-Reply-To: <5730825E.5030101@linaro.org>
References: <1461173177-11930-1-git-send-email-van.freenix@gmail.com>
 <1461173177-11930-3-git-send-email-van.freenix@gmail.com>
 <5730825E.5030101@linaro.org>
Message-ID: <20160509124140.GA20259@linux-7smt.suse>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

On Mon, May 09, 2016 at 01:28:14PM +0100, Srinivas Kandagatla wrote:
>Thanks for the Ping, I totally missed this thread.
>
>On 20/04/16 18:26, Peng Fan wrote:
>>Before access ocotp nvmem area, the clock should be enabled.
>>Or, `hexdump nvmem` will hang the system. So, use such flow:
>>"
>>   1. clock_enable_prepare
>>   2. read nvmem ocotp area
>>   3. clock_disable_unprepare
>>"
>>
>>Signed-off-by: Peng Fan <van.freenix@gmail.com>
>>Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>>Cc: Shawn Guo <shawnguo@kernel.org>
>>---
>>
>>V2:
>>  Follow Fabio's comments, check return value of clk_prepare_enable
>>
>>  drivers/nvmem/imx-ocotp.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>
>Changes to the driver looks good to me,
>Only one comment, As the clock property is now made mandatory, you should
>update the dt-bindings with this info too.

In Documentation/devicetree/bindings/nvmem/imx-ocotp.txt,
the clock property is already marked Required properties:
"
Required properties:
- compatible: should be one of
	"fsl,imx6q-ocotp" (i.MX6Q/D/DL/S),
	"fsl,imx6sl-ocotp" (i.MX6SL), or
	"fsl,imx6sx-ocotp" (i.MX6SX), followed by "syscon".
- reg: Should contain the register base and length.
- clocks: Should contain a phandle pointing to the gated peripheral clock.

Example:

	ocotp: ocotp at 021bc000 {
		compatible = "fsl,imx6q-ocotp", "syscon";
		reg = <0x021bc000 0x4000>;
		clocks = <&clks IMX6QDL_CLK_IIM>;
	};
"

I think I do not need to update it, since it's already there -:)

Thanks,
Peng.
>
>
>thanks,
>srini

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jan 2017 17:49:27 +0100
Subject: [PATCHv5 0/5] Support for Marvell switches with integrated CPUs
In-Reply-To: <87wpdgwj72.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Fri, 27 Jan 2017 17:39:45 +0100")
References: <20170127032546.14657-1-chris.packham@alliedtelesis.co.nz>
 <87wpdgwj72.fsf@free-electrons.com>
Message-ID: <87o9yswiqw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 
 
 On ven., janv. 27 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi all,
>  
>  On ven., janv. 27 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
>
>> The 98DX3236, 98DX3336 and 98DX4251 are a set of switch ASICs with
>> integrated CPUs. They CPU block is common within these product lines and
>> (as far as I can tell/have been told) is based on the Armada XP. There
>> are a few differences due to the fact they have to squeeze the CPU into
>> the same package as the switch.
>>
>> I've rebased this series against linux-pinctrl/devel to get access to
>> mvebu_mmio_mpp_ctrl. Everything else still applies cleanly to
>> v4.10.0-rc5.
>
> Just to let you know that I plan to apply the 3 arm patch once Chris
> will have sent the new series with the minor fixes I asked on patch 3.

I meant patch 2!

And now patch 5 too :)

Gregory


> I already applied them in the for-next branch to benefit of some build
> test coverage.
>
> Stephen,
>
> you gave your Acked-by on the first patch, but don't you plan to apply
> it on the clk branch?
>
> If you really want I can apply on mvebu but there is no build
> dependencies, so the order the patches will be merged is not important.
>
> Linus,
>
> I expect you will apply the pinctrl patch on your tree as it depend of
> code already there.
>
> Thanks,
>
> Gregory
>
>>
>> Chris Packham (4):
>>   clk: mvebu: support for 98DX3236 SoC
>>     Changes in v2:
>>     - Update devicetree binding documentation for new compatible string
>>     Changes in v3:
>>     - Add 98dx3236 support to mvebu/clk-corediv.c rather than creating a new
>>       driver.
>>     - Document mv98dx3236-corediv-clock binding
>>     Changes in v4:
>>     - None
>>     Changes in v5:
>>     - Collect ack from Rob
>>     - Remove explicit initialisation of fields to 0 in mv98dx3236_coreclks
>>     - Register dummy clock provider for marvell,mv98dx3236-cpu-clock
>>   arm: mvebu: support for SMP on 98DX3336 SoC
>>     Changes in v2:
>>     - Document new enable-method value
>>     - Correct some references from 98DX4521 to 98DX3236
>>     Changes in v3:
>>     - Simplify mv98dx3236_resume_init by using of_io_request_and_map()
>>     Changes in v4:
>>     - integrate changes into platsmp.c instead of new init call
>>     - avoid duplicated code.
>>     - fix error return
>>     - Collect ack from Rob
>>     Changes in v5:
>>     - Remove useless casts (thanks to Stephen Boyd)
>>   arm: mvebu: Add device tree for 98DX3236 SoCs
>>     Changes in v2:
>>     - Update devicetree binding documentation to reflect that 98DX3336 and
>>       984251 are supersets of 98DX3236.
>>     - disable crypto block
>>     - disable sdio for 98DX3236, enable for 98DX4251
>>     Changes in v3:
>>     - fix typo 4521 -> 4251
>>     - document prestera bindings
>>     - rework corediv-clock binding
>>     - add label to packet processor node
>>     - add new compatible string for DFX server
>>     Changes in v4:
>>     - Collect ack from Rob
>>     Changes in v5:
>>     - Fixup license text. Add labels to nodes.
>>   arm: mvebu: Add device tree for db-dxbc2 and db-xc3-24g4xg boards
>>     Changes in v5:
>>     - update license text
>>     - use node labels
>>
>> Kalyan Kinthada (1):
>>   pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
>>     Changes in v2:
>>     - include sdio support for the 98DX4251
>>     Changes in v3:
>>     - None
>>     Changes in v4:
>>     - Correct some discrepencies between binding and driver.
>>     - Collect acks from Rob and Sebastian
>>     Changes in v5:
>>     - Update bindings to reflect "gpo" pins
>>     - Use mvebu_mmio_mpp_ctrl instead of armada_xp_mpp_ctrl (note this is reliant
>>       on changes queued in linux-pinctrl)
>>
>>  Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
>>  .../bindings/arm/marvell/98dx3236-resume-ctrl.txt  |  16 ++
>>  .../devicetree/bindings/arm/marvell/98dx3236.txt   |  23 ++
>>  .../bindings/clock/mvebu-corediv-clock.txt         |   1 +
>>  .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   1 +
>>  .../devicetree/bindings/net/marvell,prestera.txt   |  50 ++++
>>  .../pinctrl/marvell,armada-98dx3236-pinctrl.txt    |  46 ++++
>>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 254 +++++++++++++++++++++
>>  arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |  76 ++++++
>>  arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |  90 ++++++++
>>  arch/arm/boot/dts/db-dxbc2.dts                     | 151 ++++++++++++
>>  arch/arm/boot/dts/db-xc3-24g4xg.dts                | 142 ++++++++++++
>>  arch/arm/mach-mvebu/platsmp.c                      |  86 +++++++
>>  drivers/clk/mvebu/armada-xp.c                      |  39 ++++
>>  drivers/clk/mvebu/clk-corediv.c                    |  23 ++
>>  drivers/clk/mvebu/clk-cpu.c                        |   8 +
>>  drivers/pinctrl/mvebu/pinctrl-armada-xp.c          | 156 +++++++++++++
>>  17 files changed, 1163 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
>>  create mode 100644 Documentation/devicetree/bindings/net/marvell,prestera.txt
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
>>  create mode 100644 arch/arm/boot/dts/armada-xp-98dx3236.dtsi
>>  create mode 100644 arch/arm/boot/dts/armada-xp-98dx3336.dtsi
>>  create mode 100644 arch/arm/boot/dts/armada-xp-98dx4251.dtsi
>>  create mode 100644 arch/arm/boot/dts/db-dxbc2.dts
>>  create mode 100644 arch/arm/boot/dts/db-xc3-24g4xg.dts
>>
>> interdiff to v4:
>>
>>  diff --git a/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
>>  index 520562a7dc2a..c7b4e3a6b2c6 100644
>> @@ -85,7 +86,7 @@
>>           by address and length of the PMU DFS registers
>>   - #clock-cells : should be set to 1.
>>  diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
>> -index b3094315a3c0..0413bf8284e0 100644
>> +index b3094315a3c0..890a863ae0d0 100644
>>  --- a/drivers/clk/mvebu/armada-xp.c
>>  +++ b/drivers/clk/mvebu/armada-xp.c
>>   	return 250000000;
>> @@ -118,9 +119,6 @@
>>  +static const struct coreclk_soc_desc mv98dx3236_coreclks = {
>>  +	.get_tclk_freq = mv98dx3236_get_tclk_freq,
>>  +	.get_cpu_freq = mv98dx3236_get_cpu_freq,
>> -+	.get_clk_ratio = NULL,
>> -+	.ratios = NULL,
>> -+	.num_ratios = 0,
>>  +};
>>  +
>>   /*
>> @@ -200,53 +198,16 @@
>>  +CLK_OF_DECLARE(mv98dx3236_corediv_clk, "marvell,mv98dx3236-corediv-clock",
>>  +	       mv98dx3236_corediv_clk_init);
>>  diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
>> -index 5837eb8a212f..3b8f0e14fa01 100644
>> +index 5837eb8a212f..044892b6534d 100644
>>  --- a/drivers/clk/mvebu/clk-cpu.c
>>  +++ b/drivers/clk/mvebu/clk-cpu.c
>> - 	.set_rate = clk_cpu_set_rate,
>> - };
>> - 
>> --static void __init of_cpu_clk_setup(struct device_node *node)
>> -+/* Add parameter to allow this to support different clock operations. */
>> -+static void __init _of_cpu_clk_setup(struct device_node *node,
>> -+			const struct clk_ops *cpu_clk_ops)
>> - {
>> - 	struct cpu_clk *cpuclk;
>> - 	void __iomem *clock_complex_base = of_iomap(node, 0);
>> - 		cpuclk[cpu].hw.init = &init;
>>   
>> - 		init.name = cpuclk[cpu].clk_name;
>> --		init.ops = &cpu_ops;
>> -+		init.ops = cpu_clk_ops;
>> - 		init.flags = 0;
>> - 		init.parent_names = &cpuclk[cpu].parent_name;
>> - 		init.num_parents = 1;
>> - 	iounmap(clock_complex_base);
>> - }
>> - 
>> -+/* Use this function to call the generic setup with the correct
>> -+ * clock operation
>> -+ */
>> -+static void __init of_cpu_clk_setup(struct device_node *node)
>> -+{
>> -+	_of_cpu_clk_setup(node, &cpu_ops);
>> -+}
>> -+
>>   CLK_OF_DECLARE(armada_xp_cpu_clock, "marvell,armada-xp-cpu-clock",
>>   					 of_cpu_clk_setup);
>>  +
>> -+/* Define the clock and operations for the mv98dx3236 - it cannot perform
>> -+ * any operations.
>> -+ */
>> -+static const struct clk_ops mv98dx3236_cpu_ops = {
>> -+	.recalc_rate = NULL,
>> -+	.round_rate = NULL,
>> -+	.set_rate = NULL,
>> -+};
>> -+
>>  +static void __init of_mv98dx3236_cpu_clk_setup(struct device_node *node)
>>  +{
>> -+	_of_cpu_clk_setup(node, &mv98dx3236_cpu_ops);
>> ++	of_clk_add_provider(node, of_clk_src_simple_get, NULL);
>>  +}
>>  +
>>  +CLK_OF_DECLARE(mv98dx3236_cpu_clock, "marvell,mv98dx3236-cpu-clock",
>> @@ -285,7 +247,7 @@
>>   			    "qcom,gcc-msm8660"
>> diff --git
> a/Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
> b/Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
>>  new file mode 100644
>> -index 000000000000..8082ba872edd
>> +index 000000000000..26eb9d3aa630
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
>>  +Resume Control
>> @@ -304,10 +266,8 @@
>>  +	compatible = "marvell,98dx3336-resume-ctrl";
>>  +	reg = <0x20980 0x10>;
>>  +};
>> -+
>> -+
>>  diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
>> -index 46c742d3bd41..59be3ca0464f 100644
>> +index 46c742d3bd41..a5b464497e1a 100644
>>  --- a/arch/arm/mach-mvebu/platsmp.c
>>  +++ b/arch/arm/mach-mvebu/platsmp.c
>>   
>> @@ -327,7 +287,7 @@
>>  +static const struct of_device_id of_mv98dx3236_resume_table[] = {
>>  +	{
>>  +		.compatible = "marvell,98dx3336-resume-ctrl",
>> -+		.data = (void *)&mv98dx3336_resume_controller,
>> ++		.data = &mv98dx3336_resume_controller,
>>  +	},
>>  +	{ /* end of list */ },
>>  +};
>> @@ -337,7 +297,7 @@
>>  +	const struct of_device_id *match;
>>  +	struct device_node *np;
>>  +	void __iomem *base;
>> -+	struct resume_controller *rc;
>> ++	const struct resume_controller *rc;
>>  +
>>  +	WARN_ON(hw_cpu != 1);
>>  +
>> @@ -347,7 +307,7 @@
>>  +		return -ENODEV;
>>  +
>>  +	base = of_io_request_and_map(np, 0, of_node_full_name(np));
>> -+	rc = (struct resume_controller *)match->data;
>> ++	rc = match->data;
>>  +	of_node_put(np);
>>  +	if (IS_ERR(base))
>>  +		return PTR_ERR(base);
>> @@ -411,15 +371,17 @@
>> diff --git
> a/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
> b/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
>>  new file mode 100644
>> -index 000000000000..d4e6ecdfc853
>> +index 000000000000..97aef67ee769
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
>>  +* Marvell 98dx3236 pinctrl driver for mpp
>> @@ -435,41 +397,41 @@
>>  +
>>  +name          pins     functions
>>  +================================================================================
>> -+mpp0          0        gpio, spi0(mosi), dev(ad8)
>> ++mpp0          0        gpo, spi0(mosi), dev(ad8)
>>  +mpp1          1        gpio, spi0(miso), dev(ad9)
>> -+mpp2          2        gpio, spi0(sck), dev(ad10)
>> ++mpp2          2        gpo, spi0(sck), dev(ad10)
>>  +mpp3          3        gpio, spi0(cs0), dev(ad11)
>>  +mpp4          4        gpio, spi0(cs1), smi(mdc), dev(cs0)
>>  +mpp5          5        gpio, pex(rsto), sd0(cmd), dev(bootcs)
>> -+mpp6          6        gpio, sd0(clk), dev(a2)
>> ++mpp6          6        gpo, sd0(clk), dev(a2)
>>  +mpp7          7        gpio, sd0(d0), dev(ale0)
>>  +mpp8          8        gpio, sd0(d1), dev(ale1)
>>  +mpp9          9        gpio, sd0(d2), dev(ready0)
>>  +mpp10         10       gpio, sd0(d3), dev(ad12)
>>  +mpp11         11       gpio, uart1(rxd), uart0(cts), dev(ad13)
>> -+mpp12         12       gpio, uart1(txd), uart0(rts), dev(ad14)
>> ++mpp12         12       gpo, uart1(txd), uart0(rts), dev(ad14)
>>  +mpp13         13       gpio, intr(out), dev(ad15)
>>  +mpp14         14       gpio, i2c0(sck)
>>  +mpp15         15       gpio, i2c0(sda)
>> -+mpp16         16       gpio, dev(oe)
>> -+mpp17         17       gpio, dev(clk)
>> ++mpp16         16       gpo, dev(oe)
>> ++mpp17         17       gpo, dev(clkout)
>>  +mpp18         18       gpio, uart1(txd)
>>  +mpp19         19       gpio, uart1(rxd), dev(rb)
>> -+mpp20         20       gpio, dev(we)
>> -+mpp21         21       gpio, dev(ad0)
>> -+mpp22         22       gpio, dev(ad1)
>> -+mpp23         23       gpio, dev(ad2)
>> -+mpp24         24       gpio, dev(ad3)
>> -+mpp25         25       gpio, dev(ad4)
>> -+mpp26         26       gpio, dev(ad5)
>> -+mpp27         27       gpio, dev(ad6)
>> -+mpp28         28       gpio, dev(ad7)
>> -+mpp29         29       gpio, dev(a0)
>> -+mpp30         30       gpio, dev(a1)
>> ++mpp20         20       gpo, dev(we0)
>> ++mpp21         21       gpo, dev(ad0)
>> ++mpp22         22       gpo, dev(ad1)
>> ++mpp23         23       gpo, dev(ad2)
>> ++mpp24         24       gpo, dev(ad3)
>> ++mpp25         25       gpo, dev(ad4)
>> ++mpp26         26       gpo, dev(ad5)
>> ++mpp27         27       gpo, dev(ad6)
>> ++mpp28         28       gpo, dev(ad7)
>> ++mpp29         29       gpo, dev(a0)
>> ++mpp30         30       gpo, dev(a1)
>>  +mpp31         31       gpio, slv_smi(mdc), smi(mdc), dev(we1)
>>  +mpp32         32       gpio, slv_smi(mdio), smi(mdio), dev(cs1)
>>  diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
>> -index e4ea71a9d985..554eeae8cd21 100644
>> +index 63e1bd506983..61cbc138703e 100644
>>  --- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
>>  +++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
>>   	V_MV78460	= BIT(2),
>> @@ -495,8 +457,8 @@
>>  +		 MPP_VAR_FUNCTION(0x2, "spi0", "miso",       V_98DX3236_PLUS),
>>  +		 MPP_VAR_FUNCTION(0x4, "dev", "ad9",         V_98DX3236_PLUS)),
>>  +	MPP_MODE(2,
>> -+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
>> -+		 MPP_VAR_FUNCTION(0x2, "spi0", "csk",        V_98DX3236_PLUS),
>> ++		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
>> ++		 MPP_VAR_FUNCTION(0x2, "spi0", "sck",        V_98DX3236_PLUS),
>>  +		 MPP_VAR_FUNCTION(0x4, "dev", "ad10",        V_98DX3236_PLUS)),
>>  +	MPP_MODE(3,
>>  +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
>> @@ -511,7 +473,7 @@
>>  +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
>>  +		 MPP_VAR_FUNCTION(0x1, "pex", "rsto",        V_98DX3236_PLUS),
>>  +		 MPP_VAR_FUNCTION(0x2, "sd0", "cmd",         V_98DX4251),
>> -+		 MPP_VAR_FUNCTION(0x4, "dev", "bootcs0",     V_98DX3236_PLUS)),
>> ++		 MPP_VAR_FUNCTION(0x4, "dev", "bootcs",      V_98DX3236_PLUS)),
>>  +	MPP_MODE(6,
>>  +		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
>>  +		 MPP_VAR_FUNCTION(0x2, "sd0", "clk",         V_98DX4251),
>> @@ -563,7 +525,8 @@
>>  +		 MPP_VAR_FUNCTION(0x3, "uart1", "txd",       V_98DX3236_PLUS)),
>>  +	MPP_MODE(19,
>>  +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
>> -+		 MPP_VAR_FUNCTION(0x3, "uart1", "rxd",       V_98DX3236_PLUS)),
>> ++		 MPP_VAR_FUNCTION(0x3, "uart1", "rxd",       V_98DX3236_PLUS),
>> ++		 MPP_VAR_FUNCTION(0x4, "dev", "rb",          V_98DX3236_PLUS)),
>>  +	MPP_MODE(20,
>>  +		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
>>  +		 MPP_VAR_FUNCTION(0x4, "dev", "we0",         V_98DX3236_PLUS)),
>> @@ -630,11 +593,11 @@
>>   };
>>   
>>  +static struct mvebu_mpp_ctrl mv98dx3236_mpp_controls[] = {
>> -+	MPP_FUNC_CTRL(0, 32, NULL, armada_xp_mpp_ctrl),
>> ++	MPP_FUNC_CTRL(0, 32, NULL, mvebu_mmio_mpp_ctrl),
>>  +};
>>  +
>>  +static struct pinctrl_gpio_range mv98dx3236_mpp_gpio_ranges[] = {
>> -+	MPP_GPIO_RANGE(0,   0,  0, 32),
>> ++	MPP_GPIO_RANGE(0, 0, 0, 32),
>>  +};
>>  +
>>   static int armada_xp_pinctrl_suspend(struct platform_device *pdev,
>> @@ -767,7 +731,7 @@
>>  +};
>>  diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
>>  new file mode 100644
>> -index 000000000000..4b7b2fe3b682
>> +index 000000000000..9461128fae24
>>  --- /dev/null
>>  +++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
>>  +/*
>> @@ -785,17 +749,17 @@
>>  + *     published by the Free Software Foundation; either version 2 of the
>>  + *     License, or (at your option) any later version.
>>  + *
>> -+ *     This file is distributed in the hope that it will be useful
>> ++ *     This file is distributed in the hope that it will be useful,
>>  + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>  + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>  + *     GNU General Public License for more details.
>>  + *
>> -+ * Or, alternatively
>> ++ * Or, alternatively,
>>  + *
>>  + *  b) Permission is hereby granted, free of charge, to any person
>>  + *     obtaining a copy of this software and associated documentation
>>  + *     files (the "Software"), to deal in the Software without
>> -+ *     restriction, including without limitation the rights to use
>> ++ *     restriction, including without limitation the rights to use,
>>  + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>  + *     sell copies of the Software, and to permit persons to whom the
>>  + *     Software is furnished to do so, subject to the following
>> @@ -804,11 +768,11 @@
>>  + *     The above copyright notice and this permission notice shall be
>>  + *     included in all copies or substantial portions of the Software.
>>  + *
>> -+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
>> ++ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>  + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>  + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>  + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> -+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
>> ++ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>  + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>  + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>  + *     OTHER DEALINGS IN THE SOFTWARE.
>> @@ -851,9 +815,9 @@
>>  +			  MBUS_ID(0x08, 0x00) 0 0 0xac000000 0x100000>;
>>  +
>>  +		/*
>> -+		 * 98DX3236 has 1 x1 PCIe unit Gen2.0: One unit can be
>> ++		 * 98DX3236 has 1 x1 PCIe unit Gen2.0
>>  +		 */
>> -+		pcie-controller {
>> ++		pciec: pcie-controller at 82000000 {
>>  +			compatible = "marvell,armada-xp-pcie";
>>  +			status = "disabled";
>>  +			device_type = "pci";
>> @@ -870,7 +834,7 @@
>>  +				0x81000000 0x1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
>>  +				0x82000000 0x2 0       MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */>;
>>  +
>> -+			pcie at 1,0 {
>> ++			pcie1: pcie at 1,0 {
>>  +				device_type = "pci";
>>  +				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
>>  +				reg = <0x0800 0 0 0 0>;
>> @@ -967,7 +931,7 @@
>>  +			};
>>  +		};
>>  +
>> -+		dfx-registers {
>> ++		dfxr: dfx-registers at ac000000 {
>>  +			compatible = "simple-bus";
>>  +			#address-cells = <1>;
>>  +			#size-cells = <1>;
>> @@ -987,7 +951,7 @@
>>  +			};
>>  +		};
>>  +
>> -+		switch {
>> ++		switch: switch at a8000000 {
>>  +			compatible = "simple-bus";
>>  +			#address-cells = <1>;
>>  +			#size-cells = <1>;
>> @@ -1026,7 +990,7 @@
>>  +};
>>  diff --git a/arch/arm/boot/dts/armada-xp-98dx3336.dtsi b/arch/arm/boot/dts/armada-xp-98dx3336.dtsi
>>  new file mode 100644
>> -index 000000000000..a9b0f47f8df9
>> +index 000000000000..e1580afdc260
>>  --- /dev/null
>>  +++ b/arch/arm/boot/dts/armada-xp-98dx3336.dtsi
>>  +/*
>> @@ -1044,17 +1008,17 @@
>>  + *     published by the Free Software Foundation; either version 2 of the
>>  + *     License, or (at your option) any later version.
>>  + *
>> -+ *     This file is distributed in the hope that it will be useful
>> ++ *     This file is distributed in the hope that it will be useful,
>>  + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>  + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>  + *     GNU General Public License for more details.
>>  + *
>> -+ * Or, alternatively
>> ++ * Or, alternatively,
>>  + *
>>  + *  b) Permission is hereby granted, free of charge, to any person
>>  + *     obtaining a copy of this software and associated documentation
>>  + *     files (the "Software"), to deal in the Software without
>> -+ *     restriction, including without limitation the rights to use
>> ++ *     restriction, including without limitation the rights to use,
>>  + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>  + *     sell copies of the Software, and to permit persons to whom the
>>  + *     Software is furnished to do so, subject to the following
>> @@ -1063,16 +1027,16 @@
>>  + *     The above copyright notice and this permission notice shall be
>>  + *     included in all copies or substantial portions of the Software.
>>  + *
>> -+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
>> ++ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>  + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>  + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>  + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> -+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
>> ++ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>  + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>  + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>  + *     OTHER DEALINGS IN THE SOFTWARE.
>>  + *
>> -+ * Contains definitions specific to the 98dx3336 SoC that are not
>> ++ * Contains definitions specific to the 98dx3236 SoC that are not
>>  + * common to all Armada XP SoCs.
>>  + */
>>  +
>> @@ -1107,7 +1071,7 @@
>>  +};
>>  diff --git a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
>>  new file mode 100644
>> -index 000000000000..446e6e65ec59
>> +index 000000000000..4b0533a4ccb7
>>  --- /dev/null
>>  +++ b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
>>  +/*
>> @@ -1125,17 +1089,17 @@
>>  + *     published by the Free Software Foundation; either version 2 of the
>>  + *     License, or (at your option) any later version.
>>  + *
>> -+ *     This file is distributed in the hope that it will be useful
>> ++ *     This file is distributed in the hope that it will be useful,
>>  + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>  + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>  + *     GNU General Public License for more details.
>>  + *
>> -+ * Or, alternatively
>> ++ * Or, alternatively,
>>  + *
>>  + *  b) Permission is hereby granted, free of charge, to any person
>>  + *     obtaining a copy of this software and associated documentation
>>  + *     files (the "Software"), to deal in the Software without
>> -+ *     restriction, including without limitation the rights to use
>> ++ *     restriction, including without limitation the rights to use,
>>  + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>  + *     sell copies of the Software, and to permit persons to whom the
>>  + *     Software is furnished to do so, subject to the following
>> @@ -1144,11 +1108,11 @@
>>  + *     The above copyright notice and this permission notice shall be
>>  + *     included in all copies or substantial portions of the Software.
>>  + *
>> -+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
>> ++ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>  + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>  + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>  + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> -+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
>> ++ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>  + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>  + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>  + *     OTHER DEALINGS IN THE SOFTWARE.
>> @@ -1213,15 +1177,15 @@
>>  diff --git a/arch/arm/boot/dts/db-dxbc2.dts b/arch/arm/boot/dts/db-dxbc2.dts
>>  new file mode 100644
>> -index 000000000000..f56786cea5f8
>> +index 000000000000..a8130805074e
>>  --- /dev/null
>>  +++ b/arch/arm/boot/dts/db-dxbc2.dts
>>  +/*
>> @@ -1241,17 +1205,17 @@
>>  + *     published by the Free Software Foundation; either version 2 of the
>>  + *     License, or (at your option) any later version.
>>  + *
>> -+ *     This file is distributed in the hope that it will be useful
>> ++ *     This file is distributed in the hope that it will be useful,
>>  + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>  + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>  + *     GNU General Public License for more details.
>>  + *
>> -+ * Or, alternatively
>> ++ * Or, alternatively,
>>  + *
>>  + *  b) Permission is hereby granted, free of charge, to any person
>>  + *     obtaining a copy of this software and associated documentation
>>  + *     files (the "Software"), to deal in the Software without
>> -+ *     restriction, including without limitation the rights to use
>> ++ *     restriction, including without limitation the rights to use,
>>  + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>  + *     sell copies of the Software, and to permit persons to whom the
>>  + *     Software is furnished to do so, subject to the following
>> @@ -1260,11 +1224,11 @@
>>  + *     The above copyright notice and this permission notice shall be
>>  + *     included in all copies or substantial portions of the Software.
>>  + *
>> -+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
>> ++ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>  + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>  + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>  + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> -+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
>> ++ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>  + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>  + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>  + *     OTHER DEALINGS IN THE SOFTWARE.
>> @@ -1295,66 +1259,58 @@
>>  +		reg = <0 0x00000000 0 0x20000000>; /* 512 MB */
>>  +	};
>>  +
>> -+	soc {
>> -+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
>> -+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
>> -+			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000
>> -+			  MBUS_ID(0x03, 0x00) 0 0 0xa8000000 0x4000000
>> -+			  MBUS_ID(0x08, 0x00) 0 0 0xac000000 0x100000>;
>> ++};
>>  +
>> -+		devbus-bootcs {
>> -+			status = "okay";
>> ++&devbus_bootcs {
>> ++	status = "okay";
>>  +
>> -+			/* Device Bus parameters are required */
>> ++	/* Device Bus parameters are required */
>>  +
>> -+			/* Read parameters */
>> -+			devbus,bus-width    = <16>;
>> -+			devbus,turn-off-ps  = <60000>;
>> -+			devbus,badr-skew-ps = <0>;
>> -+			devbus,acc-first-ps = <124000>;
>> -+			devbus,acc-next-ps  = <248000>;
>> -+			devbus,rd-setup-ps  = <0>;
>> -+			devbus,rd-hold-ps   = <0>;
>> -+
>> -+			/* Write parameters */
>> -+			devbus,sync-enable = <0>;
>> -+			devbus,wr-high-ps  = <60000>;
>> -+			devbus,wr-low-ps   = <60000>;
>> -+			devbus,ale-wr-ps   = <60000>;
>> -+		};
>> ++	/* Read parameters */
>> ++	devbus,bus-width    = <16>;
>> ++	devbus,turn-off-ps  = <60000>;
>> ++	devbus,badr-skew-ps = <0>;
>> ++	devbus,acc-first-ps = <124000>;
>> ++	devbus,acc-next-ps  = <248000>;
>> ++	devbus,rd-setup-ps  = <0>;
>> ++	devbus,rd-hold-ps   = <0>;
>> ++
>> ++	/* Write parameters */
>> ++	devbus,sync-enable = <0>;
>> ++	devbus,wr-high-ps  = <60000>;
>> ++	devbus,wr-low-ps   = <60000>;
>> ++	devbus,ale-wr-ps   = <60000>;
>> ++};
>>  +
>> -+		internal-regs {
>> -+			serial at 12000 {
>> -+				status = "okay";
>> -+			};
>> -+			serial at 12100 {
>> -+				status = "okay";
>> -+			};
>> ++&i2c0 {
>> ++	clock-frequency = <100000>;
>> ++	status = "okay";
>> ++};
>>  +
>> -+			i2c at 11000 {
>> -+				clock-frequency = <100000>;
>> -+				status = "okay";
>> -+			};
>> ++&uart0 {
>> ++	status = "okay";
>> ++};
>>  +
>> -+			mvsdio at d4000 {
>> -+				pinctrl-0 = <&sdio_pins>;
>> -+				pinctrl-names = "default";
>> -+				status = "okay";
>> -+				/* No CD or WP GPIOs */
>> -+				broken-cd;
>> -+			};
>> ++&uart1 {
>> ++	status = "okay";
>> ++};
>>  +
>> -+			nand at d0000 {
>> -+				status = "okay";
>> -+				num-cs = <1>;
>> -+				marvell,nand-keep-config;
>> -+				marvell,nand-enable-arbiter;
>> -+				nand-on-flash-bbt;
>> -+				nand-ecc-strength = <4>;
>> -+				nand-ecc-step-size = <512>;
>> -+			};
>> -+		};
>> -+	};
>> ++&nand {
>> ++	status = "okay";
>> ++	num-cs = <1>;
>> ++	marvell,nand-keep-config;
>> ++	marvell,nand-enable-arbiter;
>> ++	nand-on-flash-bbt;
>> ++	nand-ecc-strength = <4>;
>> ++	nand-ecc-step-size = <512>;
>> ++};
>> ++
>> ++&sdio {
>> ++	pinctrl-0 = <&sdio_pins>;
>> ++	pinctrl-names = "default";
>> ++	status = "okay";
>> ++	/* No CD or WP GPIOs */
>> ++	broken-cd;
>>  +};
>>  +
>>  +&spi0 {
>> @@ -1385,7 +1341,7 @@
>>  +};
>>  diff --git a/arch/arm/boot/dts/db-xc3-24g4xg.dts b/arch/arm/boot/dts/db-xc3-24g4xg.dts
>>  new file mode 100644
>> -index 000000000000..5eb89ffb9a7d
>> +index 000000000000..4e07cb6ed800
>>  --- /dev/null
>>  +++ b/arch/arm/boot/dts/db-xc3-24g4xg.dts
>>  +/*
>> @@ -1405,17 +1361,17 @@
>>  + *     published by the Free Software Foundation; either version 2 of the
>>  + *     License, or (at your option) any later version.
>>  + *
>> -+ *     This file is distributed in the hope that it will be useful
>> ++ *     This file is distributed in the hope that it will be useful,
>>  + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>  + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>  + *     GNU General Public License for more details.
>>  + *
>> -+ * Or, alternatively
>> ++ * Or, alternatively,
>>  + *
>>  + *  b) Permission is hereby granted, free of charge, to any person
>>  + *     obtaining a copy of this software and associated documentation
>>  + *     files (the "Software"), to deal in the Software without
>> -+ *     restriction, including without limitation the rights to use
>> ++ *     restriction, including without limitation the rights to use,
>>  + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>  + *     sell copies of the Software, and to permit persons to whom the
>>  + *     Software is furnished to do so, subject to the following
>> @@ -1424,11 +1380,11 @@
>>  + *     The above copyright notice and this permission notice shall be
>>  + *     included in all copies or substantial portions of the Software.
>>  + *
>> -+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
>> ++ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>  + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>  + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>  + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> -+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
>> ++ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>  + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>  + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>  + *     OTHER DEALINGS IN THE SOFTWARE.
>> @@ -1458,63 +1414,50 @@
>>  +		device_type = "memory";
>>  +		reg = <0 0x00000000 0 0x40000000>; /* 1 GB */
>>  +	};
>> ++};
>>  +
>> -+	soc {
>> -+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
>> -+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
>> -+			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000
>> -+			  MBUS_ID(0x03, 0x00) 0 0 0xa8000000 0x4000000
>> -+			  MBUS_ID(0x08, 0x00) 0 0 0xac000000 0x100000>;
>> -+
>> -+		devbus-bootcs {
>> -+			status = "okay";
>> ++&devbus_bootcs {
>> ++	status = "okay";
>>  +
>> -+			/* Device Bus parameters are required */
>> ++	/* Device Bus parameters are required */
>>  +
>> -+			/* Read parameters */
>> -+			devbus,bus-width    = <16>;
>> -+			devbus,turn-off-ps  = <60000>;
>> -+			devbus,badr-skew-ps = <0>;
>> -+			devbus,acc-first-ps = <124000>;
>> -+			devbus,acc-next-ps  = <248000>;
>> -+			devbus,rd-setup-ps  = <0>;
>> -+			devbus,rd-hold-ps   = <0>;
>> -+
>> -+			/* Write parameters */
>> -+			devbus,sync-enable = <0>;
>> -+			devbus,wr-high-ps  = <60000>;
>> -+			devbus,wr-low-ps   = <60000>;
>> -+			devbus,ale-wr-ps   = <60000>;
>> -+		};
>> ++	/* Read parameters */
>> ++	devbus,bus-width    = <16>;
>> ++	devbus,turn-off-ps  = <60000>;
>> ++	devbus,badr-skew-ps = <0>;
>> ++	devbus,acc-first-ps = <124000>;
>> ++	devbus,acc-next-ps  = <248000>;
>> ++	devbus,rd-setup-ps  = <0>;
>> ++	devbus,rd-hold-ps   = <0>;
>> ++
>> ++	/* Write parameters */
>> ++	devbus,sync-enable = <0>;
>> ++	devbus,wr-high-ps  = <60000>;
>> ++	devbus,wr-low-ps   = <60000>;
>> ++	devbus,ale-wr-ps   = <60000>;
>> ++};
>>  +
>> -+		internal-regs {
>> -+			serial at 12000 {
>> -+				status = "okay";
>> -+			};
>> -+			serial at 12100 {
>> -+				status = "okay";
>> -+			};
>> ++&uart0 {
>> ++	status = "okay";
>> ++};
>>  +
>> -+			i2c at 11000 {
>> -+				clock-frequency = <100000>;
>> -+				status = "okay";
>> -+			};
>> ++&uart1 {
>> ++	status = "okay";
>> ++};
>>  +
>> -+			mvsdio at d4000 {
>> -+				status = "disabled";
>> -+			};
>> ++&i2c0 {
>> ++	clock-frequency = <100000>;
>> ++	status = "okay";
>> ++};
>>  +
>> -+			nand at d0000 {
>> -+				status = "okay";
>> -+				num-cs = <1>;
>> -+				marvell,nand-keep-config;
>> -+				marvell,nand-enable-arbiter;
>> -+				nand-on-flash-bbt;
>> -+				nand-ecc-strength = <4>;
>> -+				nand-ecc-step-size = <512>;
>> -+			};
>> -+		};
>> -+	};
>> ++&nand {
>> ++	status = "okay";
>> ++	num-cs = <1>;
>> ++	marvell,nand-keep-config;
>> ++	marvell,nand-enable-arbiter;
>> ++	nand-on-flash-bbt;
>> ++	nand-ecc-strength = <4>;
>> ++	nand-ecc-step-size = <512>;
>>  +};
>>  +
>>  +&spi0 {
>>
>> -- 
>> 2.11.0.24.ge6920cf
>>
>
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

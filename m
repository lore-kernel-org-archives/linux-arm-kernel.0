From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 5 Jan 2017 20:02:06 +0000
Subject: [PATCHv2 0/5] Support for Marvell switches with integrated CPUs
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <CAPv3WKcT8MxX+g12C1o81MmQJWRt7Rpd-hgBh8rTpLOS3vdtqA@mail.gmail.com>
Message-ID: <c79e5aa519d14c7d9fdecb187a95d1c1@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/17 03:09, Marcin Wojtas wrote:
> Hi Chris,
>
> Thanks a lot for your work and v2. Can you please add changelog
> between patchset versions in your cover letter?

Will do for v3. I did actually include a changelog in the individual 
patches but I can collate that here.

clk: mvebu: support for 98DX3236 SoC
- Update devicetree binding documentation for new compatible string
arm: mvebu: support for SMP on 98DX3336 SoC
- Document new enable-method value
- Correct some references from 98DX4521 to 98DX3236
pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
- include sdio support for the 98DX4251
arm: mvebu: Add device tree for 98DX3236 SoCs
- Update devicetree binding documentation to reflect that 98DX3336 and
   984251 are supersets of 98DX3236.
- disable crypto block
- disable sdio for 98DX3236, enable for 98DX4251
arm: mvebu: Add device tree for db-dxbc2 and db-xc3-24g4xg boards
- None

Here's the interdiff

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt 
b/Documentation/devicetree/bindings/arm/cpus.txt
index a1bcfeed5f24..3c2fd72d0bf9 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -202,6 +202,7 @@ nodes to be present and contain the properties 
described below.
                             "marvell,armada-380-smp"
                             "marvell,armada-390-smp"
                             "marvell,armada-xp-smp"
+                           "marvell,98dx3236-smp"
                             "mediatek,mt6589-smp"
                             "mediatek,mt81xx-tz-smp"
                             "qcom,gcc-msm8660"
diff --git a/Documentation/devicetree/bindings/arm/marvell/98dx3236.txt 
b/Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
index e7dc9b2dd90b..64e8c73fc5ab 100644
--- a/Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
@@ -6,5 +6,18 @@ shall have the following property:

  Required root node property:

-compatible: one of "marvell,armadaxp-98dx3236", "marvell,armadaxp-98dx3336"
-            or "marvell,armadaxp-98dx4251"
+compatible: must contain "marvell,armadaxp-98dx3236"
+
+In addition, boards using the Marvell 98DX3336 SoC shall have the
+following property:
+
+Required root node property:
+
+compatible: must contain "marvell,armadaxp-98dx3336"
+
+In addition, boards using the Marvell 98DX4251 SoC shall have the
+following property:
+
+Required root node property:
+
+compatible: must contain "marvell,armadaxp-98dx4251"
diff --git a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt 
b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
index 99c214660bdc..7f28506eaee7 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
@@ -3,6 +3,7 @@ Device Tree Clock bindings for cpu clock of Marvell EBU 
platforms
  Required properties:
  - compatible : shall be one of the following:
         "marvell,armada-xp-cpu-clock" - cpu clocks for Armada XP
+       "marvell,mv98dx3236-cpu-clock" - cpu clocks for 98DX3236 SoC
  - reg : Address and length of the clock complex register set, followed
          by address and length of the PMU DFS registers
  - #clock-cells : should be set to 1.
diff --git 
a/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt 
b/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
index 34c1e380adaa..d4e6ecdfc853 100644
--- 
a/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
+++ 
b/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
@@ -4,7 +4,7 @@ Please refer to marvell,mvebu-pinctrl.txt in this 
directory for common binding
  part and usage

  Required properties:
-- compatible: "marvell,98dx3236-pinctrl"
+- compatible: "marvell,98dx3236-pinctrl" or "marvell,98dx4251-pinctrl"
  - reg: register specifier of MPP registers

  This driver supports all 98dx3236, 98dx3336 and 98dx4251 variants
@@ -16,12 +16,12 @@ mpp1          1        gpio, spi0(miso), dev(ad9)
  mpp2          2        gpio, spi0(sck), dev(ad10)
  mpp3          3        gpio, spi0(cs0), dev(ad11)
  mpp4          4        gpio, spi0(cs1), smi(mdc), dev(cs0)
-mpp5          5        gpio, pex(rsto), dev(bootcs)
-mpp6          6        gpio, dev(a2)
-mpp7          7        gpio, dev(ale0)
-mpp8          8        gpio, dev(ale1)
-mpp9          9        gpio, dev(ready0)
-mpp10         10       gpio, dev(ad12)
+mpp5          5        gpio, pex(rsto), sd0(cmd), dev(bootcs)
+mpp6          6        gpio, sd0(clk), dev(a2)
+mpp7          7        gpio, sd0(d0), dev(ale0)
+mpp8          8        gpio, sd0(d1), dev(ale1)
+mpp9          9        gpio, sd0(d2), dev(ready0)
+mpp10         10       gpio, sd0(d3), dev(ad12)
  mpp11         11       gpio, uart1(rxd), uart0(cts), dev(ad13)
  mpp12         12       gpio, uart1(txd), uart0(rts), dev(ad14)
  mpp13         13       gpio, intr(out), dev(ad15)
diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi 
b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index bac53f8b44af..61bd3acc5cfe 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -138,6 +138,10 @@
                                 status = "disabled";
                         };

+                       crypto at 90000 {
+                               status = "disabled";
+                       };
+
                         xor at f0900 {
                                 status = "disabled";
                         };
@@ -229,3 +233,15 @@
                 marvell,function = "spi0";
         };
  };
+
+&sdio {
+       status = "disabled";
+};
+
+&crypto_sram0 {
+       status = "disabled";
+};
+
+&crypto_sram1 {
+       status = "disabled";
+};
diff --git a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi 
b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
index 5d1da8513fae..5f7edc23d5ae 100644
--- a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
@@ -76,3 +76,17 @@
                 };
         };
  };
+
+&sdio {
+       status = "okay";
+};
+
+&pinctrl {
+       compatible = "marvell,98dx4251-pinctrl";
+
+       sdio_pins: sdio-pins {
+               marvell,pins = "mpp5", "mpp6", "mpp7",
+                              "mpp8", "mpp9", "mpp10";
+               marvell,function = "sd0";
+       };
+};
diff --git a/arch/arm/mach-mvebu/pmsu-98dx3236.c 
b/arch/arm/mach-mvebu/pmsu-98dx3236.c
index fadc81d0c051..87ca42ef40c7 100644
--- a/arch/arm/mach-mvebu/pmsu-98dx3236.c
+++ b/arch/arm/mach-mvebu/pmsu-98dx3236.c
@@ -1,5 +1,5 @@
  /**
- * CPU resume support for 98DX4521 internal CPU (a.k.a. MSYS).
+ * CPU resume support for 98DX3236 internal CPU (a.k.a. MSYS).
   */

  #define pr_fmt(fmt) "mv98dx3236-resume: " fmt
@@ -38,7 +38,7 @@ static int __init mv98dx3236_resume_init(void)
         if (!np)
                 return 0;

-       pr_info("Initializing 98DX4521 Resume\n");
+       pr_info("Initializing 98DX3236 Resume\n");

         if (of_address_to_resource(np, 0, &res)) {
                 pr_err("unable to get resource\n");
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c 
b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 2586903c59f0..554eeae8cd21 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -389,21 +389,27 @@ static struct mvebu_mpp_mode 
mv98dx3236_mpp_modes[] = {
         MPP_MODE(5,
                  MPP_VAR_FUNCTION(0x0, "gpio", NULL, 
V_98DX3236_PLUS),
                  MPP_VAR_FUNCTION(0x1, "pex", "rsto", 
V_98DX3236_PLUS),
+                MPP_VAR_FUNCTION(0x2, "sd0", "cmd",         V_98DX4251),
                  MPP_VAR_FUNCTION(0x4, "dev", "bootcs0", 
V_98DX3236_PLUS)),
         MPP_MODE(6,
                  MPP_VAR_FUNCTION(0x0, "gpo", NULL, 
V_98DX3236_PLUS),
+                MPP_VAR_FUNCTION(0x2, "sd0", "clk",         V_98DX4251),
                  MPP_VAR_FUNCTION(0x4, "dev", "a2", 
V_98DX3236_PLUS)),
         MPP_MODE(7,
                  MPP_VAR_FUNCTION(0x0, "gpio", NULL, 
V_98DX3236_PLUS),
+                MPP_VAR_FUNCTION(0x2, "sd0", "d0",          V_98DX4251),
                  MPP_VAR_FUNCTION(0x4, "dev", "ale0", 
V_98DX3236_PLUS)),
         MPP_MODE(8,
                  MPP_VAR_FUNCTION(0x0, "gpio", NULL, 
V_98DX3236_PLUS),
+                MPP_VAR_FUNCTION(0x2, "sd0", "d1",          V_98DX4251),
                  MPP_VAR_FUNCTION(0x4, "dev", "ale1", 
V_98DX3236_PLUS)),
         MPP_MODE(9,
                  MPP_VAR_FUNCTION(0x0, "gpio", NULL, 
V_98DX3236_PLUS),
+                MPP_VAR_FUNCTION(0x2, "sd0", "d2",          V_98DX4251),
                  MPP_VAR_FUNCTION(0x4, "dev", "ready0", 
V_98DX3236_PLUS)),
         MPP_MODE(10,
                  MPP_VAR_FUNCTION(0x0, "gpio", NULL, 
V_98DX3236_PLUS),
+                MPP_VAR_FUNCTION(0x2, "sd0", "d3",          V_98DX4251),
                  MPP_VAR_FUNCTION(0x4, "dev", "ad12", 
V_98DX3236_PLUS)),
         MPP_MODE(11,
                  MPP_VAR_FUNCTION(0x0, "gpio", NULL, 
V_98DX3236_PLUS),
@@ -501,6 +507,10 @@ static const struct of_device_id 
armada_xp_pinctrl_of_match[] = {
                 .compatible = "marvell,98dx3236-pinctrl",
                 .data       = (void *) V_98DX3236,
         },
+       {
+               .compatible = "marvell,98dx4251-pinctrl",
+               .data       = (void *) V_98DX4251,
+       },
         { },
  };



>
> Best regards,
> Marcin
>
> 2017-01-05 4:36 GMT+01:00 Chris Packham <chris.packham@alliedtelesis.co.nz>:
>> The 98DX3236, 98DX3336 and 98DX4251 are a set of switch ASICs with
>> integrated CPUs. They CPU block is common within these product lines and
>> (as far as I can tell/have been told) is based on the Armada XP. There
>> are a few differences due to the fact they have to squeeze the CPU into
>> the same package as the switch.
>>
>> Chris Packham (4):
>>   clk: mvebu: support for 98DX3236 SoC
>>   arm: mvebu: support for SMP on 98DX3336 SoC
>>   arm: mvebu: Add device tree for 98DX3236 SoCs
>>   arm: mvebu: Add device tree for db-dxbc2 and db-xc3-24g4xg boards
>>
>> Kalyan Kinthada (1):
>>   pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
>>
>>  Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
>>  .../bindings/arm/marvell/98dx3236-resume-ctrl.txt  |  18 ++
>>  .../devicetree/bindings/arm/marvell/98dx3236.txt   |  23 ++
>>  .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   1 +
>>  .../pinctrl/marvell,armada-98dx3236-pinctrl.txt    |  46 ++++
>>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 247 +++++++++++++++++++++
>>  arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |  78 +++++++
>>  arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |  92 ++++++++
>>  arch/arm/boot/dts/db-dxbc2.dts                     | 159 +++++++++++++
>>  arch/arm/boot/dts/db-xc3-24g4xg.dts                | 155 +++++++++++++
>>  arch/arm/mach-mvebu/Makefile                       |   1 +
>>  arch/arm/mach-mvebu/common.h                       |   1 +
>>  arch/arm/mach-mvebu/platsmp.c                      |  43 ++++
>>  arch/arm/mach-mvebu/pmsu-98dx3236.c                |  69 ++++++
>>  drivers/clk/mvebu/Makefile                         |   2 +-
>>  drivers/clk/mvebu/armada-xp.c                      |  42 ++++
>>  drivers/clk/mvebu/clk-cpu.c                        |  33 ++-
>>  drivers/clk/mvebu/mv98dx3236-corediv.c             | 207 +++++++++++++++++
>>  drivers/pinctrl/mvebu/pinctrl-armada-xp.c          | 155 +++++++++++++
>>  19 files changed, 1369 insertions(+), 4 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
>>  create mode 100644 arch/arm/boot/dts/armada-xp-98dx3236.dtsi
>>  create mode 100644 arch/arm/boot/dts/armada-xp-98dx3336.dtsi
>>  create mode 100644 arch/arm/boot/dts/armada-xp-98dx4251.dtsi
>>  create mode 100644 arch/arm/boot/dts/db-dxbc2.dts
>>  create mode 100644 arch/arm/boot/dts/db-xc3-24g4xg.dts
>>  create mode 100644 arch/arm/mach-mvebu/pmsu-98dx3236.c
>>  create mode 100644 drivers/clk/mvebu/mv98dx3236-corediv.c
>>
>> --
>> 2.11.0.24.ge6920cf
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

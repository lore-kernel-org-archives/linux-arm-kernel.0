From: jgq516@gmail.com (Xiao Jiang)
Date: Thu, 31 May 2012 13:51:19 +0800
Subject: [PATCH 1/3] arm/dts: add wdt node for omap3 and omap4
In-Reply-To: <4FC631E5.9080000@ti.com>
References: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
 <1337942552-28218-2-git-send-email-jgq516@gmail.com>
 <4FC50CCD.7090404@ti.com> <4FC591C9.2050004@gmail.com>
 <4FC631E5.9080000@ti.com>
Message-ID: <4FC706D7.2010801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon and Benoit,
>> Thanks for reminding, how about below patch?
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
>> b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
>> new file mode 100644
>> index 0000000..4272d06
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
>> @@ -0,0 +1,15 @@
>> +TI Watchdog Timer (WDT) Controller for OMAP
>> +
>> +Required properties:
>> +- compatible:
>> +  - "ti,omap2-wdt" for OMAP2
>> +  - "ti,omap3-wdt" for OMAP3
>> +  - "ti,omap4-wdt" for OMAP4
>> +- ti,hwmods: Name of the hwmod associated to the WDT
>> +
>> +Examples:
>> +
>> +wdt2: wdt at 73f98000 {
>> +       compatible = "ti,omap4-wdt";
>> +       ti,hwmods = "wd_timer2";
>> +};
>>     
>
> Yes looks good. Thanks! Minor nit-pick in the example I would just copy
> the omap4 node completely with the actual omap4 address :-)
>
>   
Oops, wrong addr, :). Perhaps we can drop address as you said, since the 
right addresses are defined
in wd_timer2 hwmod (see [1]), and wdt also works without the address as 
follows.

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index f2ab4ea..0017bd8 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -63,5 +63,10 @@
                        ti,hwmods = "uart3";
                        clock-frequency = <48000000>;
                };
+
+               wdt2: wdt {
+                       compatible = "ti,omap2-wdt";
+                       ti,hwmods = "wd_timer2";
+               };
        };
 };
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 99474fa..dbf8a5b 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -215,5 +215,10 @@
                        compatible = "ti,omap3-hsmmc";
                        ti,hwmods = "mmc3";
                };
+
+               wdt2: wdt {
+                       compatible = "ti,omap3-wdt", "ti,omap2-wdt";
+                       ti,hwmods = "wd_timer2";
+               };
        };
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..ce74e87 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,10 @@
                        ti,hwmods = "mmc5";
                        ti,needs-special-reset;
                };
+
+               wdt2: wdt {
+                       compatible = "ti,omap4-wdt", "ti,omap2-wdt";
+                       ti,hwmods = "wd_timer2";
+               };
        };
 };

Infos for omap3:
# dmesg|grep Machine
<6>[    0.000000] Machine: Generic OMAP3 (Flattened Device Tree), model: 
TI OMAP3 EVM (OMAP3530, AM/DM37x)
# dmesg|grep omap_wdt_probe
<4>[    2.552825] in omap_wdt_probe: 299, res->start = 0x48314000

Infos for omap4:
root at localhost:/root> dmesg|grep Machine
[    0.000000] Machine: Generic OMAP4 (Flattened Device Tree), model: TI 
OMAP4 SDP board
root at localhost:/root> dmesg|grep omap_wdt_probe
[    1.687896] in omap_wdt_probe: 299, res->start = 0x4a314000

So can I drop the wdt addr from dts file? otherwise it is not feasible 
to add omap2 wdt node in omap2.dtsi
due to different addrs for omap2420 and omap2430.

Regards,
Xiao
[1] http://marc.info/?l=linux-omap&m=133836995026565&w=2
> Cheers
> Jon
>   

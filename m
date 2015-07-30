From: greycat@whiteboxes.ch (Mikhail Yakshin)
Date: Thu, 30 Jul 2015 12:45:41 +0300
Subject: ARM: dts: sunxi: Regulators at common board layouts
Message-ID: <55B9F245.2000300@whiteboxes.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've been analyzing various boards based on Allwinner A20 CPU and
X-Powers AXP209 PMU (to make a proper configuration for our board,
Whitebox Labs Watermelon).

There are some things very common and some things pretty different on
various boards.

Namely, there's agreement on that DCDC2 and DCDC3 and used for CPU
voltages (VDD-CPU and (VDD-SYS=VDD-INT)+VDD-DLL respectively) on all
boards I've analyzed (Olimex boards, Cubieboard / Cubietruck, BananaPi,
PCDuino, Watermelon, etc) and probably it should be kept this way.

However, what puzzles me the most so far is LDO1 regulator. According to
[AXP209 datasheet, p. 13, p. 23][1] and all the boards I've
investigated, it's used exclusively for powering VDD-RTC input of A20
CPU that supports internal CPU's RTC. LDO1 gets very special status in
AXP209 - basically, it's as close to "always on" (even on backup
battery) as possible the purpose of timekeeping.

According to the same spec, LDO1 allows 2 distinct voltage choices: 1.3V
and 3.3V. However, according to the [A20 datasheet][2], VDD-RTC (pin K8)
has absolute minimum and maximum voltage ratings of 3.0V. I'm not sure
how is it supposed to work together, given that X-Powers AXP209 and
Allwinner A20 is basically produced by different branches the same
company and are meant to be totally compatible.

What's even more weird, is that all configurations I've encountered so
far (i.e. FEX configurations for 3.4 sunxi kernel and DTS for modern
mainline kernels) use hard locked 1.3V setting for LDO1. For example,
kernel 3.4:

/sys/devices/platform/sunxi-i2c.0/i2c-0/0-0034/axp20-regulator.21/regulator/regulator.1/
name    axp20_ldo1
microvolts      1300000
min_microvolts  1300000
max_microvolts  1300000

and similar construction in mainline DTSes:

    vdd_rtc: ldo1 {
            regulator-min-microvolt = <1300000>;
            regulator-max-microvolt = <1300000>;
            regulator-always-on;
    };

or in axp209.dtsi:

    reg_ldo1: ldo1 {
            /* LDO1 is a fixed output regulator */
            regulator-always-on;
            regulator-min-microvolt = <1300000>;
            regulator-max-microvolt = <1300000>;
            regulator-name = "ldo1";
    };

If we'll take a look at default power-on setup for AXP209 in the
datasheet (page 24), we'll see that it's determined by LDO1SET pin. If
it's connected to GND, then LDO1 will start with 1.3V, if it's connected
to VINT, then it would be 3.3V.

I've analyzed all the schematics I found in public:

* Older Olimex schematics (Lime rev C, Lime rev D, Lime2 rev B) state
that LDO1 line is "3V3/30mA". LDO1SET is grounded.
* Newer Olimex schematics (Lime2 rev C) call that "1V3/30mA". LDO1SET is
grounded.
* All Bananapi and Cubieboard schematics look very similar and seem to
be originating from the same source (reference Allwinner design?) and do
not hint any voltages. LDO1SET is grounded.

Can someone explain to me how does it work / supposed to work?

[1]: http://linux-sunxi.org/images/8/89/AXP209_Datasheet_v1.0en.pdf
[2]:
https://github.com/OLIMEX/OLINUXINO/raw/master/HARDWARE/A20-PDFs/A20%20Datasheet%20v1.0%2020130227.pdf

-- 
WBR, Mikhail Yakshin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150730/ee55ae82/attachment.sig>

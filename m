From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 09:24:14 +0200
Subject: [PATCH 05/14] ARM: at91: add pinctrl support
In-Reply-To: <20120814023758.GC8836@game.jcrosoft.org>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-5-git-send-email-plagnioj@jcrosoft.com>
 <CACQ1gAjPGcnOGh9iMxKUH1FA6rHBcuOzgR_A+wkbFWYkazQPxw@mail.gmail.com>
 <20120814023758.GC8836@game.jcrosoft.org>
Message-ID: <CACQ1gAiDxMds_YrOw5zYRvvMqysERi=uRbRJL+2Cf1U7uYUD+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/14 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
> no pinctrl MUST be forced as we provide pinctrl dummies
> which will provide dummy config so not break
>
> and if you want the gpio you need to enable the pinctrl on at91 otherwise you
> not have it we can force PINCRTL_AT91 on DT but now the pinctrl need to always
> be enabled
ok, so I think it's better to force PINCTRL_AT91 :
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e91c7cd..178a619 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -352,6 +352,7 @@ config ARCH_AT91
 	select CLKDEV_LOOKUP
 	select IRQ_DOMAIN
 	select NEED_MACH_IO_H if PCCARD
+	select PINCTRL
+	select PINCTRL_AT91
 	help
 	  This enables support for systems based on Atmel
 	  AT91RM9200 and AT91SAM9* processors.
This way, older configurations will not break by selecting by default
only PINCTRL and not PINCTRL_AT91.

>>
>> I tested it with a at91sam9g35-ek board, and it hangs before the dbgu
>> line is configured.
>> ( with at91_dt_defconfig and at91sam9g35ek.dts )
> did you update you dtb before booting?
I used the one provided with your patch:
git checkout linux-at91/j/pinctrl
ARCH=arm make clean
ARCH=arm make at91_dt_defconfig
ARCH=arm make -k -j8 zImage
./scripts/dtc/dtc -I dts -O dtb arch/arm/boot/dts/at91sam9g35ek.dts -o
at91sam9g35ek.dtb
cat arch/arm/boot/zImage at91sam9g35ek.dtb > zImage.dtb
./scripts/mkuboot.sh -A arm -O linux -C none  -T kernel -a 0x20008000
-e 0x20008000 -n 'Linux-3.6-rc1+pinctrl' -d zImage.dtb uImage.bin

and I've got nothing from the kernel:
Uncompressing Linux... done, booting the kernel.

As the pinmux is still already done by the bootloader, I tried to
suppress the lines:
pinctrl-names = "default";
pinctrl-0 = <&pinctrl_dbgu>;
in the DTS, but it's the same.

But the config is ok with 3.6-rc1:
git checkout v3.6-rc1
ARCH=arm make clean
ARCH=arm make -k -j8 zImage
cat arch/arm/boot/zImage at91sam9g35ek.dtb > zImage.dtb # it's the DTB
build previously
./scripts/mkuboot.sh -A arm -O linux -C none  -T kernel -a 0x20008000
-e 0x20008000 -n 'Linux-3.6-rc1' -d zImage.dtb uImage.bin
Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.6.0-rc1 (rgenoud at lnx-rg) (gcc version 4.5.3 (Buildroot
2012.05) ) #525 Tue Aug 14 09:07:43 CEST 2012
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
[...]

>
> Best Regards,
> J.
Best regads.
Richard.

-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?

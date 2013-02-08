From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Feb 2013 12:06:48 +0000
Subject: vexpress_sysreg_probe section mismatch with 3.8-rc6
Message-ID: <20130208120648.GB3495@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

I'm not sure if you're aware of this (I couldn't find anything on the list)
but I get the following section mismatch building for TC2 with mainline:


WARNING: drivers/mfd/built-in.o(.text+0xce4): Section mismatch in reference from the function vexpress_sysreg_probe() to the function .init.text:vexpress_sysreg_setup()
The function vexpress_sysreg_probe() references
the function __init vexpress_sysreg_setup().
This is often because vexpress_sysreg_probe lacks a __init 
annotation or the annotation of vexpress_sysreg_setup is wrong.

WARNING: drivers/built-in.o(.text+0x3ee1c): Section mismatch in reference from the function vexpress_sysreg_probe() to the function .init.text:vexpress_sysreg_setup()
The function vexpress_sysreg_probe() references
the function __init vexpress_sysreg_setup().
This is often because vexpress_sysreg_probe lacks a __init 
annotation or the annotation of vexpress_sysreg_setup is wrong.

WARNING: vmlinux.o(.text+0x2031b0): Section mismatch in reference from the function vexpress_sysreg_probe() to the function .init.text:vexpress_sysreg_setup()
The function vexpress_sysreg_probe() references
the function __init vexpress_sysreg_setup().
This is often because vexpress_sysreg_probe lacks a __init 
annotation or the annotation of vexpress_sysreg_setup is wrong.


My guess is that you don't want the __init annotation on
vexpress_sysreg_setup; patch below.

Will

--->8

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 77048b1..558c292 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -313,7 +313,7 @@ static void vexpress_sysreg_config_complete(unsigned long data)
 }
 
 
-void __init vexpress_sysreg_setup(struct device_node *node)
+void vexpress_sysreg_setup(struct device_node *node)
 {
        if (WARN_ON(!vexpress_sysreg_base))
                return;

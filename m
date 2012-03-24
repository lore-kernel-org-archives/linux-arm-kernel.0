From: stigge@antcom.de (Roland Stigge)
Date: Sun, 25 Mar 2012 00:48:43 +0100
Subject: uImage with integrated dtb file
Message-ID: <4F6E5D5B.8050306@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

since I will need to maintain some machines with DT enabled kernels but 
containing a U-Boot without DT support, I sometimes need to integrate a 
dtb file into uImage.

I'm sure others have got the same issue. But searching for a while I 
only got older/meanwhile neglected approaches like:

git://kernel.ubuntu.com/jk/dt/linux-2.6.git - branch: dtbimage

I'm currently using a simple hack like attached below.

Wondering what others are doing.

Sorry if this topic has already been discussed.

Roland


--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -70,9 +70,11 @@ $(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
 clean-files := *.dtb
 
 quiet_cmd_uimage = UIMAGE  $@
-      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
+      cmd_uimage = cat $< arch/arm/boot/*.dtb > $<.tmp ; \
+                  $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
                   -C none -a $(LOADADDR) -e $(STARTADDR) \
-                  -n 'Linux-$(KERNELRELEASE)' -d $< $@
+                  -n 'Linux-$(KERNELRELEASE)' -d $<.tmp $@ ; \
+                  rm -f $<.tmp
 
 ifeq ($(CONFIG_ZBOOT_ROM),y)
 $(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)

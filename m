From: olof@lixom.net (Olof Johansson)
Date: Wed, 30 Jan 2013 19:02:03 -0800
Subject: Failure to boot...
In-Reply-To: <20130131014912.GM2637@n2100.arm.linux.org.uk>
References: <20130131014912.GM2637@n2100.arm.linux.org.uk>
Message-ID: <20130131030203.GA8374@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 01:49:12AM +0000, Russell King - ARM Linux wrote:
> Having spent today sorting out the Realview EB boot, the last thing
> I expected to find was that both my OMAP platforms are unbootable
> to the point that absolutely nothing happens after the boot loader
> transfers control.
> 
> I've not been running the boots for about a month, so I'm not sure
> when this breakage crept in.
> 
> You can see the results in the boot logs on the website.  Please
> investigate.  And I'll try without arm-soc tomorrow.
> 
> Very disappointed that the ARM kernel seems to be rather screwed at
> the moment across multiple sub-arches.

My Panda ES works with omap2plus_defconfig, but I just noticed that the
in-kernel uImage target will use a bad load/entry address so loading and
booting that uImage will hang u-boot:

Image Name:   Linux-3.8.0-rc5-00389-g120d4a8
Created:      Wed Jan 30 18:30:39 2013
Image Type:   ARM Linux Kernel Image (uncompressed)
Data Size:    3843912 Bytes = 3753.82 kB = 3.67 MB
Load Address: fffffff2
Entry Point:  fffffff2

Looking at the latest build and boot log for SDP (oldconfig) on your build
status site verifies that you hit that case too. :(

Wrapping by hand (which my scripts already do) produces a bootable image; just
verified both with and without device-tree on my panda.

git bisect points at a069486162a59513053cf772515217ca61727704 (ARM: OMAP2+:
Enable ARCH_MULTIPLATFORM support)

Hmm. This happens because nothing sources arch/arm/mach-*/Makefile.boot for
CONFIG_ARCH_MULTIPLATFORM builds, even if only a single platform is enabled,
since $MACHINE is empty.

It seems like most of the available options to deal with this are bad. One
thing we should never do though, is to pretend to make a working uImage
when we're not.  Maybe abort building just like in the case of multiple
load addresses?


diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index abfce28..71768b8 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -68,8 +68,8 @@ else
 endif
 
 check_for_multiple_loadaddr = \
-if [ $(words $(UIMAGE_LOADADDR)) -gt 1 ]; then \
-	echo 'multiple load addresses: $(UIMAGE_LOADADDR)'; \
+if [ $(words $(UIMAGE_LOADADDR)) -ne 1 ]; then \
+	echo 'multiple (or no) load addresses: $(UIMAGE_LOADADDR)'; \
 	echo 'This is incompatible with uImages'; \
 	echo 'Specify LOADADDR on the commandline to build an uImage'; \
 	false; \



-Olof

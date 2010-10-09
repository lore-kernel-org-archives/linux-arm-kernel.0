From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 9 Oct 2010 16:43:24 +0200
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <AANLkTimDd10oj=rruYcB=qTaWWMAJvSCQAJNi+nQqzp7@mail.gmail.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<201010091311.26335.arnd@arndb.de>
	<AANLkTimDd10oj=rruYcB=qTaWWMAJvSCQAJNi+nQqzp7@mail.gmail.com>
Message-ID: <201010091643.25065.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 October 2010 13:59:45 Felipe Contreras wrote:
> I know of tidspbridge, in my original mail I listed some links, one
> which mentions: sh_mobile_ceu_camera, maybe i.MX31 users of the
> mx3_camera driver: pcm037 and mx31moboard.
>
> http://article.gmane.org/gmane.linux.ports.sh.devel/8560

sh_mobile_ceu_camera looks fine on mainline. It only remaps
the mmio registers, so no problem there. No arm platform even
declares the device, so the report must be with an external tree.

The mx3_camera driver also looks fine, there is only one ioremap
in there, which is completely sane.
 
> From the looks of it, PowerVR SGX seems like it will be broken too:
> http://meego.gitorious.org/meego-os-base/kernel-source/trees/master/patches

Not our problem, they already have a forked kernel tree with broken
drivers, they can fix it themselves or submit an acceptable driver
upstream if they want people to care about not breaking it.

> But my guess is that most of the issues would be found after releasing
> .36, and of course the current issues cannot possibly be fixed in that
> time-frame.

My guess is that tidspbridge is the only driver that someone (i.e. you)
cares about being broken more than it already is in the mainline kernel. :-)

How about the patch below?

	Arnd
---
staging/tidspbridge: add memory consistency to TODO list

This driver uses ioremap on regular memory to get an uncached mapping,
which causes problems on ARMv6 and higher due to aliasing with the
cached linar kernel mapping.

Make sure this gets fixed before the driver graduates from staging.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/staging/tidspbridge/TODO b/drivers/staging/tidspbridge/TODO
index 54f4a29..187363f 100644
--- a/drivers/staging/tidspbridge/TODO
+++ b/drivers/staging/tidspbridge/TODO
@@ -13,6 +13,7 @@
 * Audit and clean up header files folder
 * Use kernel coding style
 * checkpatch.pl fixes
+* allocate ext_mem_pool from consistent memory instead of using ioremap
 
 Please send any patches to Greg Kroah-Hartman <greg@kroah.com>
 and Omar Ramirez Luna <omar.ramirez@ti.com>.

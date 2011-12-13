From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 13 Dec 2011 07:31:42 +0100
Subject: [PATCH 10/19] wm1133-ev1: only register when running on the right
 machine
In-Reply-To: <1323757911-25217-1-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
Message-ID: <1323757911-25217-10-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

without this fix, a kernel compiled with mx3_defconfig
and running on a cpuimx35sd leads to :

asoc: tlv320aic23-hifi <-> imx-ssi.0 mapping ok
------------[ cut here ]------------
WARNING: at fs/sysfs/dir.c:481 sysfs_add_one+0x88/0xb0()
sysfs: cannot create duplicate filename '/devices/platform/soc-audio'
Modules linked in:
[<c0014384>] (unwind_backtrace+0x0/0xf0) from [<c0026260>] (warn_slowpath_common+0x4c/0x64)
[<c0026260>] (warn_slowpath_common+0x4c/0x64) from [<c002630c>] (warn_slowpath_fmt+0x30/0x40)
[<c002630c>] (warn_slowpath_fmt+0x30/0x40) from [<c00ebc80>] (sysfs_add_one+0x88/0xb0)
[<c00ebc80>] (sysfs_add_one+0x88/0xb0) from [<c00ebd08>] (create_dir+0x60/0xb8)
[<c00ebd08>] (create_dir+0x60/0xb8) from [<c00ebe0c>] (sysfs_create_dir+0x80/0xc8)
[<c00ebe0c>] (sysfs_create_dir+0x80/0xc8) from [<c0180d44>] (kobject_add_internal+0xac/0x1d0)
[<c0180d44>] (kobject_add_internal+0xac/0x1d0) from [<c018113c>] (kobject_add+0x50/0x98)
[<c018113c>] (kobject_add+0x50/0x98) from [<c01c4800>] (device_add+0xb0/0x5fc)
[<c01c4800>] (device_add+0xb0/0x5fc) from [<c01c8860>] (platform_device_add+0xfc/0x238)
[<c01c8860>] (platform_device_add+0xfc/0x238) from [<c0464d60>] (wm1133_ev1_audio_init+0x58/0x80)
[<c0464d60>] (wm1133_ev1_audio_init+0x58/0x80) from [<c0008670>] (do_one_initcall+0x34/0x17c)
[<c0008670>] (do_one_initcall+0x34/0x17c) from [<c045177c>] (kernel_init+0x78/0x11c)
[<c045177c>] (kernel_init+0x78/0x11c) from [<c000f514>] (kernel_thread_exit+0x0/0x8)
---[ end trace 4453d8d40de9f5ff ]---
kobject_add_internal failed for soc-audio with -EEXIST, don't try to register things with the same name in the same directory.
[<c0014384>] (unwind_backtrace+0x0/0xf0) from [<c0180e50>] (kobject_add_internal+0x1b8/0x1d0)
[<c0180e50>] (kobject_add_internal+0x1b8/0x1d0) from [<c018113c>] (kobject_add+0x50/0x98)
[<c018113c>] (kobject_add+0x50/0x98) from [<c01c4800>] (device_add+0xb0/0x5fc)
[<c01c4800>] (device_add+0xb0/0x5fc) from [<c01c8860>] (platform_device_add+0xfc/0x238)
[<c01c8860>] (platform_device_add+0xfc/0x238) from [<c0464d60>] (wm1133_ev1_audio_init+0x58/0x80)
[<c0464d60>] (wm1133_ev1_audio_init+0x58/0x80) from [<c0008670>] (do_one_initcall+0x34/0x17c)
[<c0008670>] (do_one_initcall+0x34/0x17c) from [<c045177c>] (kernel_init+0x78/0x11c)
[<c045177c>] (kernel_init+0x78/0x11c) from [<c000f514>] (kernel_thread_exit+0x0/0x8)

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel at alsa-project.org
---
 sound/soc/imx/wm1133-ev1.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/wm1133-ev1.c b/sound/soc/imx/wm1133-ev1.c
index 490a126..147ae69 100644
--- a/sound/soc/imx/wm1133-ev1.c
+++ b/sound/soc/imx/wm1133-ev1.c
@@ -20,6 +20,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <asm/mach-types.h>
 
 #include <mach/audmux.h>
 
@@ -266,6 +267,10 @@ static int __init wm1133_ev1_audio_init(void)
 	int ret;
 	unsigned int ptcr, pdcr;
 
+	if (!machine_is_mx31ads())
+		/* return happy. We might run on a totally different machine */
+		return 0;
+
 	/* SSI0 mastered by port 5 */
 	ptcr = MXC_AUDMUX_V2_PTCR_SYN |
 		MXC_AUDMUX_V2_PTCR_TFSDIR |
-- 
1.7.6.4

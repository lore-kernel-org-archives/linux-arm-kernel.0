From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 19 Jan 2010 06:45:17 +0100
Subject: [PATCH] staging/dream: add missing include files/fix compilation
In-Reply-To: <20100115002419.GA25643@kroah.com>
References: <20091225205917.GA25761@elf.ucw.cz>
	<20100115002419.GA25643@kroah.com>
Message-ID: <20100119054516.GB22153@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2010-01-14 16:24:19, Greg KH wrote:
> On Fri, Dec 25, 2009 at 09:59:18PM +0100, Pavel Machek wrote:
> > This adds missing include files, so it should now compile. ifdef
> > guards were added to Kconfig, so it should not cause problems on
> > non-arch-msm machines.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> Odd, this doesn't apply to the linux-next tree, some of the files are
> already there.

Strange, it seems it is almost all already in. Well, good :-).

But there's small problem. linux-next now contains dwalker's tree, and
I could not get it to compile, even with staging disabled. I'll need
to look into that.

Here are remaining few patches, now easy to read. (It also shows that
at least CONFIG_AMSS_VERSION and CONFIG_GPIO should really be in
arch/arm. I believe it will get there in .34 or so...)

---

Guard whole dream/ specific Kconfig with CONFIG_DREAM so that we don't
cause compile failures in other architectures. Add missing pieces so
that it compiles.

I am not sure if this is ready for staging. I guess we should wait
till I get tree to compile in -next...?

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/staging/dream/Kconfig b/drivers/staging/dream/Kconfig
index 4afa081..a824417 100644
--- a/drivers/staging/dream/Kconfig
+++ b/drivers/staging/dream/Kconfig
@@ -1,16 +1,55 @@
 config DREAM
-       tristate "HTC Dream support"
-       depends on BROKEN
+       bool "HTC Dream support"
+       depends on ARCH_MSM
+
+if DREAM
 
 source "drivers/staging/dream/smd/Kconfig"
 
 source "drivers/staging/dream/camera/Kconfig"
 
+config MSM_AMSS_VERSION
+	int
+	default 6210 if MSM_AMSS_VERSION_6210
+	default 6220 if MSM_AMSS_VERSION_6220
+	default 6225 if MSM_AMSS_VERSION_6225
+	default 6350 if MSM_AMSS_VERSION_6350
+
+choice
+	prompt "AMSS modem firmware version"
+
+	default MSM_AMSS_VERSION_6225
+
+	config MSM_AMSS_VERSION_6210
+		bool "6.2.10"
+
+	config MSM_AMSS_VERSION_6220
+		bool "6.2.20"
+
+	config MSM_AMSS_VERSION_6225
+		bool "6.2.20 + New ADSP"
+
+	config MSM_AMSS_VERSION_6350
+		bool "6.3.50"
+endchoice
+
+config MSM_ADSP
+	tristate "MSM ADSP driver"
+	default y
+	help
+	  Provides access to registers needed by the userspace aDSP library.
 
 config INPUT_GPIO
 	tristate "GPIO driver support"
 	help
 	  Say Y here if you want to support gpio based keys, wheels etc...
 
+config GENERIC_GPIO
+	bool
+	default y
 
+config ANDROID_PMEM
+	bool "Android pmem allocator"
+	default y
 
+endif
diff --git a/drivers/staging/dream/Makefile b/drivers/staging/dream/Makefile
index 2b79151..f1e0429 100644
--- a/drivers/staging/dream/Makefile
+++ b/drivers/staging/dream/Makefile
@@ -1,4 +1,7 @@
+EXTRA_CFLAGS=-Idrivers/staging/dream/include
 obj-$(CONFIG_MSM_ADSP)		+= qdsp5/ smd/
 obj-$(CONFIG_MSM_CAMERA)	+= camera/
 obj-$(CONFIG_INPUT_GPIO)	+= gpio_axis.o gpio_event.o gpio_input.o gpio_matrix.o gpio_output.o
+obj-$(CONFIG_ANDROID_PMEM)	+= pmem.o
+obj-y				+= generic_gpio.o
 
diff --git a/drivers/staging/dream/camera/mt9t013.c b/drivers/staging/dream/camera/mt9t013.c
index 88229f2..ecb4866 100644
--- a/drivers/staging/dream/camera/mt9t013.c
+++ b/drivers/staging/dream/camera/mt9t013.c
@@ -9,7 +9,7 @@
 #include <linux/miscdevice.h>
 #include <linux/kernel.h>
 #include <media/msm_camera.h>
-#include <mach/gpio.h>
+#include <linux/gpio.h>
 #include <mach/camera.h>
 #include <asm/mach-types.h>
 #include "mt9t013.h"
diff --git a/drivers/staging/dream/qdsp5/adsp.c b/drivers/staging/dream/qdsp5/adsp.c
index 9069535..1fab9ce 100644
--- a/drivers/staging/dream/qdsp5/adsp.c
+++ b/drivers/staging/dream/qdsp5/adsp.c
@@ -45,6 +45,7 @@ static inline void allow_suspend(void)
 #include "adsp.h"
 
 #define INT_ADSP INT_ADSP_A9_A11
+#define MSM_AD5_BASE          IOMEM(0xE0300000)
 
 static struct adsp_info adsp_info;
 static struct msm_rpc_endpoint *rpc_cb_server_client;
diff --git a/drivers/staging/dream/qdsp5/snd.c b/drivers/staging/dream/qdsp5/snd.c
index 037d7ff..9ee0d90 100644
--- a/drivers/staging/dream/qdsp5/snd.c
+++ b/drivers/staging/dream/qdsp5/snd.c
@@ -28,6 +28,16 @@
 #include <mach/board.h>
 #include <mach/msm_rpcrouter.h>
 
+struct snd_endpoint {
+        int id;
+        const char *name;
+};
+
+struct msm_snd_endpoints {
+        struct snd_endpoint *endpoints;
+        unsigned num;
+};
+
 struct snd_ctxt {
 	struct mutex lock;
 	int opened;




-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

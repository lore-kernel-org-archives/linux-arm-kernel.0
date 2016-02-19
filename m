From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Feb 2016 18:07:25 +0000
Subject: [PATCH 4/9] ARM: add CONFIG_PHYS_OFFSET default values
In-Reply-To: <alpine.LFD.2.20.1602191215140.13632@knanqh.ubzr>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <3974581.yknKb3tq7o@wuerfel>
 <alpine.LFD.2.20.1602191106020.13632@knanqh.ubzr>
 <38246773.SnToSslHuj@wuerfel>
 <alpine.LFD.2.20.1602191215140.13632@knanqh.ubzr>
Message-ID: <20160219180725.GB19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 12:31:02PM -0500, Nicolas Pitre wrote:
> Yet, the only reason for a default here is to accommodate automatic 
> build tests like randconfig, right?
> 
> If so then this should be "fixed" by having the config system provide 
> built-in symbols that can be tested from kconfig files.  This way you 
> could terminate the above list with:
> 
> 	default 0x00000000 if RANDCONFIG || ALLYESCONFIG
> 
> or the like.

I've suggested in the past that we have kconf read a seed file for
these configurations.  kconf already has most of the required support
for this, we just need to teach it where to read it from.  Maybe
something like this.

 arch/arm/allrandom.config |  1 +
 scripts/kconfig/conf.c    | 61 ++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/arch/arm/allrandom.config b/arch/arm/allrandom.config
index e69de29bb2d1..5a70ef5926f5 100644
--- a/arch/arm/allrandom.config
+++ b/arch/arm/allrandom.config
@@ -0,0 +1 @@
+CONFIG_PHYS_OFFSET=0
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 866369f10ff8..5a4b2d8bbf9a 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -12,6 +12,7 @@
 #include <time.h>
 #include <unistd.h>
 #include <getopt.h>
+#include <sys/fcntl.h>
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <errno.h>
@@ -489,10 +490,53 @@ static void conf_usage(const char *progname)
 	printf("  --randconfig            New config with random answer to all options\n");
 }
 
+static int try_allconfig(int try_arch, int input_mode)
+{
+	const char *name = NULL;
+	int fd = -1, ret;
+
+	if (try_arch) {
+		const char *srctree = getenv("srctree");
+		const char *arch = getenv("ARCH");
+		
+		fd = open(".", O_DIRECTORY);
+		if (fd == -1) {
+			perror("opening .");
+			return -1;
+		}
+		if (chdir(srctree) == -1 ||
+		    chdir("arch") == -1 ||
+		    chdir(arch) == -1) {
+			perror("chdir");
+			return -1;
+		}
+	}
+
+	switch (input_mode) {
+	case allnoconfig:	name = "allno.config"; break;
+	case allyesconfig:	name = "allyes.config"; break;
+	case allmodconfig:	name = "allmod.config"; break;
+	case alldefconfig:	name = "alldef.config"; break;
+	case randconfig:	name = "allrandom.config"; break;
+	default: break;
+	}
+
+	ret = name ? conf_read_simple(name, S_DEF_USER) : 1;
+	if (ret)
+		ret = conf_read_simple("all.config", S_DEF_USER);
+
+	if (fd >= 0) {
+		fchdir(fd);
+		close(fd);
+	}
+
+	return ret;
+}
+
 int main(int ac, char **av)
 {
 	const char *progname = av[0];
-	int opt;
+	int opt, ret;
 	const char *name, *defconfig_file = NULL /* gcc uninit */;
 	struct stat tmpstat;
 
@@ -601,6 +645,9 @@ int main(int ac, char **av)
 	case allmodconfig:
 	case alldefconfig:
 	case randconfig:
+		ret = try_allconfig(1, input_mode);
+		if (ret < 0)
+			exit(1);
 		name = getenv("KCONFIG_ALLCONFIG");
 		if (!name)
 			break;
@@ -613,16 +660,8 @@ int main(int ac, char **av)
 			}
 			break;
 		}
-		switch (input_mode) {
-		case allnoconfig:	name = "allno.config"; break;
-		case allyesconfig:	name = "allyes.config"; break;
-		case allmodconfig:	name = "allmod.config"; break;
-		case alldefconfig:	name = "alldef.config"; break;
-		case randconfig:	name = "allrandom.config"; break;
-		default: break;
-		}
-		if (conf_read_simple(name, S_DEF_USER) &&
-		    conf_read_simple("all.config", S_DEF_USER)) {
+		ret = try_allconfig(0, input_mode);
+		if (ret) {
 			fprintf(stderr,
 				_("*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n"),
 				name);

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.

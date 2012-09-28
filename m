From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2012 23:36:13 +0200
Subject: [PATCH 08/12] dtc: be more quiet with "make -s"
In-Reply-To: <1348868177-21205-1-git-send-email-arnd@arndb.de>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
Message-ID: <1348868177-21205-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On a normal build, we get output from both make and from dtc
about each file that is being processed.

  DTC     arch/arm/boot/vexpress-v2p-ca5s.dtb
DTC: dts->dtb  on file "/git/arnd/linux-arm/arch/arm/boot/dts/vexpress-v2p-ca5s.dts"
  DTC     arch/arm/boot/vexpress-v2p-ca9.dtb
DTC: dts->dtb  on file "/git/arnd/linux-arm/arch/arm/boot/dts/vexpress-v2p-ca9.dts"
  DTC     arch/arm/boot/vexpress-v2p-ca15-tc1.dtb
DTC: dts->dtb  on file "/git/arnd/linux-arm/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts"
  DTC     arch/arm/boot/vexpress-v2p-ca15_a7.dtb
DTC: dts->dtb  on file "/git/arnd/linux-arm/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts"

When both lines refer to the same action. When building with "make -s",
the "DTC: dts->dtb ..." line is the only output we currently get.

This patch makes dtc not output the message when the "-q" flag is passed,
and ensures that we pass it in both cases.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Marek <mmarek@suse.cz>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: David Gibson <dwg@au1.ibm.com>
---
 scripts/Makefile.lib |    2 +-
 scripts/dtc/dtc.c    |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0be6f11..662528a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -264,7 +264,7 @@ $(obj)/%.dtb.S: $(obj)/%.dtb
 	$(call cmd,dt_S_dtb)
 
 quiet_cmd_dtc = DTC     $@
-cmd_dtc = $(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0 $(DTC_FLAGS) -d $(depfile) $<
+cmd_dtc = $(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0 $(DTC_FLAGS) -q -d $(depfile) $<
 
 # Bzip2
 # ---------------------------------------------------------------------------
diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
index 2ef5e2e..a1586ff 100644
--- a/scripts/dtc/dtc.c
+++ b/scripts/dtc/dtc.c
@@ -188,8 +188,9 @@ int main(int argc, char *argv[])
 	if (minsize)
 		fprintf(stderr, "DTC: Use of \"-S\" is deprecated; it will be removed soon, use \"-p\" instead\n");
 
-	fprintf(stderr, "DTC: %s->%s  on file \"%s\"\n",
-		inform, outform, arg);
+	if (!quiet)
+		fprintf(stderr, "DTC: %s->%s  on file \"%s\"\n",
+			inform, outform, arg);
 
 	if (depname) {
 		depfile = fopen(depname, "w");
-- 
1.7.10

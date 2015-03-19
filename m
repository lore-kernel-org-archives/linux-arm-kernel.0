From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 18 Mar 2015 20:38:16 -0700
Subject: [patch 5/7] dt: dtb version: kbuild scripts
In-Reply-To: <550A42AC.8060104@gmail.com>
References: <550A42AC.8060104@gmail.com>
Message-ID: <550A44A8.9090302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Rowand <frank.rowand@sonymobile.com>

After applying this patch, need to add execute permission to the new file
scripts/version_dtb_increment_once

Modify the dtb compile rules to generate dtb version header files.

Create script to increment .version_dtb just once per make of one of more
dtbs, and to generate the dtb version header files.

Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
---
 scripts/Makefile.lib                         |   20 ++++--
 scripts/version_dtb_increment_once           |   90 +++++++++++++++++++++++++++

Index: b/scripts/Makefile.lib
===================================================================
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -159,11 +159,19 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NO
 
 ld_flags       = $(LDFLAGS) $(ldflags-y)
 
+# Do not want to pull kernel header files into .dtb, so minimize the risk of
+# that by adding include/generated/ to include path instead of include/
+# Headers in include/generated/ are used by include/dt-bindings/version.dtsi
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 -I$(srctree)/arch/$(SRCARCH)/boot/dts                   \
 		 -I$(srctree)/arch/$(SRCARCH)/boot/dts/include           \
 		 -I$(srctree)/drivers/of/testcase-data                   \
-		 -undef -D__DTS__
+		 -Iinclude/generated                                     \
+		 -undef -D__DTS__                                        \
+		 -D___DTB_DTB_PATH="\"$@\""                              \
+		 -D___DTB_DTS_PATH="\"$<\""                              \
+		 -D"___DTB_DTC_VERSION=\"$(shell scripts/dtc/dtc -v | cut -d" " -f2-)\""
+
 
 # Finds the multi-part object the current object will be linked into
 modname-multi = $(sort $(foreach m,$(multi-used),\
@@ -282,10 +290,12 @@ $(obj)/%.dtb.S: $(obj)/%.dtb
 	$(call cmd,dt_S_dtb)
 
 quiet_cmd_dtc = DTC     $@
-cmd_dtc = $(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
-	$(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0 \
-		-i $(dir $<) $(DTC_FLAGS) \
-		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
+cmd_dtc =                                                                  \
+	$(srctree)/scripts/version_dtb_increment_once ;                    \
+	$(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ;   \
+	$(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0                       \
+		-i $(dir $<) $(DTC_FLAGS)                                  \
+		-d $(depfile).dtc.tmp $(dtc-tmp) ;                         \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
 $(obj)/%.dtb: $(src)/%.dts FORCE
Index: b/scripts/version_dtb_increment_once
===================================================================
--- /dev/null
+++ b/scripts/version_dtb_increment_once
@@ -0,0 +1,90 @@
+#!/bin/sh
+
+# increment .version_dtb at most once per build
+
+# VERSION_DTB_BASE is exported instead of passed to this script as an arg.
+#
+# If the value is passed as an arg then the make dependency triggers on
+# every build of a .dtb because if_changed_dep detects that cmd_dtc has
+# changed since the previous build (see scripts/Makefile.lib).
+
+# Nice output in kbuild format
+# Will be supressed by "make -s"
+info()
+{
+	if [ "${quiet}" != "silent_" ]; then
+		printf "  %-7s %s\n" ${1} ${2}
+	fi
+}
+
+
+# flock(1) to avoid race in parallel build
+(flock 9
+
+	if [ ! -r .version_dtb -o ! -s .version_dtb ] ; then
+		rm -f .version_dtb
+		touch .version_dtb
+	fi
+
+	VERSION_DTB=`cat .version_dtb`
+	if [ "${VERSION_DTB}" != "${VERSION_DTB_BASE}" ] ; then
+		exit
+	fi
+
+	info GEN .version_dtb
+
+	VERSION_DTB=`expr 0${VERSION_DTB} + 1`
+	echo ${VERSION_DTB} > .version_dtb
+
+	# Do not expand names
+	set -f
+
+	# Fix the language to get consistent output
+	LC_ALL=C
+	export LC_ALL
+
+	if [ -z "$KBUILD_BUILD_TIMESTAMP" ]; then
+		TIMESTAMP=`date`
+	else
+		TIMESTAMP=$KBUILD_BUILD_TIMESTAMP
+	fi
+	if test -z "$KBUILD_BUILD_USER"; then
+		COMPILE_BY=$(whoami | sed 's/\\/\\\\/')
+	else
+		COMPILE_BY=$KBUILD_BUILD_USER
+	fi
+	if test -z "$KBUILD_BUILD_HOST"; then
+		COMPILE_HOST=`hostname`
+	else
+		COMPILE_HOST=$KBUILD_BUILD_HOST
+	fi
+
+	DTB_COMPILER=`scripts/dtc/dtc -v | cut -d" " -f2-`
+
+	VERSION="UTS_RELEASE (${COMPILE_BY}@${COMPILE_HOST}) (${DTB_COMPILER}) #${VERSION_DTB} ${TIMESTAMP}"
+
+	# truncate to get same result as scripts/mkcompile_h
+	UTS_LEN=64
+	TRUNCATE="cut -b -$UTS_LEN"
+
+
+	# Generate compile_dtb.h
+	TARGET=include/generated/compile_dtb.h
+	info UPD $TARGET
+
+	( echo /\* This file is auto generated, version ${VERSION_DTB} \*/
+
+  	echo -n \#define DTB_VERSION  \"\(
+  	echo -n `echo ${COMPILE_BY} | $TRUNCATE`
+  	echo -n @
+  	echo -n `echo ${COMPILE_HOST} | $TRUNCATE`
+  	echo -n \) \(${DTB_COMPILER}\) \#${VERSION_DTB} ${TIMESTAMP}
+  	echo    \"
+
+	) > $TARGET
+
+
+) 9> .version_dtb_flock
+
+# Do not place anything here.  Exit from inside flock(1) will come here
+# instead of exiting script.

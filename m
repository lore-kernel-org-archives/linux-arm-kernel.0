From: lianglihao@huawei.com (lianglihao at huawei.com)
Date: Fri, 8 Dec 2017 18:13:43 +0800
Subject: [PATCH] rcutorture: Add basic ARM64 support to run scripts
Message-ID: <1512728023-37977-1-git-send-email-lianglihao@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lihao Liang <lianglihao@huawei.com>

This commit adds support of the qemu command qemu-system-aarch64
to rcutorture. Use the following command to run:

  ./kvm.sh --qemu-cmd qemu-system-aarch64

Signed-off-by: Lihao Liang <lianglihao@huawei.com>
---

The max CPUs supported by qemu machine 'virt' is 8 so the value of
CONFIG_NR_CPUS in some test configuration files needs to be adjusted.

 tools/testing/selftests/rcutorture/bin/functions.sh | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 07a1377..5ffe4fe 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -136,6 +136,9 @@ identify_boot_image () {
 		qemu-system-x86_64|qemu-system-i386)
 			echo arch/x86/boot/bzImage
 			;;
+		qemu-system-aarch64)
+			echo arch/arm64/boot/Image
+			;;
 		*)
 			echo vmlinux
 			;;
@@ -185,7 +188,14 @@ identify_qemu_append () {
 	then
 		echo root=/dev/sda
 	else
-		echo console=ttyS0
+		case "$1" in
+		qemu-system-aarch64)
+			echo console=ttyAMA0
+			;;
+		*)
+			echo console=ttyS0
+			;;
+		esac
 	fi
 }
 
@@ -197,6 +207,9 @@ identify_qemu_args () {
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
 		;;
+	qemu-system-aarch64)
+		echo -M virt -cpu host
+		;;
 	qemu-system-ppc64)
 		echo -enable-kvm -M pseries -nodefaults
 		echo -device spapr-vscsi
@@ -257,6 +270,9 @@ specify_qemu_cpus () {
 		qemu-system-x86_64|qemu-system-i386)
 			echo $2 -smp $3
 			;;
+		qemu-system-aarch64)
+			echo $2 -smp $3
+			;;
 		qemu-system-ppc64)
 			nt="`lscpu | grep '^NUMA node0' | sed -e 's/^[^,]*,\([0-9]*\),.*$/\1/'`"
 			echo $2 -smp cores=`expr \( $3 + $nt - 1 \) / $nt`,threads=$nt
-- 
2.7.4

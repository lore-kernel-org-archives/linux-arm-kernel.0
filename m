From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Tue, 27 Sep 2016 08:53:47 -0700
Subject: [PATCH] arm64: set path to Image.gz in the mkspec to avoid rpm build
 issue
Message-ID: <1474991627-1743-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In addition to http://www.spinics.net/lists/arm-kernel/msg527466.html

While building rpm-pkg target it fails to copy kernel image
from default location to rpm buildroot directory.

Since we have arch variable set to aarch64 while Image.gz
is located at arch/arm64/boot it's necessary to specify
correct path to cp command as it implemeted for ppc64 build.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
---
 scripts/package/mkspec | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 57673ba..2f2bc7e 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -101,9 +101,13 @@ echo "%ifarch ppc64"
 echo "cp vmlinux arch/powerpc/boot"
 echo "cp arch/powerpc/boot/"'$KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$KERNELRELEASE"
 echo "%else"
+echo "%ifarch aarch64"
+echo "cp arch/arm64/boot/"'$KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$KERNELRELEASE"
+echo "%else"
 echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$KERNELRELEASE"
 echo "%endif"
 echo "%endif"
+echo "%endif"
 
 echo 'make %{?_smp_mflags} INSTALL_HDR_PATH=$RPM_BUILD_ROOT/usr KBUILD_SRC= headers_install'
 echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$KERNELRELEASE"
-- 
1.8.3.1

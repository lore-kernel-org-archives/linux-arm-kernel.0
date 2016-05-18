From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 18:07:29 +0200
Subject: [PATCH 1/5] headers_check: don't warn about c++ guards
In-Reply-To: <1463587653-3035181-1-git-send-email-arnd@arndb.de>
References: <1463587653-3035181-1-git-send-email-arnd@arndb.de>
Message-ID: <1463587653-3035181-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent addition to the DRM tree for 4.7 added 'extern "C"' guards
for c++ to all the DRM headers, and that now causes warnings
in 'make headers_check':

usr/include/drm/amdgpu_drm.h:38: userspace cannot reference function or variable defined in the kernel
usr/include/drm/drm.h:63: userspace cannot reference function or variable defined in the kernel
usr/include/drm/drm.h:699: userspace cannot reference function or variable defined in the kernel
usr/include/drm/drm_fourcc.h:30: userspace cannot reference function or variable defined in the kernel
usr/include/drm/drm_mode.h:33: userspace cannot reference function or variable defined in the kernel
usr/include/drm/drm_sarea.h:38: userspace cannot reference function or variable defined in the kernel
usr/include/drm/exynos_drm.h:21: userspace cannot reference function or variable defined in the kernel
usr/include/drm/i810_drm.h:7: userspace cannot reference function or variable defined in the kernel

This changes the headers_check.pl script to not warn about this.
I'm listing the merge commit as introducing the problem, because
there are several patches in this branch that each do this for
one file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 7c10ddf87472 ("Merge branch 'drm-uapi-extern-c-fixes' of https://github.com/evelikov/linux into drm-next")
---
 scripts/headers_check.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/headers_check.pl b/scripts/headers_check.pl
index 62320f93e903..8b2da054cdc3 100755
--- a/scripts/headers_check.pl
+++ b/scripts/headers_check.pl
@@ -69,6 +69,10 @@ sub check_declarations
 	if ($line =~ m/^void seqbuf_dump\(void\);/) {
 		return;
 	}
+	# drm headers are being C++ friendly
+	if ($line =~ m/^extern "C"/) {
+		return;
+	}
 	if ($line =~ m/^(\s*extern|unsigned|char|short|int|long|void)\b/) {
 		printf STDERR "$filename:$lineno: " .
 			      "userspace cannot reference function or " .
-- 
2.7.0

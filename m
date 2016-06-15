From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 17:45:50 +0200
Subject: [PATCH v2 08/11] drm: amd: remove broken include path
In-Reply-To: <20160615154553.3177021-1-arnd@arndb.de>
References: <20160615154553.3177021-1-arnd@arndb.de>
Message-ID: <20160615154553.3177021-9-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AMD ACP driver adds "-I../acp -I../acp/include" to the gcc command
line, which makes no sense, since these are evaluated relative to the
build directory. When we build with "make W=1", they instead cause
a warning:

cc1: error: ../acp/: No such file or directory [-Werror=missing-include-dirs]
cc1: error: ../acp/include: No such file or directory [-Werror=missing-include-dirs]
cc1: all warnings being treated as errors
../scripts/Makefile.build:289: recipe for target 'drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o' failed
../scripts/Makefile.build:289: recipe for target 'drivers/gpu/drm/amd/amdgpu/amdgpu_device.o' failed
../scripts/Makefile.build:289: recipe for target 'drivers/gpu/drm/amd/amdgpu/amdgpu_kms.o' failed

This removes the subdir-ccflags variable that evidently did not
serve any purpose here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/acp/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/acp/Makefile b/drivers/gpu/drm/amd/acp/Makefile
index 8363cb57915b..8a08e81ee90d 100644
--- a/drivers/gpu/drm/amd/acp/Makefile
+++ b/drivers/gpu/drm/amd/acp/Makefile
@@ -3,6 +3,4 @@
 # of AMDSOC/AMDGPU drm driver.
 # It provides the HW control for ACP related functionalities.
 
-subdir-ccflags-y += -I$(AMDACPPATH)/ -I$(AMDACPPATH)/include
-
 AMD_ACP_FILES := $(AMDACPPATH)/acp_hw.o
-- 
2.9.0

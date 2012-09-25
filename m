From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Sep 2012 13:06:36 -0600
Subject: [RFC PATCH 1/3] kbuild: introduce cmd_dtc_cpp
In-Reply-To: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
References: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1348599998-2729-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

cmd_dtc_cpp runs the C pre-processor on the input .dts file before
passing it to dtc for final compilation. This allows used of #define
within the .dts file.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 scripts/Makefile.lib |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0be6f11..e3a149e 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -266,6 +266,9 @@ $(obj)/%.dtb.S: $(obj)/%.dtb
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = $(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0 $(DTC_FLAGS) -d $(depfile) $<
 
+quiet_cmd_dtc_cpp = DTC+CPP $@
+cmd_dtc_cpp = $(CC) -E -Wp,-MD,$(depfile) -xc $< | $(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0 $(DTC_FLAGS) -
+
 # Bzip2
 # ---------------------------------------------------------------------------
 
-- 
1.7.0.4

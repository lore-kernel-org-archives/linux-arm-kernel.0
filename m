From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 24 Nov 2011 12:47:59 +0000
Subject: [PATCH] ARM: Handle empty maps in iotable_init()
Message-ID: <1322138879-14280-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some CPUs (such as the S3C6410) have been relying on being able to call
iotable_init() with no io_descs in order to simplify passing through
machine-specific io_descs. The changes in "ARM: move iotable mappings
within the vmalloc region" broke this by adding an early_alloc_aligned()
for an array of vm_structs. Fix this by returning early if no descriptors
have been passed.

I'm not sure if this is the most tasteful fix but it preserves existing
behaviour and allows boot to proceed on my system.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mm/mmu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index c05315b..d842a57 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -763,6 +763,9 @@ void __init iotable_init(struct map_desc *io_desc, int nr)
 	struct map_desc *md;
 	struct vm_struct *vm;
 
+	if (!nr)
+		return;
+
 	vm = early_alloc_aligned(sizeof(*vm) * nr, __alignof__(*vm));
 
 	for (md = io_desc; nr; md++, nr--) {
-- 
1.7.7.3

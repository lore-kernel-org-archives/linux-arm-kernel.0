From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  2 Jul 2014 18:21:10 +0200
Subject: [PATCH 3/3] ARM: mvebu: add missing of_node_put() call in coherency.c
In-Reply-To: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1404318070-8503-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a missing of_node_put() to decrement the device_node
reference counter after a of_find_matching_node() in coherency_init().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
While this patch technically fixes a leak on a reference count, it
doesn't cause any visible issue, so I don't think it's worth have it
in the stable process. However it should be in 3.16-rc.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 2260a40..a9655e7 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -405,6 +405,8 @@ int __init coherency_init(void)
 		 type == COHERENCY_FABRIC_TYPE_ARMADA_380)
 		armada_375_380_coherency_init(np);
 
+	of_node_put(np);
+
 	return 0;
 }
 
-- 
2.0.0

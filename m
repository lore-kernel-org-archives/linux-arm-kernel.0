From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  9 Dec 2013 15:06:47 -0700
Subject: [PATCH 1/3] mfd: always assign of_node in mfd_add_device()
Message-ID: <1386626809-6251-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

mfd_add_device() assigns .of_node in the device objects it creates only
if the mfd_cell for the device has the .of_compatible field set and the
DT node for the top-level MFD device contains a child whose compatible
property matches the cell's .of_compatible field.

This leaves .of_node unset in many cases. When this happens, entries in
the DT /aliases property which refer to the top-level MFD DT node will
never match the MFD child devices, hence causing the requested alias not
to be honored.

Solve this by setting each MFD child device's .of_node equal to the top-
level MFD device's .of_node field in the cases where it would otherwise
remain unset.

The first use-case for this will be aliases for the TPS6586x's RTC
device.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
The 3 patches in this series are all independent; they can be applied
to their respective subsystems in any order. I'm simply posting them as
a series to make the use-case more obvious.
---
 drivers/mfd/mfd-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 267649244737..32e8d47d9002 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -117,6 +117,8 @@ static int mfd_add_device(struct device *parent, int id,
 			}
 		}
 	}
+	if (!pdev->dev.of_node)
+		pdev->dev.of_node = parent->of_node;
 
 	if (cell->pdata_size) {
 		ret = platform_device_add_data(pdev,
-- 
1.8.1.5

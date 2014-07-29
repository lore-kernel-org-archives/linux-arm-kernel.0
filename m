From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 29 Jul 2014 18:28:55 +0200
Subject: [RFC 1/5] regulator: core: Get voltage from parent if not available
In-Reply-To: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1406651339-28901-2-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Load switches are modeled as regulators but they just provide
the voltage of their parent input supply. So the drivers for
these switches usually don't provide a .get_voltage function
handler but there is code in the kernel that assumes that all
regulators should be able to provide its current voltage rail.

So, if the output voltage for a regulator is not available and
it has a parent supply, then pass the voltage of its parent.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 69c9c08..089cea8 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2695,6 +2695,8 @@ static int _regulator_get_voltage(struct regulator_dev *rdev)
 		ret = rdev->desc->ops->list_voltage(rdev, 0);
 	} else if (rdev->desc->fixed_uV && (rdev->desc->n_voltages == 1)) {
 		ret = rdev->desc->fixed_uV;
+	} else if (rdev->supply) {
+		ret = regulator_get_voltage(rdev->supply);
 	} else {
 		return -EINVAL;
 	}
-- 
2.0.0.rc2

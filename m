From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Feb 2014 10:34:24 +0900
Subject: [PATCH v3 0/2] regulator: core: Fix ops->enable/disable usage
In-Reply-To: <20140224205058.GA18317@pengutronix.de>
References: <1392914164-28596-1-git-send-email-mpa@pengutronix.de>
 <20140223051209.GK25940@sirena.org.uk>
 <CAOMZO5BPvCcx_f09Khuw8MVxrR18fnv9e1xeuJ0c_8G22AR53g@mail.gmail.com>
 <20140224205058.GA18317@pengutronix.de>
Message-ID: <20140225013424.GL25940@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 09:50:58PM +0100, Markus Pargmann wrote:

> The only situation where this returns -EINVAL is a dummy regulator that
> is not always_on. As it doesn't make sense to have a dummy regulator
> that is not always_on, I will add a check for exactly this situation to
> the regulator_register function and drop the "return -EINVAL" above.

I've squashed the following fix in today:

>From 937635aa9c667b90b76505de91c5693da6a5c120 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@linaro.org>
Date: Tue, 25 Feb 2014 10:24:55 +0900
Subject: [PATCH] regulator: Handle invalid enable operation for always/boot on
 regulators

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8cbc7d7..9a09f3c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1017,7 +1017,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 	 */
 	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
 		ret = _regulator_do_enable(rdev);
-		if (ret < 0) {
+		if (ret < 0 && ret != -EINVAL) {
 			rdev_err(rdev, "failed to enable\n");
 			goto out;
 		}
-- 
1.9.0.rc3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140225/08164a1a/attachment.sig>

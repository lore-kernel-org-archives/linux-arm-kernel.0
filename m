From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 17 Oct 2016 16:51:17 -0300
Subject: [PATCH v2] hwrng: meson: Fix module autoload for OF registration
Message-ID: <1476733877-20275-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/char/hw_random/meson-rng.ko | grep alias
alias:          platform:meson-rng

After this patch:

$ modinfo drivers/char/hw_random/meson-rng.ko | grep alias
alias:          platform:meson-rng
alias:          of:N*T*Camlogic,meson-rngC*
alias:          of:N*T*Camlogic,meson-rng

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes in v2:
- Remove unrelated changes added by mistake. Suggested by Jason Gunthorpe.

 drivers/char/hw_random/meson-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/meson-rng.c b/drivers/char/hw_random/meson-rng.c
index 58bef39f7286..51864a509be7 100644
--- a/drivers/char/hw_random/meson-rng.c
+++ b/drivers/char/hw_random/meson-rng.c
@@ -110,6 +110,7 @@ static const struct of_device_id meson_rng_of_match[] = {
 	{ .compatible = "amlogic,meson-rng", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, meson_rng_of_match);
 
 static struct platform_driver meson_rng_driver = {
 	.probe	= meson_rng_probe,
-- 
2.7.4

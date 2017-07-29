From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 29 Jul 2017 07:59:38 +0200
Subject: [PATCH 09/12] mmc: sunxi: constify mmc_host_ops structures
In-Reply-To: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1501307981-29745-10-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmc_host_ops structure is only stored in the ops field of an
mmc_host structure, which is declared as const.  Thus the mmc_host_ops
structure itself can be const.

Done with the help of Coccinelle.

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct mmc_host_ops i at p = { ... };

@ok1@
struct mmc_host *mmc;
identifier r.i;
position p;
@@
mmc->ops = &i at p

@bad@
position p != {r.p,ok1.p};
identifier r.i;
struct mmc_host_ops e;
@@
e at i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct mmc_host_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mmc/host/sunxi-mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 6adc524..fa0601c 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1048,7 +1048,7 @@ static int sunxi_mmc_card_busy(struct mmc_host *mmc)
 	return !!(mmc_readl(host, REG_STAS) & SDXC_CARD_DATA_BUSY);
 }
 
-static struct mmc_host_ops sunxi_mmc_ops = {
+static const struct mmc_host_ops sunxi_mmc_ops = {
 	.request	 = sunxi_mmc_request,
 	.set_ios	 = sunxi_mmc_set_ios,
 	.get_ro		 = mmc_gpio_get_ro,

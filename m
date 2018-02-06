From: artem.savkov@gmail.com (Artem Savkov)
Date: Tue,  6 Feb 2018 22:20:22 +0100
Subject: [PATCH 2/2] sun4i_ss_prng: convert lock to _bh in
 sun4i_ss_prng_generate
In-Reply-To: <20180206212022.1309-1-artem.savkov@gmail.com>
References: <20180206212022.1309-1-artem.savkov@gmail.com>
Message-ID: <20180206212022.1309-3-artem.savkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lockdep detects a possible deadlock in sun4i_ss_prng_generate() and
throws an "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage" warning.
Disabling softirqs to fix this.

Fixes: b8ae5c7387ad ("crypto: sun4i-ss - support the Security System PRNG")
Signed-off-by: Artem Savkov <artem.savkov@gmail.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-prng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
index 5754e0b92fb0..63d636424161 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
@@ -28,7 +28,7 @@ int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	algt = container_of(alg, struct sun4i_ss_alg_template, alg.rng);
 	ss = algt->ss;
 
-	spin_lock(&ss->slock);
+	spin_lock_bh(&ss->slock);
 
 	writel(mode, ss->base + SS_CTL);
 
@@ -51,6 +51,6 @@ int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	}
 
 	writel(0, ss->base + SS_CTL);
-	spin_unlock(&ss->slock);
+	spin_unlock_bh(&ss->slock);
 	return 0;
 }
-- 
2.15.1

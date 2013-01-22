From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Tue, 22 Jan 2013 13:08:52 +0530
Subject: [PATCH v5 21/45] crypto: pcrypt - Protect access to cpu_online_mask
 with get/put_online_cpus()
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130122073848.13822.35451.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pcrypt_aead_init_tfm() function access the cpu_online_mask without
disabling CPU hotplug. And it looks like it can afford to sleep, so use
the get/put_online_cpus() APIs to protect against CPU hotplug.

Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto at vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 crypto/pcrypt.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index b2c99dc..10f64e2 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -280,12 +280,16 @@ static int pcrypt_aead_init_tfm(struct crypto_tfm *tfm)
 
 	ictx->tfm_count++;
 
+	get_online_cpus();
+
 	cpu_index = ictx->tfm_count % cpumask_weight(cpu_online_mask);
 
 	ctx->cb_cpu = cpumask_first(cpu_online_mask);
 	for (cpu = 0; cpu < cpu_index; cpu++)
 		ctx->cb_cpu = cpumask_next(ctx->cb_cpu, cpu_online_mask);
 
+	put_online_cpus();
+
 	cipher = crypto_spawn_aead(crypto_instance_ctx(inst));
 
 	if (IS_ERR(cipher))

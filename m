From: joelf@ti.com (Joel Fernandes)
Date: Wed, 14 Aug 2013 18:12:40 -0500
Subject: [PATCH 01/10] crypto: scatterwalk: Add support for calculating number
 of SG elements
In-Reply-To: <1376521969-16807-1-git-send-email-joelf@ti.com>
References: <1376521969-16807-1-git-send-email-joelf@ti.com>
Message-ID: <1376521969-16807-2-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Crypto layer only passes nbytes to encrypt but in omap-aes driver we
need to know number of SG elements to pass to dmaengine slave API.
We add function for the same to scatterwalk library.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 crypto/scatterwalk.c         |   22 ++++++++++++++++++++++
 include/crypto/scatterwalk.h |    2 ++
 2 files changed, 24 insertions(+)

diff --git a/crypto/scatterwalk.c b/crypto/scatterwalk.c
index 7281b8a..79ca227 100644
--- a/crypto/scatterwalk.c
+++ b/crypto/scatterwalk.c
@@ -124,3 +124,25 @@ void scatterwalk_map_and_copy(void *buf, struct scatterlist *sg,
 	scatterwalk_done(&walk, out, 0);
 }
 EXPORT_SYMBOL_GPL(scatterwalk_map_and_copy);
+
+int scatterwalk_bytes_sglen(struct scatterlist *sg, int num_bytes)
+{
+	int offset = 0, n = 0;
+
+	/* num_bytes is too small */
+	if (num_bytes < sg->length)
+		return -1;
+
+	do {
+		offset += sg->length;
+		n++;
+		sg = scatterwalk_sg_next(sg);
+
+		/* num_bytes is too large */
+		if (unlikely(!sg && (num_bytes < offset)))
+			return -1;
+	} while (sg && (num_bytes > offset));
+
+	return n;
+}
+EXPORT_SYMBOL_GPL(scatterwalk_bytes_sglen);
diff --git a/include/crypto/scatterwalk.h b/include/crypto/scatterwalk.h
index 3744d2a..13621cc 100644
--- a/include/crypto/scatterwalk.h
+++ b/include/crypto/scatterwalk.h
@@ -113,4 +113,6 @@ void scatterwalk_done(struct scatter_walk *walk, int out, int more);
 void scatterwalk_map_and_copy(void *buf, struct scatterlist *sg,
 			      unsigned int start, unsigned int nbytes, int out);
 
+int scatterwalk_bytes_sglen(struct scatterlist *sg, int num_bytes);
+
 #endif  /* _CRYPTO_SCATTERWALK_H */
-- 
1.7.9.5

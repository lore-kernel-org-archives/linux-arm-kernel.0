From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  7 Oct 2013 14:12:31 +0200
Subject: [RFC PATCH 5/5] mac80211: Use CCM crypto driver for CCMP
In-Reply-To: <1381147951-7609-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381147951-7609-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381147951-7609-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the crypto layer supply the CCM implementation rather than
coding it directly on top of the core AES cipher.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 net/mac80211/Kconfig   |   1 +
 net/mac80211/aes_ccm.c | 159 +++++++++++++++----------------------------------
 net/mac80211/aes_ccm.h |   8 +--
 net/mac80211/key.h     |   2 +-
 net/mac80211/wpa.c     |  21 ++++---
 5 files changed, 64 insertions(+), 127 deletions(-)

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index 62535fe..dc31ec3 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -4,6 +4,7 @@ config MAC80211
 	select CRYPTO
 	select CRYPTO_ARC4
 	select CRYPTO_AES
+	select CRYPTO_CCM
 	select CRC32
 	select AVERAGE
 	---help---
diff --git a/net/mac80211/aes_ccm.c b/net/mac80211/aes_ccm.c
index be7614b9..c17f3a3 100644
--- a/net/mac80211/aes_ccm.c
+++ b/net/mac80211/aes_ccm.c
@@ -17,134 +17,71 @@
 #include "key.h"
 #include "aes_ccm.h"
 
-static void aes_ccm_prepare(struct crypto_cipher *tfm, u8 *scratch, u8 *a)
-{
-	int i;
-	u8 *b_0, *aad, *b, *s_0;
-
-	b_0 = scratch + 3 * AES_BLOCK_SIZE;
-	aad = scratch + 4 * AES_BLOCK_SIZE;
-	b = scratch;
-	s_0 = scratch + AES_BLOCK_SIZE;
-
-	crypto_cipher_encrypt_one(tfm, b, b_0);
-
-	/* Extra Authenticate-only data (always two AES blocks) */
-	for (i = 0; i < AES_BLOCK_SIZE; i++)
-		aad[i] ^= b[i];
-	crypto_cipher_encrypt_one(tfm, b, aad);
-
-	aad += AES_BLOCK_SIZE;
-
-	for (i = 0; i < AES_BLOCK_SIZE; i++)
-		aad[i] ^= b[i];
-	crypto_cipher_encrypt_one(tfm, a, aad);
-
-	/* Mask out bits from auth-only-b_0 */
-	b_0[0] &= 0x07;
-
-	/* S_0 is used to encrypt T (= MIC) */
-	b_0[14] = 0;
-	b_0[15] = 0;
-	crypto_cipher_encrypt_one(tfm, s_0, b_0);
-}
-
-
-void ieee80211_aes_ccm_encrypt(struct crypto_cipher *tfm, u8 *scratch,
+void ieee80211_aes_ccm_encrypt(struct crypto_aead *tfm, u8 *scratch,
 			       u8 *data, size_t data_len,
 			       u8 *cdata, u8 *mic)
 {
-	int i, j, last_len, num_blocks;
-	u8 *pos, *cpos, *b, *s_0, *e, *b_0;
+	struct scatterlist aad, pt, ct;
+	struct aead_request req;
+	u8 *iv = scratch + 3 * AES_BLOCK_SIZE; /* b0 */
 
-	b = scratch;
-	s_0 = scratch + AES_BLOCK_SIZE;
-	e = scratch + 2 * AES_BLOCK_SIZE;
-	b_0 = scratch + 3 * AES_BLOCK_SIZE;
+	sg_init_one(&pt, data, data_len);
+	sg_init_one(&ct, cdata, data_len + IEEE80211_CCMP_MIC_LEN);
+	sg_init_one(&aad, scratch + 4 * AES_BLOCK_SIZE, 2 * AES_BLOCK_SIZE - 2);
 
-	num_blocks = DIV_ROUND_UP(data_len, AES_BLOCK_SIZE);
-	last_len = data_len % AES_BLOCK_SIZE;
-	aes_ccm_prepare(tfm, scratch, b);
+	aead_request_set_crypt(&req, &pt, &ct, data_len, iv);
+	aead_request_set_assoc(&req, &aad, 2 * AES_BLOCK_SIZE - 2);
 
-	/* Process payload blocks */
-	pos = data;
-	cpos = cdata;
-	for (j = 1; j <= num_blocks; j++) {
-		int blen = (j == num_blocks && last_len) ?
-			last_len : AES_BLOCK_SIZE;
-
-		/* Authentication followed by encryption */
-		for (i = 0; i < blen; i++)
-			b[i] ^= pos[i];
-		crypto_cipher_encrypt_one(tfm, b, b);
-
-		b_0[14] = (j >> 8) & 0xff;
-		b_0[15] = j & 0xff;
-		crypto_cipher_encrypt_one(tfm, e, b_0);
-		for (i = 0; i < blen; i++)
-			*cpos++ = *pos++ ^ e[i];
-	}
-
-	for (i = 0; i < IEEE80211_CCMP_MIC_LEN; i++)
-		mic[i] = b[i] ^ s_0[i];
+	crypto_aead_encrypt(&req);
 }
 
-
-int ieee80211_aes_ccm_decrypt(struct crypto_cipher *tfm, u8 *scratch,
+int ieee80211_aes_ccm_decrypt(struct crypto_aead *tfm, u8 *scratch,
 			      u8 *cdata, size_t data_len, u8 *mic, u8 *data)
 {
-	int i, j, last_len, num_blocks;
-	u8 *pos, *cpos, *b, *s_0, *a, *b_0;
-
-	b = scratch;
-	s_0 = scratch + AES_BLOCK_SIZE;
-	a = scratch + 2 * AES_BLOCK_SIZE;
-	b_0 = scratch + 3 * AES_BLOCK_SIZE;
-
-	num_blocks = DIV_ROUND_UP(data_len, AES_BLOCK_SIZE);
-	last_len = data_len % AES_BLOCK_SIZE;
-	aes_ccm_prepare(tfm, scratch, a);
+	struct scatterlist aad, pt, ct;
+	struct aead_request req;
+	u8 *iv = scratch + 3 * AES_BLOCK_SIZE; /* b0 */
 
-	/* Process payload blocks */
-	cpos = cdata;
-	pos = data;
-	for (j = 1; j <= num_blocks; j++) {
-		int blen = (j == num_blocks && last_len) ?
-			last_len : AES_BLOCK_SIZE;
+	sg_init_one(&pt, data, data_len);
+	sg_init_one(&ct, cdata, data_len + IEEE80211_CCMP_MIC_LEN);
+	sg_init_one(&aad, scratch + 4 * AES_BLOCK_SIZE, 2 * AES_BLOCK_SIZE - 2);
 
-		/* Decryption followed by authentication */
-		b_0[14] = (j >> 8) & 0xff;
-		b_0[15] = j & 0xff;
-		crypto_cipher_encrypt_one(tfm, b, b_0);
-		for (i = 0; i < blen; i++) {
-			*pos = *cpos++ ^ b[i];
-			a[i] ^= *pos++;
-		}
-		crypto_cipher_encrypt_one(tfm, a, a);
-	}
+	aead_request_set_crypt(&req, &ct, &pt, data_len, iv);
+	aead_request_set_assoc(&req, &aad, 2 * AES_BLOCK_SIZE - 2);
 
-	for (i = 0; i < IEEE80211_CCMP_MIC_LEN; i++) {
-		if ((mic[i] ^ s_0[i]) != a[i])
-			return -1;
-	}
-
-	return 0;
+	return crypto_aead_decrypt(&req);
 }
 
-
-struct crypto_cipher *ieee80211_aes_key_setup_encrypt(const u8 key[])
+struct crypto_aead *ieee80211_aes_key_setup_encrypt(const u8 key[])
 {
-	struct crypto_cipher *tfm;
-
-	tfm = crypto_alloc_cipher("aes", 0, CRYPTO_ALG_ASYNC);
-	if (!IS_ERR(tfm))
-		crypto_cipher_setkey(tfm, key, WLAN_KEY_LEN_CCMP);
-
-	return tfm;
+	struct crypto_aead *tfm;
+	int err;
+
+	tfm = crypto_alloc_aead("ccm(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm))
+		return tfm;
+
+	/* HACK: we use an auto variable for aead_request in the functions above
+	 * but this only works if the reqsize is 0, i.e., the aead alg does not
+	 * need additional space in the req struct to track its operations.
+	 * This is a proof of concept for the Crypto Extensions based AES/CCM,
+	 * so for now we just hack around it.
+	 */
+	err = -EINVAL;
+	if (crypto_aead_reqsize(tfm))
+		goto out;
+
+	err = crypto_aead_setkey(tfm, key, WLAN_KEY_LEN_CCMP);
+	if (!err)
+		err = crypto_aead_setauthsize(tfm, IEEE80211_CCMP_MIC_LEN);
+	if (!err)
+		return tfm;
+out:
+	crypto_free_aead(tfm);
+	return ERR_PTR(err);
 }
 
-
-void ieee80211_aes_key_free(struct crypto_cipher *tfm)
+void ieee80211_aes_key_free(struct crypto_aead *tfm)
 {
-	crypto_free_cipher(tfm);
+	crypto_free_aead(tfm);
 }
diff --git a/net/mac80211/aes_ccm.h b/net/mac80211/aes_ccm.h
index 5b7d744..797f3f0 100644
--- a/net/mac80211/aes_ccm.h
+++ b/net/mac80211/aes_ccm.h
@@ -12,13 +12,13 @@
 
 #include <linux/crypto.h>
 
-struct crypto_cipher *ieee80211_aes_key_setup_encrypt(const u8 key[]);
-void ieee80211_aes_ccm_encrypt(struct crypto_cipher *tfm, u8 *scratch,
+struct crypto_aead *ieee80211_aes_key_setup_encrypt(const u8 key[]);
+void ieee80211_aes_ccm_encrypt(struct crypto_aead *tfm, u8 *scratch,
 			       u8 *data, size_t data_len,
 			       u8 *cdata, u8 *mic);
-int ieee80211_aes_ccm_decrypt(struct crypto_cipher *tfm, u8 *scratch,
+int ieee80211_aes_ccm_decrypt(struct crypto_aead *tfm, u8 *scratch,
 			      u8 *cdata, size_t data_len,
 			      u8 *mic, u8 *data);
-void ieee80211_aes_key_free(struct crypto_cipher *tfm);
+void ieee80211_aes_key_free(struct crypto_aead *tfm);
 
 #endif /* AES_CCM_H */
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index 036d57e..aaae0ed 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -83,7 +83,7 @@ struct ieee80211_key {
 			 * Management frames.
 			 */
 			u8 rx_pn[IEEE80211_NUM_TIDS + 1][IEEE80211_CCMP_PN_LEN];
-			struct crypto_cipher *tfm;
+			struct crypto_aead *tfm;
 			u32 replays; /* dot11RSNAStatsCCMPReplays */
 		} ccmp;
 		struct {
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index c9edfcb..c3df1d7 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -343,7 +343,7 @@ static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *scratch,
 		data_len -= IEEE80211_CCMP_MIC_LEN;
 
 	/* First block, b_0 */
-	b_0[0] = 0x59; /* flags: Adata: 1, M: 011, L: 001 */
+	b_0[0] = 0x1; /* L == 1 */
 	/* Nonce: Nonce Flags | A2 | PN
 	 * Nonce Flags: Priority (b0..b3) | Management (b4) | Reserved (b5..b7)
 	 */
@@ -355,21 +355,20 @@ static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *scratch,
 
 	/* AAD (extra authenticate-only data) / masked 802.11 header
 	 * FC | A1 | A2 | A3 | SC | [A4] | [QC] */
-	put_unaligned_be16(len_a, &aad[0]);
-	put_unaligned(mask_fc, (__le16 *)&aad[2]);
-	memcpy(&aad[4], &hdr->addr1, 3 * ETH_ALEN);
+	put_unaligned(mask_fc, (__le16 *)&aad[0]);
+	memcpy(&aad[2], &hdr->addr1, 3 * ETH_ALEN);
 
 	/* Mask Seq#, leave Frag# */
-	aad[22] = *((u8 *) &hdr->seq_ctrl) & 0x0f;
-	aad[23] = 0;
+	aad[20] = *((u8 *) &hdr->seq_ctrl) & 0x0f;
+	aad[21] = 0;
 
 	if (a4_included) {
-		memcpy(&aad[24], hdr->addr4, ETH_ALEN);
-		aad[30] = qos_tid;
-		aad[31] = 0;
+		memcpy(&aad[22], hdr->addr4, ETH_ALEN);
+		aad[28] = qos_tid;
+		aad[29] = 0;
 	} else {
-		memset(&aad[24], 0, ETH_ALEN + IEEE80211_QOS_CTL_LEN);
-		aad[24] = qos_tid;
+		memset(&aad[22], 0, ETH_ALEN + IEEE80211_QOS_CTL_LEN);
+		aad[22] = qos_tid;
 	}
 }
 
-- 
1.8.1.2

From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 24 Jul 2016 11:30:17 -0400
Subject: [PATCH v5 03/15] binfmt_flat: prevent kernel dammage from corrupted
 executable headers
In-Reply-To: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1469374229-21585-4-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 fs/binfmt_flat.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index c3ccdefdea..03301bad1f 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -466,6 +466,17 @@ static int load_flat_file(struct linux_binprm *bprm,
 	}
 
 	/*
+	 * Make sure the header params are sane.
+	 * 28 bits (256 MB) is way more than reasonable in this case.
+	 * If some top bits are set we have probable binary corruption.
+	*/
+	if ((text_len | data_len | bss_len | stack_len | full_data) >> 28) {
+		pr_err("bad header\n");
+		ret = -ENOEXEC;
+		goto err;
+	}
+
+	/*
 	 * fix up the flags for the older format,  there were all kinds
 	 * of endian hacks,  this only works for the simple cases
 	 */
-- 
2.7.4

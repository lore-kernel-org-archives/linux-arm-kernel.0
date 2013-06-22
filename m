From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 22 Jun 2013 22:42:38 +0200
Subject: [RFC PATCH v2 06/12] dmaengine: PL08x: Fix reading the byte count in
 cctl
In-Reply-To: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1371933764-24875-7-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alban Bedel <alban.bedel@avionic-design.de>

There are more fields than just SWIDTH in CH_CONTROL register, so read
register value must be masked in addition to shifting.

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/dma/amba-pl08x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 89b8120..1eeb911 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -469,6 +469,8 @@ static inline u32 get_bytes_in_cctl(u32 cctl)
 	/* The source width defines the number of bytes */
 	u32 bytes = cctl & PL080_CONTROL_TRANSFER_SIZE_MASK;
 
+	cctl &= PL080_CONTROL_SWIDTH_MASK;
+
 	switch (cctl >> PL080_CONTROL_SWIDTH_SHIFT) {
 	case PL080_WIDTH_8BIT:
 		break;
@@ -487,6 +489,8 @@ static inline u32 get_bytes_in_cctl_pl080s(u32 cctl, u32 cctl1)
 	/* The source width defines the number of bytes */
 	u32 bytes = cctl1 & PL080S_CONTROL_TRANSFER_SIZE_MASK;
 
+	cctl &= PL080_CONTROL_SWIDTH_MASK;
+
 	switch (cctl >> PL080_CONTROL_SWIDTH_SHIFT) {
 	case PL080_WIDTH_8BIT:
 		break;
-- 
1.8.2.1

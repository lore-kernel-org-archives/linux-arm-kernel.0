From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Jan 2015 17:11:27 +0100
Subject: [PATCHv2 1/3] ARM: mvebu: completely disable hardware I/O coherency
In-Reply-To: <1421424689-5971-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1421424689-5971-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1421424689-5971-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current hardware I/O coherency is known to cause problems with DMA
coherent buffers, as it still requires explicit I/O synchronization
barriers, which is not compatible with the semantics expected by the
Linux DMA coherent buffers API.

So, in order to have enough time to validate a new solution based on
automatic I/O synchronization barriers, this commit disables hardware
I/O coherency entirely. Future patches will re-enable it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.8+
---
Due to the coherent mapping problem, the I/O coherency has in fact
been broken since its introduction, which is why we request the
backport of this patch all the way up to 3.8.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 3585cb3..caa21e9 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -246,9 +246,14 @@ static int coherency_type(void)
 	return type;
 }
 
+/*
+ * As a precaution, we currently completely disable hardware I/O
+ * coherency, until enough testing is done with automatic I/O
+ * synchronization barriers to validate that it is a proper solution.
+ */
 int coherency_available(void)
 {
-	return coherency_type() != COHERENCY_FABRIC_TYPE_NONE;
+	return false;
 }
 
 int __init coherency_init(void)
-- 
2.1.0

From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 26 Sep 2018 14:56:18 +0100
Subject: [PATCH 1/7] arm64: Add static check for pt_regs alignment
In-Reply-To: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1537970184-44348-2-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pt_regs structure's size is required to be a multiple of 16 to maintain
the stack alignment upon kernel entries.

Add a static check to ensure this is the case.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm64/include/asm/ptrace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 177b851..cc17fad 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -229,6 +229,8 @@ static inline u64 regs_get_register(struct pt_regs *regs, unsigned int offset)
 
 	WARN_ON(offset & 7);
 
+	BUILD_BUG_ON((sizeof (struct pt_regs) % 16 != 0));
+
 	offset >>= 3;
 	switch (offset) {
 	case 0 ... 30:
-- 
1.9.1

From: pmladek@suse.com (Petr Mladek)
Date: Fri, 27 Nov 2015 12:09:32 +0100
Subject: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary buffer
In-Reply-To: <1448622572-16900-1-git-send-email-pmladek@suse.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
Message-ID: <1448622572-16900-6-git-send-email-pmladek@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Testing has shown that the backtrace sometimes does not fit
into the 4kB temporary buffer that is used in NMI context.

The warnings are gone when I double the temporary buffer size.

Note that this problem existed even in the x86-specific
implementation that was added by the commit a9edc8809328
("x86/nmi: Perform a safe NMI stack trace on all CPUs").
Nobody noticed it because it did not print any warnings.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index 8af1e4016719..6111644d5f01 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -42,7 +42,7 @@ atomic_t nmi_message_lost;
 struct nmi_seq_buf {
 	atomic_t		len;	/* length of written data */
 	struct irq_work		work;	/* IRQ work that flushes the buffer */
-	unsigned char		buffer[PAGE_SIZE - sizeof(atomic_t) -
+	unsigned char		buffer[2 * PAGE_SIZE - sizeof(atomic_t) -
 				       sizeof(struct irq_work)];
 };
 static DEFINE_PER_CPU(struct nmi_seq_buf, nmi_print_seq);
-- 
1.8.5.6

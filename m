From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  7 Mar 2013 22:58:07 +0100
Subject: [PATCH 01/11] kfifo: introduce kfifo_dump_str to dump the fifo
In-Reply-To: <20130307215402.GA32347@game.jcrosoft.org>
References: <20130307215402.GA32347@game.jcrosoft.org>
Message-ID: <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow to implement a dmesg mecanism in barebox

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 include/kfifo.h |    2 ++
 lib/kfifo.c     |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/kfifo.h b/include/kfifo.h
index 25880f4..9dbbe0d 100644
--- a/include/kfifo.h
+++ b/include/kfifo.h
@@ -74,5 +74,7 @@ static inline unsigned int kfifo_len(struct kfifo *fifo)
 void kfifo_putc(struct kfifo *fifo, unsigned char c);
 unsigned int kfifo_getc(struct kfifo *fifo, unsigned char *c);
 
+void kfifo_dump_str(struct kfifo *fifo, void (*dump)(unsigned char c));
+
 #endif
 
diff --git a/lib/kfifo.c b/lib/kfifo.c
index afd3894..7892aed 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -154,3 +154,24 @@ unsigned int kfifo_getc(struct kfifo *fifo, unsigned char *c)
 	return 0;
 }
 
+void kfifo_dump_str(struct kfifo *fifo, void (*dump)(unsigned char c))
+{
+	int i;
+	unsigned char *c;
+	unsigned int l;
+	unsigned int len;
+
+	len = fifo->in - fifo->out;
+
+	/* first get the data from fifo->out until the end of the buffer */
+	l = min(len, fifo->size - (fifo->out & (fifo->size - 1)));
+	c = fifo->buffer + (fifo->out & (fifo->size - 1));
+	for (i = 0; i < l; i++)
+		dump(c[i]);
+
+	/* then get the rest (if any) from the beginning of the buffer */
+	c = fifo->buffer;
+	l = len - l;
+	for (i = 0; i < l; i++)
+		dump(c[i]);
+}
-- 
1.7.10.4

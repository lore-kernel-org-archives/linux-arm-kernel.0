From: acourbot@nvidia.com (Alexandre Courbot)
Date: Mon, 22 Jul 2013 15:56:09 +0900
Subject: [PATCH] decompressors: fix "no limit" output buffer length
Message-ID: <1374476169-32194-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When decompressing into memory, the output buffer length is set to some
arbitrarily high value (0x7fffffff) to indicate the output is,
virtually, unlimited in size.

The problem with this is that some platforms have their physical memory
at high physical addresses (0x80000000 or more), and that the output
buffer address and its "unlimited" length cannot be added without
overflowing. An example of this can be found in inflate_fast():

/* next_out is the output buffer address */
out = strm->next_out - OFF;
/* avail_out is the output buffer size. end will overflow if the output
 * address is >= 0x80000104 */
end = out + (strm->avail_out - 257);

This has huge consequences on the performance of kernel decompression,
since the following exit condition of inflate_fast() will be always
true:

} while (in < last && out < end);

Indeed, "end" has overflowed and is now always lower than "out". As a
result, inflate_fast() will return after processing one single byte of
input data, and will thus need to be called an unreasonably high number
of times. This probably went unnoticed because kernel decompression is
fast enough even with this issue.

Nonetheless, adjusting the output buffer length in such a way that the
above pointer arithmetic never overflows results in a kernel
decompression that is about 3 times faster on affected machines.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 lib/decompress_inflate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/decompress_inflate.c b/lib/decompress_inflate.c
index 19ff89e..d619b28 100644
--- a/lib/decompress_inflate.c
+++ b/lib/decompress_inflate.c
@@ -48,7 +48,7 @@ STATIC int INIT gunzip(unsigned char *buf, int len,
 		out_len = 0x8000; /* 32 K */
 		out_buf = malloc(out_len);
 	} else {
-		out_len = 0x7fffffff; /* no limit */
+		out_len = ((size_t)~0) - (size_t)out_buf; /* no limit */
 	}
 	if (!out_buf) {
 		error("Out of memory while allocating output buffer");
-- 
1.8.3.2

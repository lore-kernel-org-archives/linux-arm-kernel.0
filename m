From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Apr 2011 00:21:56 -0700
Subject: [PATCH 0/3] fix some issues with the kernel decompressor
In-Reply-To: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110420072156.GA28679@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110419 21:12]:
> Here some patches to fix some issues with the zImage code.  The LZMA
> decompressor now works for me, and the DT append patch should work
> on all platforms now too.

Weird still no luck here booting n900 zImage.. LZMA image prints
corrupt error, and only works if the image is relocated further
by 1MB or so. With the following hack n900 boots, so some size
calculations still are wrong. No luck with DT append patch either.

Any ideas why the following helps on n900?

Tony

--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -307,6 +307,7 @@ dtb_check_done:
 		/* Round up to next 256-byte boundary. */
 		add	r10, r10, #256
 		bic	r10, r10, #255
+		orr	r10, r10, #0x00100000
 
 		sub	r9, r6, r5		@ size to copy
 		add	r9, r9, #31		@ rounded up to a multiple

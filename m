From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 27 Apr 2011 18:16:09 -0400 (EDT)
Subject: [PATCH] ARM: Fix relocation if image end past uncompressed kernel
	end
In-Reply-To: <20110427125631.GF3755@atomide.com>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<20110420072156.GA28679@atomide.com>
	<alpine.LFD.2.00.1104200850030.24613@xanadu.home>
	<20110420165514.GE10402@atomide.com>
	<alpine.LFD.2.00.1104201318040.24613@xanadu.home>
	<20110421055945.GB13688@atomide.com>
	<20110421104954.GH13688@atomide.com>
	<alpine.LFD.2.00.1104210919070.24613@xanadu.home>
	<20110427124726.GE3755@atomide.com>
	<20110427125631.GF3755@atomide.com>
Message-ID: <alpine.LFD.2.00.1104271810450.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Apr 2011, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [110427 05:44]:
> > We can't overwrite the running code when relocating only a small amount,
> > say 0x100 or so.
> > 
> > There's no need to relocate all the way past the compressed kernel,
> > we just need to relocate past the size of the code in head.o.
> > 
> > Updated patch below using the GOT end instead of the compressed
> > image end.
> 
> Oops, the mov should be movle of course. Updated patch below.

This is wrong.  You're using r12 before it is fixed up with the 
proper offset.

And this could simply be fixed with a big enough constant like this:

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 8dab5e3..71fc1d9 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -250,8 +250,11 @@ restart:	adr	r0, LC0
  * Because we always copy ahead, we need to do it from the end and go
  * backward in case the source and destination overlap.
  */
-		/* Round up to next 256-byte boundary. */
-		add	r10, r10, #256
+		/*
+		 * Round to a 256-byte boundary on the next page. This
+		 * avoids overwriting ourself if the offset is small.
+		 */
+		add	r10, r10, #4096
 		bic	r10, r10, #255
 
 		sub	r9, r6, r5		@ size to copy

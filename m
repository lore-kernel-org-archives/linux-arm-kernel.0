From: fgenfb@yahoo.com (Harm Hanemaaijer)
Date: Sun, 14 Jul 2013 11:00:50 +0000 (UTC)
Subject: Call for testing/opinions: Optimized memset/memcpy
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713172445.GL32054@1wt.eu> <loom.20130713T232124-511@post.gmane.org>
 <20130714061354.GS32054@1wt.eu>
Message-ID: <loom.20130714T124137-382@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Willy Tarreau <w <at> 1wt.eu> writes:

> 
> Please find the results attached. It seems that memcpy improved by 0.8%
> though that's not even certain.
> 

What is interesting is that
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388f/Caccifbd.html,
and several other sources (such as other
optimized memcpy implementations) document the cache line size of the Cortex
A9 as 32 bytes, which is an anomaly in the armv7 family. However, it looks
like the kernel is defining L1_CACHE_BYTES as 64 (L1_CACHE_SHIFT == 6) for
all armv7 platforms, which looks like a serious configuring error for Cortex
A9.

This explains why the large size memcpy results that you posted are not
optimal, and also explains the below-par copy_page performance in the current
kernel implementation, because copy_page uses L1_CACHE_BYTES to determine the
preload strategy, while the current memcpy doesn't (it is hardcoded for
L1_CACHE_BYTES of 32).

This merits further investigation, and there might potentially be other
kernel issues for Cortex A9 (including performance) related to this.

To confirm, does running 'zcat /proc/config.gz| grep L1_CACHE_SHIFT' on a
Cortex A9 show CONFIG_ARM_L1_CACHE_SHIFT defined as 6?

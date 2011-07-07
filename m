From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 7 Jul 2011 11:21:09 +0100
Subject: [PATCH v3 27/40] Subject: ARM: mm: proc-mohawk: Use the new
	processor struct macros
In-Reply-To: <20110707091114.GJ8286@n2100.arm.linux.org.uk>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
	<1308851448-25139-28-git-send-email-dave.martin@linaro.org>
	<20110707091114.GJ8286@n2100.arm.linux.org.uk>
Message-ID: <20110707102109.GE2486@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 10:11:14AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 23, 2011 at 06:50:35PM +0100, Dave Martin wrote:
> > NOTE: Even with this patch, this CPU is still broken due the lack
> > of a suitable flush_icache_all function.
> 
> I assume that it now gets a build error rather than silently failing
> at runtime?  If so, that's actually an improvement.

The answer should be yes.

In the branch referenced by Will's pull request, I've integrated a contribution
from Nico which supplies the missing flush function anyway ... so the combined
patch ought to fix that problem anyway:

+/*
+ *     flush_icache_all()
+ *
+ *     Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(mohawk_flush_icache_all)
+       mov     r0, #0
+       mcr     p15, 0, r0, c7, c5, 0           @ invalidate I cache
+       mov     pc, lr
+ENDPROC(mohawk_flush_icache_all)

Cheers
---Dave

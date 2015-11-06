From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Nov 2015 10:01:19 +0000
Subject: [PATCH] arm64: cmpxchg_dbl: fix return value type
In-Reply-To: <20151106094413.GA1499@red-moon>
References: <1446732056-31294-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20151105173114.GU7637@e104818-lin.cambridge.arm.com>
 <20151106094413.GA1499@red-moon>
Message-ID: <20151106100119.GW7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 09:44:13AM +0000, Lorenzo Pieralisi wrote:
> On Thu, Nov 05, 2015 at 05:31:14PM +0000, Catalin Marinas wrote:
> > On Thu, Nov 05, 2015 at 02:00:56PM +0000, Lorenzo Pieralisi wrote:
> > > The current arm64 __cmpxchg_double{_mb} implementations carry out the
> > > compare exchange by first comparing the old values passed in to the
> > > values read from the pointer provided and by stashing the cumulative
> > > bitwise difference in a 64-bit register.
> > > 
> > > By comparing the register content against 0, it is possible to detect if
> > > the values read differ from the old values passed in, so that the compare
> > > exchange detects whether it has to bail out or carry on completing the
> > > operation with the exchange.
> > > 
> > > Given the current implementation, to detect the cmpxchg operation
> > > status, the __cmpxchg_double{_mb} functions should return the 64-bit
> > > stashed bitwise difference so that the caller can detect cmpxchg failure
> > > by comparing the return value content against 0. The current implementation
> > > declares the return value as an int, which means that the 64-bit
> > > value stashing the bitwise difference is truncated before being
> > > returned to the __cmpxchg_double{_mb} callers, which means that
> > > any bitwise difference present in the top 32 bits goes undetected,
> > > triggering false positives and subsequent kernel failures.
> > > 
> > > This patch fixes the issue by declaring the arm64 __cmpxchg_double{_mb}
> > > return values as a long, so that the bitwise difference is
> > > properly propagated on failure, restoring the expected behaviour.
> > > 
> > > Fixes: e9a4b795652f ("arm64: cmpxchg_dbl: patch in lse instructions when
> > > supported by the CPU")
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: <stable@vger.kernel.org>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Applied (I'll send it sometime this merging window). Thanks.
> 
> Thanks, I mistakenly thought this should be sent to stable for 4.2, but
> actually I was wrong so Cc stable should be dropped to avoid noise.

AFAICT, commit e9a4b795652f was merged in 4.3-rc1. Your fix will go in
4.4-rc1, so cc stable is fine.

-- 
Catalin

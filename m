From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Feb 2014 11:20:25 +0000
Subject: [RFC PATCH 2/2] arm: mm: Double logical invert for LPAE
 pte_write(), pte_dirty()
In-Reply-To: <20140220172651.GM3615@mudshark.cambridge.arm.com>
References: <1392396913-13570-1-git-send-email-steve.capper@linaro.org>
 <1392396913-13570-3-git-send-email-steve.capper@linaro.org>
 <20140220172651.GM3615@mudshark.cambridge.arm.com>
Message-ID: <20140221112025.GB5747@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 05:26:51PM +0000, Will Deacon wrote:
> On Fri, Feb 14, 2014 at 04:55:13PM +0000, Steve Capper wrote:
> > On LPAE, L_PTE_WRITE and L_PTE_DIRTY are in the upper 32-bits.
> > Unfortunately, results from pte_write() and pte_dirty() are downcast
> > to 32-bits by core code:
> >   o gather_stats
> >   o huge_pte_dirty
> >   o huge_pte_write
> >   o make_migration_entry
> > 
> > This patch adds a double logical invert to pte_write() and pte_dirty()
> > for LPAE to ensure that the lower 32-bits are set if true.
> 
> Yikes, this sounds like something we should put in -stable, no? If so,
> better make it patch 1 of this series.

That's a bug on arm64 as well since functions like gather_stats() take
an int as argument.

However, my preference is for a static inline function instead of "!!"
on arm64.

Steve, would you send a patch for arm64? If not, I can do it (with your
reported-by).

Thanks.

-- 
Catalin

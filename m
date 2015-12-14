From: ashoks@broadcom.com (Ashok Kumar)
Date: Mon, 14 Dec 2015 08:46:03 -0800
Subject: [RFC PATCH 0/2] arm64: change PoC D-cache flush to PoU
In-Reply-To: <20151214151117.GD22038@mbp>
References: <1450099664-38554-1-git-send-email-ashoks@broadcom.com>
 <20151214151117.GD22038@mbp>
Message-ID: <20151214164603.GA25971@ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for the review.

On Mon, Dec 14, 2015 at 03:11:18PM +0000, Catalin Marinas wrote:
> On Mon, Dec 14, 2015 at 05:27:42AM -0800, Ashok Kumar wrote:
> > Also deferred dcache flush in __cpu_copy_user_page to __sync_icache_dcache.
> > May I know why I/D sync is needed in __cpu_copy_user_page? My understanding 
> > is that any self modifying code in userspace is supposed to take care of the 
> > coherency using the respective cache flush system call. 
> 
> I think it may have been there for historical reasons on arch/arm
> (115b22474eb1 - "ARM: 5794/1: Flush the D-cache during
> copy_user_highpage()") and imported in arch/arm64. But looking back at
> this, I don't think we need it for two reasons: dynamic linker no longer
> relocating symbols in a text page (and cause CoW) and set_pte_at()
> already calling __sync_icache_dcache().

In that case, shall we get rid of the flush in __sync_icache_dcache also
by not calling flush_dcache_page in __cpu_copy_user_page?

> 
> -- 
> Catalin
> 

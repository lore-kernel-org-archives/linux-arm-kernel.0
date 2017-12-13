From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 Dec 2017 11:58:36 +0000
Subject: [PATCH] arm64: fix CONFIG_DEBUG_WX address reporting (was: Re: How
 to debug "insecure W+X mapping"?)
In-Reply-To: <680ec27a-1557-f2d9-8159-bd49326bd36c@redhat.com>
References: <bff5a2b3-0d93-5f55-c129-4b14a5a09b45@codeaurora.org>
 <680ec27a-1557-f2d9-8159-bd49326bd36c@redhat.com>
Message-ID: <20171213115835.pkt3fyqcbk7lgdeb@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 03:30:00PM -0800, Laura Abbott wrote:
> On 12/12/2017 02:57 PM, Timur Tabi wrote:
> > We have a 4.10-based kernel that occasionally displays an insecure W+X mapping (courtesy of CONFIG_DEBUG_WX):
> > 
> > [??? 7.151680] arm64/mm: Found insecure W+X mapping at address 0000345a049d2000/0x345a049d2000
> > ...
> > [??? 7.435481] Checked W+X mappings: FAILED, 4 W+X pages found, 0 non-UXN pages found
> > 
> > The number of actual W+X pages varies, e.g. sometimes it says 6 pages.
> > 
> > How do I go about debugging this? How do I identify the source of 0000345a049d2000?	
> 
> That's a funny address. The check was written to scan the init_mm
> page table but that's not a kernel address on arm64. It almost looks
> like something set up a userspace mapping very early in the boot process?

Whoops; I think we forgot to apply the VA_START offset in
ptdump_check_wx(), so we report the address wrong.

Does the below (untested) patch result in a sane-looking report?

Thanks,
Mark.

---->8----
>From b3021b76b9ea1e65388b38dfe622ea956cb18647 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 13 Dec 2017 11:45:42 +0000
Subject: [PATCH] arm64: fix CONFIG_DEBUG_WX address reporting

In ptdump_check_wx(), we pass walk_pgd() a start address of 0 (rather
than VA_START) for the init_mm. This means that any reported W&X
addresses are offset by VA_START, which is unexepcted and confusing.

Let's fix this by telling the ptdump code that we're walking init_mm
starting at VA_START. We don't need to update the addr_markers, since
these are still valid bounds regardless.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>
Reported-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm64/mm/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index ca74a2aace42..7b60d62ac593 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -389,7 +389,7 @@ void ptdump_check_wx(void)
 		.check_wx = true,
 	};
 
-	walk_pgd(&st, &init_mm, 0);
+	walk_pgd(&st, &init_mm, VA_START);
 	note_page(&st, 0, 0, 0);
 	if (st.wx_pages || st.uxn_pages)
 		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found, %lu non-UXN pages found\n",
-- 
2.11.0

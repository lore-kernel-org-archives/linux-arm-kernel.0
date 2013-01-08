From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Jan 2013 16:46:40 +0000
Subject: [PATCH] ARM: Only initialize max_mapnr when using flatmem
In-Reply-To: <1350935514-27422-1-git-send-email-spang@chromium.org>
References: <1350935514-27422-1-git-send-email-spang@chromium.org>
Message-ID: <20130108164640.GA30493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 03:51:54PM -0400, Michael Spang wrote:
> The expression used to initialize max_mapnr is not appropriate for
> sparsemem, since mem_map is NULL and pfn_to_page() only works on valid
> pages. This patch leaves max_mapnr uninitialized for sparsemem.
> 
> For flatmem, the expression simplifies to copying max_pfn.
> 
> Signed-off-by: Michael Spang <spang@chromium.org>
> ---
>  arch/arm/mm/init.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> I'm not sure we need this variable it all - it looks like there are no
> users.

Indeed, I've just confirmed that. I suggest we just get rid of it instead,
like this:

 arch/arm/mm/init.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index ad722f1..bd93bdc 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -600,7 +600,11 @@ void __init mem_init(void)
 	extern u32 itcm_end;
 #endif
 
-	max_mapnr   = pfn_to_page(max_pfn + PHYS_PFN_OFFSET) - mem_map;
+	/*
+	 * We used to initialize max_mapnr here to be the same as max_pfn,
+	 * but as nothing uses it (we don't use the generic pfn_valid())
+	 * this has become unnecessary.
+	 */
 
 	/* this will put all unused low memory onto the freelists */
 	free_unused_memmap(&meminfo);

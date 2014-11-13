From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Nov 2014 11:44:20 +0000
Subject: [PATCH] efi: Fix free_end build warning
In-Reply-To: <1415824050.15847.9.camel@smoke>
References: <1415824050.15847.9.camel@smoke>
Message-ID: <20141113114420.GF13350@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Wed, Nov 12, 2014 at 08:27:30PM +0000, Geoff Levand wrote:
> Initialize the free_end variable to zero.  Fixes build warnings
> like these:
> 
>   arch/arm64/kernel/efi.c: warning: ?free_end? may be used uninitialized in this function
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> Got this with the latest arm64/for-next/core branch.  Please consider.
> 
> -Geoff 
> 
>  arch/arm64/kernel/efi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 4f39a18..83fc53c 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -239,6 +239,7 @@ static void __init free_boot_services(void)
>  	 * want to keep for UEFI.
>  	 */
>  
> +	free_end = 0;
>  	keep_end = 0;
>  	free_start = 0;

Do you have any idea how GCC arrives at this conclusion? I can't see a
path through that function where we use free_end without initialising it.

Does something like the patch below help?

Will

--->8

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 95c49ebc660d..4c577b538d1c 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -271,17 +271,16 @@ static void __init free_boot_services(void)
                size = npages << PAGE_SHIFT;
 
                if (free_start) {
-                       if (paddr <= free_end)
-                               free_end = paddr + size;
-                       else {
+                       if (paddr > free_end) {
                                total_freed += free_region(free_start, free_end);
                                free_start = paddr;
-                               free_end = paddr + size;
                        }
                } else {
                        free_start = paddr;
-                       free_end = paddr + size;
                }
+
+               free_end = paddr + size;
+
                if (free_start < keep_end) {
                        free_start += PAGE_SIZE;
                        if (free_start >= free_end)

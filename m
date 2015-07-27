From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Tue, 28 Jul 2015 00:50:13 +0200
Subject: [PATCH v2 04/25] mm: enhance region_is_ram() to distinguish
 'unknown' vs 'mixed'
In-Reply-To: <20150725023821.8664.81275.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725023821.8664.81275.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20150727225013.GU30479@wotan.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 10:38:21PM -0400, Dan Williams wrote:
> region_is_ram() is used to prevent the establishment of aliased mappings
> to physical "System RAM" with incompatible cache settings.  However, it
> uses "-1" to indicate both "unknown" memory ranges (ranges not described
> by platform firmware) and "mixed" ranges (where the parameters describe
> a range that partially overlaps "System RAM").
> 
> Fix this up by explicitly tracking the "unknown" vs "mixed" resource
> cases. In addition to clarifying that "-1" means the requested spanned
> RAM and non-RAM resource, this re-write also adds support for detecting
> when the requested range completely covers all of a resource.
> 
> Finally, the implementation treats overlaps between "unknown" and RAM as
> RAM.
> 
> Cc: Toshi Kani <toshi.kani@hp.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  kernel/resource.c |   43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index fed052a1bc9f..119b282985f9 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -493,39 +493,42 @@ int __weak page_is_ram(unsigned long pfn)
>  EXPORT_SYMBOL_GPL(page_is_ram);
>  
>  /*
> - * Search for a resouce entry that fully contains the specified region.
> - * If found, return 1 if it is RAM, 0 if not.
> - * If not found, or region is not fully contained, return -1
> + * Check if the specified region partially overlaps or fully eclipses "System
> + * RAM". Return '0' if the region does not overlap RAM, return '-1' if the
> + * region overlaps RAM and another resource, and return '1' if the region
> + * overlaps RAM and no other defined resource. Note, that '1' is also returned
> + * in the case when the specified region overlaps RAM and undefined memory
> + * holes.
>   *
>   * Used by the ioremap functions to ensure the user is not remapping RAM and is
>   * a vast speed up over walking through the resource table page by page.
>   */
>  int region_is_ram(resource_size_t start, unsigned long size)
>  {

There not many user of region_is_ram() so changing region_is_ram() to return an
enum and thereby making it easier to both extend this documention and read the
code exactly what it is returning would be of large value here and would not be
much work.

  Luis

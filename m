From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Sep 2011 10:04:31 +0100
Subject: change_page_attr() implementation for ARM?
In-Reply-To: <D19EBEE1D7B1F742A8ED7130E050A38A4CA460FF0C@HQMAIL02.nvidia.com>
References: <D19EBEE1D7B1F742A8ED7130E050A38A4CA460FF0C@HQMAIL02.nvidia.com>
Message-ID: <CAHkRjk4mqhu+HhoSAnowk6=5GzXXhmKCE-3jrjhMpVzbtakFYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

(I'm not sure how the quoted message ends up but your email client
didn't wrap lines properly)

On 21 September 2011 23:10, Vinod Rex <vrex@nvidia.com> wrote:
> On Cortex-A9, we have observed stale data being read from write-combine (C=0 B=1) memory regions mapped into userspace which have a duplicate cacheable mapping in the kernel address space (due to the kernel linear mapping).
>
> The issue appears to be due to speculative prefetch on the cacheable kernel linear mapping which gets lines into the L2 cache. When reads are performed on the write-combine mapping for this address range, these reads get the stale data from L2 instead of memory.

If your system has a PL310, there is bit 22 in the auxiliary control
register which makes reads via the non-cacheable mapping not to hit
the L2 cache. I had this patch queued in Russell's system for a long
time:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6529/1

Alternatively, you can pass this bit via your platform code.

> As per the Cortex-A9 spec, behavior for double mappings with conflicting page attributes is undefined, so we need a way to make sure all duplicate mappings have the same memory type attributes.

Avoiding aliases would be better but we don't have a fully stable patch yet.

> Similar issue on x86 is handled using the change_page_attr()/set_memory_*() functions defined in arch/x86/mm/pageattr.c. ?This function modifies the attributes of the page in kernel linear map to match the corresponding mapping in userspace to avoid having duplicate mappings with different page attributes. It accomplishes this by splitting section (large page) mappings into 4KB page mappings as needed so that the page attribute change is done only for the requested memory region.
>
> Would a similar implementation for ARM be appropriate? We are experimenting with a port of change_page_attr() to ARM that seems to solve our problems.

The kernel linear mapping is done using sections, so we would have to
change the attributes for a full section. Russell's approach I think
is better but people reported some stability issues.

-- 
Catalin

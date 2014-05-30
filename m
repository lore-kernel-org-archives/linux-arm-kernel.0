From: robherring2@gmail.com (Rob Herring)
Date: Fri, 30 May 2014 10:33:46 -0500
Subject: [PATCH v3 2/2] ARM : change fixmap mapping region to support 32
 CPUs
In-Reply-To: <1397559967-26050-3-git-send-email-sdu.liu@huawei.com>
References: <1397559967-26050-1-git-send-email-sdu.liu@huawei.com>
 <1397559967-26050-3-git-send-email-sdu.liu@huawei.com>
Message-ID: <CAL_JsqKE-L2PN3mXHNdTPMEyTMR9ZtbgGB=O_V6nOXN0YC0a4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 6:06 AM, Liu Hua <sdu.liu@huawei.com> wrote:
> In 32-bit ARM systems, the fixmap mapping region can support
> no more than 14 CPUs(total: 896k; one CPU: 64K). And we can
> configure NR_CPUS up to 32. So there is a mismatch.
>
> This patch moves fixmapping region downwards to region
> 0xffc00000-0xffe00000. Then the fixmap mapping region can
> support up to 32 CPUs

Ugg, this series breaks using fixmap for anything other than kmap
since 32 cpus requires all 2MB of the region and nothing is left.
There's work in flight to support early_ioremap, early console, and RO
text patching which all use the fixmap region.

There's a couple of options to solve this:

- Only support up to 16 cpus. It could be anywhere between 17-31, but
that seems somewhat unlikely. Are we really ever going to see 32-bit
32 core systems?
- Reduce KM_TYPE_NR from 16 to 15. Based on the comment for it, we
probably don't want to do that. Is increasing it to the default of 20
worthwhile? Some of the options here would allow doing that.
- Add 0xffe00000-0xfff00000 to the fixmap region. This would make
fixmap span 2 PMDs with the top PMD having a mixture of uses like we
had before.
- push the PCI i/o space down to 0xfec00000 and make fixmap 4MB. This
is a cleaner solution as the 2 PMDs are only used for fixmap. This may
require some static mapping adjustments on some platforms.
- Same as previous option, but convert the PCI i/o space to fixmap
entries. We don't really need all 2MB for PCI.

Opinions on the best solution?


Also, there is an error in the documentation below:

>
> Signed-off-by: Liu Hua <sdu.liu@huawei.com>
> ---
>  Documentation/arm/memory.txt   |  2 +-
>  arch/arm/include/asm/fixmap.h  | 16 ++--------------
>  arch/arm/include/asm/highmem.h |  1 +
>  arch/arm/mm/highmem.c          | 27 +++++++++++++++++++++------
>  arch/arm/mm/mmu.c              |  4 ++++
>  5 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/arm/memory.txt b/Documentation/arm/memory.txt
> index 4bfb9ff..a9fc59b 100644
> --- a/Documentation/arm/memory.txt
> +++ b/Documentation/arm/memory.txt
> @@ -41,7 +41,7 @@ fffe8000      fffeffff        DTCM mapping area for platforms with
>  fffe0000       fffe7fff        ITCM mapping area for platforms with
>                                 ITCM mounted inside the CPU.
>
> -fff00000       fffdffff        Fixmap mapping region.  Addresses provided
> +fffc0000       ffdfffff        Fixmap mapping region.  Addresses provided

s/fffc0000/ffc00000/

Rob

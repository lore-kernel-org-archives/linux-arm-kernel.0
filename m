From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Jan 2015 13:46:11 +0000
Subject: [PATCH] arm64: dump: Fix implicit inclusion of definition for
 PCI_IOBASE
In-Reply-To: <1421065784-31708-1-git-send-email-broonie@kernel.org>
References: <1421065784-31708-1-git-send-email-broonie@kernel.org>
Message-ID: <20150112134611.GF16706@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Jan 12, 2015 at 12:29:44PM +0000, Mark Brown wrote:
> Since c9465b4ec37a68425 (arm64: add support to dump the kernel page tables)
> allmodconfig has failed to build on arm64 as a result of:
> 
> ../arch/arm64/mm/dump.c:55:20: error: 'PCI_IOBASE' undeclared here (not in a function)

When I build a v3.19-rc4 allmodconfig, I don't see this failure, but I
agree that we need the explicit include for PCI_IOBASE.

> Fix this by explicitly including io.h to ensure that a definition is
> present.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/mm/dump.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index cf33f33333cc..258ce731c5cd 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -14,6 +14,7 @@
>   * of the License.
>   */
>  #include <linux/debugfs.h>
> +#include <linux/io.h>
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/sched.h>

Nit: please keep includes ordered (unless there's some other include
issue?).

I see that for other definitions we include the asm headers rather than
linux headers, and we also seem to be missing an include of asm/memory.h
for MODULES_VADDR and PAGE_OFFSET.

Does the below work for you?

Thanks,
Mark.

---->8----
diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index cf33f33..88f9ad9 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -19,7 +19,9 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 
+#include <asm/io.h>
 #include <asm/fixmap.h>
+#include <asm/memory.h>
 #include <asm/pgtable.h>
 
 #define LOWEST_ADDR    (UL(0xffffffffffffffff) << VA_BITS)

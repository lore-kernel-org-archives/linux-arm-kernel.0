From: msalter@redhat.com (Mark Salter)
Date: Wed, 14 Jan 2015 10:16:35 -0500
Subject: [PATCH] arm64: allow late use of early_ioremap
In-Reply-To: <54B62730.6090107@linaro.org>
References: <1421081711-1128-1-git-send-email-msalter@redhat.com>
 <20150112172534.GJ13360@arm.com>
 <1421089778.12632.2.camel@t520.localdomain> <54B62730.6090107@linaro.org>
Message-ID: <1421248595.2181.0.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-01-14 at 16:22 +0800, Hanjun Guo wrote:
> Hi Mark,
> 
> On 2015?01?13? 03:09, Mark Salter wrote:
> > On Mon, 2015-01-12 at 17:25 +0000, Will Deacon wrote:
> >> On Mon, Jan 12, 2015 at 04:55:11PM +0000, Mark Salter wrote:
> >>> Commit 0e63ea48b4d8 (arm64/efi: add missing call to early_ioremap_reset())
> >>> added a missing call to early_ioremap_reset(). This triggers a BUG if code
> >>> tries using early_ioremap() after the early_ioremap_reset(). This is a
> >>> problem for some ACPI code which needs short-lived temporary mappings
> >>> after paging_init() but before mm_init(). This patch adds definitions for
> 
> Minor update:
> ... after paging_init() but before acpi_early_init() in start_kernel().
> 
> In ACPI, permanent mapping will be used after acpi_gbl_permanent_mmap
> set to 1 in acpi_early_init(), since GIC init and Arch timer init will
> be called before acpi_early_init(), early_ioremap() is still needed
> after mm_init().
> 
> >>> the __late_set_fixmap() and __late_clear_fixmap() which avoids the BUG
> >>> by allowing later use of early_ioremap().
> >>>
> >>> Signed-off-by: Mark Salter <msalter@redhat.com>
> >>> CC: Leif Lindholm <leif.lindholm@linaro.org>
> >>> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>> ---
> >>>   arch/arm64/include/asm/fixmap.h | 3 +++
> >>>   1 file changed, 3 insertions(+)
> >>
> >> Given that we don't support ACPI on arm64 in mainline, I assume this can
> >> wait until at least 3.20?
> >
> > Sure. Just needs it to go in before ACPI code. And tbh, the ACPI code
> > could change and make this unneeded.
> 
> This is the best solution for now, so I need to add this patch as the 
> first one for ACPI core patch set, is it ok for you?

Yes. Thanks.

> 
> Thanks
> Hanjun

From: bp@alien8.de (Borislav Petkov)
Date: Fri, 12 Oct 2018 13:14:08 +0200
Subject: [PATCH v6 09/18] ACPI / APEI: Let the notification helper
 specify the fixmap slot
In-Reply-To: <20180921221705.6478-10-james.morse@arm.com>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-10-james.morse@arm.com>
Message-ID: <20181012111408.GC580@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 11:16:56PM +0100, James Morse wrote:
> ghes_copy_tofrom_phys() uses a different fixmap slot depending on in_nmi().
> This doesn't work when we have multiple NMI-like notifications, that
> can interrupt each other.
> 
> As with the locking, move the chosen fixmap_idx to the notification helper.
> This only matters for NMI-like notifications, anything calling
> ghes_proc() can use the IRQ fixmap slot as its already holding an irqsave
> spinlock.
> 
> This lets us collapse the ghes_ioremap_pfn_*() helpers.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> 
> The fixmap-idx and vaddr are passed back to ghes_unmap()
> to allow ioremap() to be used in process context in the
> future.
> ---
>  drivers/acpi/apei/ghes.c | 76 ++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 49 deletions(-)

Nice.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

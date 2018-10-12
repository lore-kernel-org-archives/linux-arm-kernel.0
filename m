From: bp@alien8.de (Borislav Petkov)
Date: Fri, 12 Oct 2018 19:14:39 +0200
Subject: [PATCH v6 13/18] ACPI / APEI: Don't update struct ghes' flags in
 read/clear estatus
In-Reply-To: <20180921221705.6478-14-james.morse@arm.com>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-14-james.morse@arm.com>
Message-ID: <20181012171439.GF580@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 11:17:00PM +0100, James Morse wrote:
> ghes_read_estatus() sets a flag in struct ghes if the buffer of
> CPER records needs to be cleared once the records have been
> processed. This global flags value is a problem if a struct ghes
> can be processed concurrently, as happens at probe time if an
> NMI arrives for the same error source.
> 
> The GHES_TO_CLEAR flags was only set at the same time as
> buffer_paddr, which is now owned by the caller and passed to
> ghes_clear_estatus(). Use this as the flag.
> 
> A non-zero buf_paddr returned by ghes_read_estatus() means
> ghes_clear_estatus() will clear this address. ghes_read_estatus()
> already checks for a read of error_status_address being zero,
> so we can never get CPER records written at zero.
> 
> After this ghes_clear_estatus() no longer needs the struct ghes.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 26 ++++++++++++--------------
>  include/acpi/ghes.h      |  1 -
>  2 files changed, 12 insertions(+), 15 deletions(-)

Nice.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

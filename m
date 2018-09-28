From: bp@alien8.de (Borislav Petkov)
Date: Fri, 28 Sep 2018 19:04:46 +0200
Subject: [PATCH v6 04/18] ACPI / APEI: Switch NOTIFY_SEA to use the
 estatus queue
In-Reply-To: <20180921221705.6478-5-james.morse@arm.com>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-5-james.morse@arm.com>
Message-ID: <20180928170446.GE20768@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 11:16:51PM +0100, James Morse wrote:
> Now that the estatus queue can be used by more than one notification
> method, we can move notifications that have NMI-like behaviour over to
> it, and start abstracting GHES's single in_nmi() path.
> 
> Switch NOTIFY_SEA over to use the estatus queue. This makes it behave
> in the same way as x86's NOTIFY_NMI.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/acpi/apei/ghes.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d7c46236b353..150fb184c7cb 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -58,6 +58,10 @@
>  
>  #define GHES_PFX	"GHES: "
>  
> +#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
> +#define WANT_NMI_ESTATUS_QUEUE	1
> +#endif

Is that just so that you have shorter ifdeffery lines? Because if so, an
additional level of indirection is silly. Or maybe there's more coming -
I'll see when I continue going through this set. :)

Otherwise looks good - trying to reuse the facilities and all. Better. :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

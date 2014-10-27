From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Oct 2014 12:24:51 +0000
Subject: [PATCH 10/10] arm64: dmi: set DMI string as dump stack arch
 description
In-Reply-To: <1413987713-30528-11-git-send-email-ard.biesheuvel@linaro.org>
References: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
 <1413987713-30528-11-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141027122451.GT8768@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 03:21:53PM +0100, Ard Biesheuvel wrote:
> This sets the DMI string, containing system type, serial number,
> firmware version etc. as dump stack arch description, so that oopses
> and other kernel stack dumps automatically have this information
> included, if available.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/efi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 0e9da0067ef2..baab9344a32b 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -477,6 +477,8 @@ static int __init arm64_dmi_init(void)
>  	 * itself, depends on dmi_scan_machine() having been called already.
>  	 */
>  	dmi_scan_machine();
> +	if (dmi_available)
> +		dmi_set_dump_stack_arch_desc();

This looks fine, but I don't understand why you would ever *not* want to
call this when DMI is available. In other words, why can't this be part
of dmi_scan_machine?

Will

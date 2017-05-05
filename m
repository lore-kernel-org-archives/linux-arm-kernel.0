From: bp@alien8.de (Borislav Petkov)
Date: Fri, 5 May 2017 15:27:17 +0200
Subject: [PATCH V15 08/11] efi: print unrecognized CPER section
In-Reply-To: <1492556723-9189-9-git-send-email-tbaicar@codeaurora.org>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-9-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20170505132717.zodffuha46f3q5sj@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 05:05:20PM -0600, Tyler Baicar wrote:
> UEFI spec allows for non-standard section in Common Platform Error
> Record. This is defined in section N.2.3 of UEFI version 2.5.
> 
> Currently if the CPER section's type (UUID) does not match with
> one of the section types that the kernel knows how to parse, the
> section is skipped. Therefore, user is not able to see
> such CPER data, for instance, error record of non-standard section.
> 
> For above mentioned case, this change prints out the raw data in
> hex in dmesg buffer.

... because? We'd need the reason why we're not ignoring those errors
anymore.

>  Data length is taken from Error Data length
> field of Generic Error Data Entry.
> 
> The following is a sample output from dmesg:
> [  140.739180] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
> [  140.739182] {1}[Hardware Error]: It has been corrected by h/w and requires no further action
> [  140.739191] {1}[Hardware Error]: event severity: corrected
> [  140.739196] {1}[Hardware Error]:  time: precise 2017-03-15 20:37:35
> [  140.739197] {1}[Hardware Error]:  Error 0, type: corrected
> [  140.739203] {1}[Hardware Error]:   section type: unknown, d2e2621c-f936-468d-0d84-15a4ed015c8b
> [  140.739205] {1}[Hardware Error]:   section length: 568 (0x238)
> [  140.739210] {1}[Hardware Error]:   00000000: 4d415201 4d492031 453a4d45 435f4343  .RAM1 IMEM:ECC_C
> [  140.739214] {1}[Hardware Error]:   00000010: 53515f45 44525f42 00000000 00000000  E_QSB_RD........
> [  140.739217] {1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> [  140.739220] {1}[Hardware Error]:   00000030: 00000000 00000000 01010000 01010000  ................
> [  140.739223] {1}[Hardware Error]:   00000040: 00000000 00000000 00000005 00000000  ................
> [  140.739226] {1}[Hardware Error]:   00000050: 01010000 00000000 00000001 00dddd00  ................

Kill all those prefixes:

" Hardware error from APEI Generic Hardware Error Source: 2
  It has been corrected by h/w and requires no further action
  event severity: corrected
   time: precise 2017-03-15 20:37:35
   Error 0, type: corrected
    section type: unknown, d2e2621c-f936-468d-0d84-15a4ed015c8b
    section length: 568 (0x238)
    00000000: 4d415201 4d492031 453a4d45 435f4343  .RAM1 IMEM:ECC_C
    00000010: 53515f45 44525f42 00000000 00000000  E_QSB_RD........
    00000020: 00000000 00000000 00000000 00000000  ................
    00000030: 00000000 00000000 01010000 01010000  ................
    00000040: 00000000 00000000 00000005 00000000  ................
    00000050: 01010000 00000000 00000001 00dddd00  ................
"

to the important info only.


> ...
> 
> The raw data from the error can then be decoded using vendor
> specific tools.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> CC: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  drivers/firmware/efi/cper.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index f959185..610d31a 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -596,8 +596,16 @@ static void cper_estatus_timestamp(const char *pfx,
>  			cper_print_proc_arm(newpfx, arm_err);
>  		else
>  			goto err_section_too_small;
> -	} else
> -		printk("%s""section type: unknown, %pUl\n", newpfx, sec_type);
> +	} else {
> +		const void *unknown_err;
> +
> +		unknown_err = acpi_hest_get_payload(gdata);

Simply:

	const void *err = acpi_hest_get_payload(gdata);

Short and sweet.

> +		printk("%ssection type: unknown, %pUl\n", newpfx, sec_type);
> +		printk("%ssection length: %d (%#x)\n", newpfx,

One number format is fine.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

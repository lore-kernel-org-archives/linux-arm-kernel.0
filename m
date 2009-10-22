From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 23 Oct 2009 05:05:29 +0800
Subject: [PATCH] Zaurus: Fix PROM partition table for spitz
In-Reply-To: <1256245103.9561.11.camel@utx.utx.cz>
References: <1256245103.9561.11.camel@utx.utx.cz>
Message-ID: <f17812d70910221405v753eadbdu67c0d532ac77e222@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm a bit upset that some things else may depend on the original
layout (though that's incorrect), and this possibly breaks the
sequence numbering of /dev/mtd?.

On Fri, Oct 23, 2009 at 4:58 AM, Stanislav Brabec <utx@penguin.cz> wrote:
> Attached patch fixes partition table of the Zaurus PROM. It works on
> terrier, but I guess it is common for all Zaurus models.
>
> The partition marked ??"Boot PROM Filesystem" is a fact a database file
> for EN-JP dictionary. Designers decided to put the English-Japanese
> translation dictionary to the remaining part of the PROM.
>
> Changes:
>
> Newly mapped the bootloader system as "Boot PROM System".
>
> Already mapped EN-JP dictionary changes its name from ?"Boot PROM
> Filesystem" to "EN-JP Data File".
>
> How to verify the layout on other models:
> ?root at zaurus:~# modprobe physmap
> root at zaurus:~# file -s /dev/mtd4
> /dev/mtd4: DBase 3 data file (1031668283 records)
>
> Signed-off-by: Stanislav Brabec <utx@penguin.cz>
>
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index ee8d603..c382d14 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -658,7 +696,11 @@ static struct platform_device sharpsl_nand_device = {
>
> ?static struct mtd_partition sharpsl_rom_parts[] = {
> ? ? ? ?{
> - ? ? ? ? ? ? ? .name ? ="Boot PROM Filesystem",
> + ? ? ? ? ? ? ? .name ? ="Boot PROM System",
> + ? ? ? ? ? ? ? .offset = 0x00100000,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ="EN-JP Data File",
> ? ? ? ? ? ? ? ?.offset = 0x00140000,
> ? ? ? ? ? ? ? ?.size ? = MTDPART_SIZ_FULL,
> ? ? ? ?},
>
>
>
> ________________________________________________________________________
> Stanislav Brabec
> http://www.penguin.cz/~utx/zaurus
>
>

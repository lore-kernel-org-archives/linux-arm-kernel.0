From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 5 Mar 2015 14:00:00 +0100
Subject: [PATCH v3 5/9] mtd: pxa3xx_nand: add support for the Marvell
 Berlin nand controller
In-Reply-To: <1425555085-29531-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425555085-29531-6-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150305140000.39081aa8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Antoine Tenart,

On Thu,  5 Mar 2015 12:31:21 +0100, Antoine Tenart wrote:

>  struct pxa3xx_nand_host {
> @@ -253,6 +258,12 @@ static struct pxa3xx_nand_flash builtin_flash_types[] = {
>  { "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, 4096 },
>  { "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096 },
>  { "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048 },
> +{ }
> +};
> +
> +static struct pxa3xx_nand_flash berlin_builtin_flash_types[] = {
> +{ "4GiB 8-bit",    0xd7ec, 128, 8192,  8,  8, 4096 },
> +{ },

This looks fishy. You know have two different definitions for the exact
same chip_id. In the builtin_flash_types[] array:

{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, 8192 },

and in your new berlin_builtin_flash_types[] array:

{ "4GiB 8-bit",    0xd7ec, 128, 8192,  8,  8, 4096 },

So you have twice a big pages, and twice as less blocks. Are you sure
about your definition of the 0xd7ec NAND chip_id ?

Why cannot you use the same data for both the Berlin platform and the
platforms already supported by the driver? Are you sure your NAND isn't
using 4k pages ? Or maybe the 0xd7ec entry in builtin_flash_types[] is
incorrect?

Or maybe like
http://lists.infradead.org/pipermail/linux-mtd/2010-June/031159.html,
the NAND chip_id is the same, but the NAND ext id is different.

Is there no common NAND mechanism to handle this, rather than having
this specifically in the driver?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

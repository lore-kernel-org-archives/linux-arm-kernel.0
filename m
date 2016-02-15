From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 15 Feb 2016 09:33:26 +0100
Subject: [PATCH 1/3] clk: unconditionally recurse into clk/mvebu/
In-Reply-To: <1455521698-7905-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455521698-7905-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455521698-7905-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CAPv3WKdnFg6AYNGexyEvMEjKmHadj4+CH5avnd=5d_HEKCTc2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,



2016-02-15 8:34 GMT+01:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> The drivers/clk/mvebu directory is only being built when
> CONFIG_PLAT_ORION=y. As we are going to support additional mvebu
> platforms in drivers/clk/mvebu, which don't have CONFIG_PLAT_ORION=y,
> we need to recurse into this directory regardless of the value of
> CONFIG_PLAT_ORION.
>
> Since all files in drivers/clk/mvebu/ are already conditionally
> compiled depending on various Kconfig options, we can recurse
> unconditionally into drivers/clk/mvebu without any other change.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/clk/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index b038e36..e08bb0e 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -61,7 +61,7 @@ obj-$(CONFIG_ARCH_MEDIATEK)           += mediatek/
>  ifeq ($(CONFIG_COMMON_CLK), y)
>  obj-$(CONFIG_ARCH_MMP)                 += mmp/
>  endif
> -obj-$(CONFIG_PLAT_ORION)               += mvebu/
> +obj-y                                  += mvebu/

I know it works with obj-y, but how about using
obj-$(CONFIG_ARCH_MVEBU)? A person editing this Kconfig in future
wouldn't have to run git blame in order to ensure with your commit
log, that he doesn't compile anything more than planned.

Best regards,
Marcin

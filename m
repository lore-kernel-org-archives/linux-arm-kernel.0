From: dann.frazier@canonical.com (Dann Frazier)
Date: Tue, 30 Sep 2014 08:45:20 -0600
Subject: [PATCH v5 3/4] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <1408778588-3215-4-git-send-email-lho@apm.com>
References: <1408778588-3215-1-git-send-email-lho@apm.com>
 <1408778588-3215-2-git-send-email-lho@apm.com>
 <1408778588-3215-3-git-send-email-lho@apm.com>
 <1408778588-3215-4-git-send-email-lho@apm.com>
Message-ID: <CALdTtntGh6kcz+UxOsUsUO_mNZQAzUsgECvzD7CBeEGMswrPsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 23, 2014 at 1:23 AM, Loc Ho <lho@apm.com> wrote:
> This patch adds support for the APM X-Gene SoC EDAC driver. It
> requires ARM64 EDAC support patch [1] to compile due to
> dependence on MC module which calls an unused software memory
> scrub function.
>
> [1] http://www.spinics.net/lists/arm-kernel/msg324093.html
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  drivers/edac/Kconfig      |    9 +-
>  drivers/edac/Makefile     |    3 +
>  drivers/edac/xgene_edac.c | 2132 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2143 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/edac/xgene_edac.c
>
[...]
> +#ifdef CONFIG_OF
> +static struct of_device_id xgene_edac_mc_of_match[] = {
> +       { .compatible = "apm,xgene-edac-mc" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, xgene_edac_of_match);
> +#endif

Something I apparently forgot to mention when I tested v3 was that I
had to manually fix this up to get it to build:

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index d69c2e5..2f436d45 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -452,7 +452,7 @@ static struct of_device_id xgene_edac_mc_of_match[] = {
     { .compatible = "apm,xgene-edac-mc" },
     {},
 };
-MODULE_DEVICE_TABLE(of, xgene_edac_of_match);
+MODULE_DEVICE_TABLE(of, xgene_edac_mc_of_match);
 #endif

 static struct platform_driver xgene_edac_mc_driver = {

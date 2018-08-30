From: bp@alien8.de (Borislav Petkov)
Date: Thu, 30 Aug 2018 12:43:07 +0200
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
Message-ID: <20180830104307.GC20005@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 06:33:52PM +0000, Fan Wu wrote:
> The current ghes_edac driver does not update per-dimm error
> counters when reporting memory errors, because there is no
> platform-independent way to find DIMMs based on the error
> information provided by firmware. This patch offers a solution
> for platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records. In this case ghes_edac will
> use the module handles to locate DIMMs and thus makes per-dimm
> error reporting possible.
> 
> Signed-off-by: Fan Wu <wufan@codeaurora.org>
> ---
>  drivers/edac/ghes_edac.c | 36 +++++++++++++++++++++++++++++++++---
>  include/linux/edac.h     |  2 ++
>  2 files changed, 35 insertions(+), 3 deletions(-)

If we're going to do this, it needs to be tested on an x86 box which loads
ghes_edac. Adding Toshi to Cc.

Otherwise it must remain ARM-specific.

> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 473aeec..db527f0 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -81,6 +81,26 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
>  		(*num_dimm)++;
>  }
>  
> +static int ghes_edac_dimm_index(u16 handle)

get_dimm_smbios_handle()

> +{
> +	struct mem_ctl_info *mci;
> +	int i;
> +
> +	if (!ghes_pvt)
> +		return -1;

You don't need that test.

> +
> +	mci = ghes_pvt->mci;
> +
> +	if (!mci)
> +		return -1;

Ditto.

> +
> +	for (i = 0; i < mci->tot_dimms; i++) {
> +		if (mci->dimms[i]->smbios_handle == handle)
> +			return i;
> +	}
> +	return -1;
> +}
> +
>  static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  {
>  	struct ghes_edac_dimm_fill *dimm_fill = arg;

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

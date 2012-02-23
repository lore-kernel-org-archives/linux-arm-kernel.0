From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Thu, 23 Feb 2012 19:24:35 +0400
Subject: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F465A33.3020208@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-02-2012 18:48, Shawn Guo wrote:

> Change PowerPC dependent IO accessors to architecture independent
> ones, so that fsl_ssi driver can be built on both PowerPC and ARM/IMX.

> Signed-off-by: Shawn Guo<shawn.guo@linaro.org>
> ---
>   sound/soc/fsl/fsl_ssi.c |   75 ++++++++++++++++++++++++++++------------------
>   1 files changed, 46 insertions(+), 29 deletions(-)

> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 3e06696..32fc84b 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
[...]
> @@ -145,7 +148,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
>   	   were interrupted for.  We mask it with the Interrupt Enable register
>   	   so that we only check for events that we're interested in.
>   	 */
> -	sisr = in_be32(&ssi->sisr) & SIER_FLAGS;
> +	sisr = readl(&ssi->sisr) & SIER_FLAGS;

    These functions are not equivalent concerning endianness. You should 
probably have used readl_be() instead, else it won't work on PPC anymore.

WBR, Sergei

From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 27 Jan 2017 10:03:19 +0800
Subject: [PATCH 01/13] mmc: bcm2835: add bcm2835_read_wait_sdcmd
In-Reply-To: <1485473846-24537-2-git-send-email-kraxel@redhat.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
 <1485473846-24537-2-git-send-email-kraxel@redhat.com>
Message-ID: <ff0170ef-2566-1c12-0b27-dccb3bff2e7e@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/1/27 7:37, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/mmc/host/bcm2835.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 9744517..ceee4cf 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -609,6 +609,36 @@ static void bcm2835_prepare_data(struct bcm2835_host *host,
>  	writel(data->blocks, host->ioaddr + SDHBLC);
>  }
>
> +static u32 bcm2835_read_wait_sdcmd(struct bcm2835_host *host, u32 timeout,
> +				   bool check_fail)
> +{
> +	struct device *dev = &host->pdev->dev;
> +	unsigned long start = jiffies;
> +	unsigned long fastpoll = start + usecs_to_jiffies(10);
> +	unsigned long end = start + msecs_to_jiffies(timeout);
> +	u32 value;
> +
> +	for (;;) {
> +		value = readl(host->ioaddr + SDCMD);
> +		if (!(value & SDCMD_NEW_FLAG))
> +			break;
> +		if (check_fail && (value & SDCMD_FAIL_FLAG))
> +			break;
> +		if (time_after(jiffies, end)) {
> +			dev_err(dev, "%s: timeout (%d us)\n",
> +				__func__, timeout);
> +			break;
> +		}
> +
> +		/* if it takes longer reduce poll interval */
> +		if (time_after(jiffies, fastpoll))
> +			udelay(10);
> +		else
> +			cpu_relax();
> +	}

Use readl_poll_timeout intead of open-coding them..

> +	return value;
> +}
> +
>  bool bcm2835_send_command(struct bcm2835_host *host,
>  			  struct mmc_command *cmd)
>  {
>


-- 
Best Regards
Shawn Lin

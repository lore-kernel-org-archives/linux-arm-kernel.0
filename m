From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 16 Feb 2012 06:38:01 -0700
Subject: [PATCH] gpio/gpio-pl061: No need of thaw and poweroff routines
 for hibernate
In-Reply-To: <7662253849428ce018fb7f7359e0585fca9fb597.1326274467.git.viresh.kumar@st.com>
References: <7662253849428ce018fb7f7359e0585fca9fb597.1326274467.git.viresh.kumar@st.com>
Message-ID: <20120216133801.GB29232@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 03:25:20PM +0530, Viresh Kumar wrote:
> pl061 uses same routines for suspend/freeze/poweroff and resume/thaw/restore.
> We are only saving and restoring register values on these routines.
> 
> During hibernation, in freeze() we take a snapshot of gpio registers. In thaw()
> we don't actually need to restore these registers, as power was never shut down
> till now. Similarly, in poweroff() we don't need to take snapshot of these
> registers again, as it was done during freeze() and by now the image is already
> saved on disk.
> 
> This patch passes poweroff() and thaw() routines as NULL to avoid this extra
> work done.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Applied, thanks.

g.

> ---
>  drivers/gpio/gpio-pl061.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
> index 84ba1dd..45b884b 100644
> --- a/drivers/gpio/gpio-pl061.c
> +++ b/drivers/gpio/gpio-pl061.c
> @@ -430,7 +430,12 @@ static int pl061_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(pl061_dev_pm_ops, pl061_suspend, pl061_resume);
> +static const struct dev_pm_ops pl061_dev_pm_ops = {
> +	.suspend = pl061_suspend,
> +	.resume = pl061_resume,
> +	.freeze = pl061_suspend,
> +	.restore = pl061_resume,
> +};
>  #endif
>  
>  static struct amba_id pl061_ids[] = {
> -- 
> 1.7.8.110.g4cb5d
> 

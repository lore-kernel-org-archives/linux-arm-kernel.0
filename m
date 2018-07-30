From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 30 Jul 2018 15:53:06 -0700
Subject: [PATCH v2 7/7] net: phy: Add pm support to Broadcom iProc mdio
 mux driver
In-Reply-To: <1532726613-6483-8-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-8-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <8d732031-c5e8-d6ea-5b61-3b9baf79796f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2018 02:23 PM, Arun Parameswaran wrote:
> Add support for suspend and resume to the Broadcom iProc mdio
> mux driver.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---
>  drivers/net/phy/mdio-mux-bcm-iproc.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
> index 51d1003..d89dce0 100644
> --- a/drivers/net/phy/mdio-mux-bcm-iproc.c
> +++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
> @@ -290,6 +290,33 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int mdio_mux_iproc_suspend(struct device *dev)
> +{
> +	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
> +
> +	if (md->core_clk)
> +		clk_disable_unprepare(md->core_clk);

Since you are assigning md->core_clk to NULL in case clk_get() returned
an error, checking for md->core_clk is not necessary since the Linux
common clock framework perform that NULL check already.
-- 
-- 
Florian

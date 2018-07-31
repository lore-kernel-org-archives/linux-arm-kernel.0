From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 31 Jul 2018 10:57:30 -0700
Subject: [PATCH v2 6/7] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <6308d149-a16b-e737-355c-3edeb7a51e93@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2018 02:23 PM, Arun Parameswaran wrote:
> Add support to configure the internal rate adjust register based on the
> core clock supplied through device tree in the Broadcom iProc mdio mux.
> 
> The operating frequency of the mdio mux block is 11MHz. This is derrived
> by dividing the clock to the mdio mux with the rate adjust register.
> 
> In some SoC's the default values of the rate adjust register do not yield
> 11MHz. These SoC's are required to specify the clock via the device tree
> for proper operation.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---

[snip]

>  static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
> @@ -198,10 +219,22 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  		return PTR_ERR(md->base);
>  	}
>  
> +	md->core_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(md->core_clk)) {
> +		md->core_clk = NULL;

You need to specifically check for -EPROBE_DEFER here and propagate that
to the caller, other errors could be ignored like you do it here, same
comment as in patch 7, if you make md->core_clk NULL, then you can drop
testing for that pointer being valid.
-- 
Florian

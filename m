From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Thu, 26 Jul 2018 12:16:52 -0700
Subject: [PATCH 2/7] net: phy: Fix the register offsets in Broadcom iProc
 mdio mux driver
In-Reply-To: <20180726190636.GG10686@lunn.ch>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-3-git-send-email-arun.parameswaran@broadcom.com>
 <20180726190636.GG10686@lunn.ch>
Message-ID: <6188441f-670d-7644-361b-7a5e8e06c9c2@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18-07-26 12:06 PM, Andrew Lunn wrote:
> On Thu, Jul 26, 2018 at 11:36:19AM -0700, Arun Parameswaran wrote:
>> Modify the register offsets in the Broadcom iProc mdio mux to start
>> from the top of the register address space.
>>
>> Earlier the base address specified was from the middle of the block's
>> register space. The base address will now point to the start of the
>> mdio's address space. The offsets have been fixed to match this.
> 
> Hi Arun
> 
> Did you consider a change something like:
That looks good. I will make this change to the patch.

Thanks
Arun
> 
> diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
> index 0831b7142df7..2d53e609498c 100644
> --- a/drivers/net/phy/mdio-mux-bcm-iproc.c
> +++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
> @@ -169,6 +169,12 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>         md->dev = &pdev->dev;
>  
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +       if (res->start & 0xfff != 0) {
> +               dev_info(&pdev->dev, "Please upgrade your device tree blob.\n");
> +               res->start &= ~0xfff;
> +       }
> +
>         md->base = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(md->base)) {
>                 dev_err(&pdev->dev, "failed to ioremap register\n");
> 
> 
> 	Andrew
> 

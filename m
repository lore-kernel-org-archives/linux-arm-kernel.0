From: rogerq@ti.com (Roger Quadros)
Date: Thu, 17 Jan 2013 14:07:34 +0200
Subject: [PATCH v7 14/22] mfd: omap-usb-host: cleanup clock management code
In-Reply-To: <20130117114401.GE18978@arwen.pp.htv.fi>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-15-git-send-email-rogerq@ti.com>
 <20130117114401.GE18978@arwen.pp.htv.fi>
Message-ID: <50F7E986.3070609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 01:44 PM, Felipe Balbi wrote:
> On Thu, Jan 17, 2013 at 01:30:23PM +0200, Roger Quadros wrote:
>> All ports have similarly named port clocks so we can
>> bunch them into a port data structure and use for loop
>> to enable/disable the clocks.
>>
>> Dynamically allocate and get clocks based on number of ports
>> available on the platform
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/mfd/omap-usb-host.c |  180 ++++++++++++++++++++++++------------------
>>  1 files changed, 103 insertions(+), 77 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index 779588b..c75b79d 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -92,13 +92,12 @@
>>  
>>  struct usbhs_hcd_omap {
>>  	int				nports;
>> +	struct clk			**utmi_clk;
>>  
>>  	struct clk			*xclk60mhsp1_ck;
>>  	struct clk			*xclk60mhsp2_ck;
>> -	struct clk			*utmi_p1_fck;
>> -	struct clk			*usbhost_p1_fck;
>> -	struct clk			*utmi_p2_fck;
>> -	struct clk			*usbhost_p2_fck;
>> +	struct clk			*utmi_p1_gfclk;
>> +	struct clk			*utmi_p2_gfclk;
>>  	struct clk			*init_60m_fclk;
>>  	struct clk			*ehci_logic_fck;
>>  
>> @@ -276,6 +275,7 @@ static int usbhs_runtime_resume(struct device *dev)
>>  	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
>>  	struct usbhs_omap_platform_data	*pdata = omap->pdata;
>>  	unsigned long			flags;
>> +	int i, r;
>>  
>>  	dev_dbg(dev, "usbhs_runtime_resume\n");
>>  
>> @@ -285,13 +285,18 @@ static int usbhs_runtime_resume(struct device *dev)
>>  	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
>>  		clk_enable(omap->ehci_logic_fck);
>>  
>> -	if (is_ehci_tll_mode(pdata->port_mode[0]))
>> -		clk_enable(omap->usbhost_p1_fck);
>> -	if (is_ehci_tll_mode(pdata->port_mode[1]))
>> -		clk_enable(omap->usbhost_p2_fck);
>> -
>> -	clk_enable(omap->utmi_p1_fck);
>> -	clk_enable(omap->utmi_p2_fck);
>> +	for (i = 0; i < omap->nports; i++) {
>> +		if (is_ehci_tll_mode(pdata->port_mode[i])) {
>> +			if (omap->utmi_clk[i]) {
>> +				r = clk_enable(omap->utmi_clk[i]);
>> +				if (r) {
>> +					dev_err(dev,
>> +					 "Can't enable port %d clk : %d\n",
>> +					 i, r);
>> +				}
>> +			}
>> +		}
>> +	}
> 
> you can decrease indentation here a little bit:
> 
> 	for (i = 0; i < omap->nports; i++) {
> 		if (!is_ehci_tll_mode(pdata->port_mode[i]))
> 			continue;
> 
> 		if (!omap->utmi_clk[i])
> 			continue;
> 
> 		r = clk_enable(omap->utmi_clk[i]);
> 		if (r) {
> 			dev_err(dev,
> 			 "Can't enable port %d clk : %d\n",
> 			 i, r);
> 		}
> 	}

OK.

--
cheers,
-roger

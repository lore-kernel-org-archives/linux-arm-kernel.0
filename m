From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 12 Jun 2012 12:40:01 -0500
Subject: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
 <4FD64D6D.3020401@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
Message-ID: <4FD77EF1.8000600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/12/2012 01:53 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Tue, Jun 12, 2012 at 01:26:29, Hunter, Jon wrote:
> 
>>> +	pdev = omap_device_build(name, -1, oh, pdata,
>>> +					sizeof(*pdata), NULL, 0, 0);
>>> +	if (IS_ERR(pdev)) {
>>> +		WARN(1, "Can't build omap_device for %s:%s.\n",
>>> +						name, oh->name);
>>> +		return PTR_ERR(pdev);
>>> +	}
>>> +
>>> +	gpmc_l3_clk = clk_get(NULL, oh->main_clk);
>>> +	if (IS_ERR(gpmc_l3_clk)) {
>>> +		pr_err("Could not get GPMC clock\n");
>>> +		return PTR_ERR(gpmc_l3_clk);
>>> +	}
>>
>> My preference would be to store gpmc_l3_clk in the pdata and pass to
>> probe via the pdata. The aim would be to remove the global gpmc_l3_clk
>> altogether.
> 
> For timing calculation by platform outside of driver, we need clk rate

Right but potentially, this could be done by the driver.

>> Also we should attempt to get the clk before calling omap_device_build
>> which is registering the driver.
> 
> omap_device_build registers only device, but I agree that clk should
> be obtained before it as driver can get probed at that point

Exactly.

Jon

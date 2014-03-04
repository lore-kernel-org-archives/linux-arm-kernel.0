From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 4 Mar 2014 12:50:34 +0200
Subject: [PATCH 2/5] drivers: bus: omap_l3: Convert to use
 devm_request_and_ioremap()
In-Reply-To: <1393924359.866301359@f148.i.mail.ru>
References: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
 <1393923710-10377-3-git-send-email-peter.ujfalusi@ti.com>
 <1393924359.866301359@f148.i.mail.ru>
Message-ID: <5315AFFA.40101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 11:12 AM, Alexander Shiyan wrote:
> ???????,  4 ????? 2014, 11:01 +02:00 ?? Peter Ujfalusi <peter.ujfalusi@ti.com>:
>> We can then remove the iounmap() calls from probe and remove.
>> Since the driver requests the resources via index we can do the mem resource
>> request within a for loop.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti>
>> ---
> 
>> +	/* Get mem resources */
>> +	for (i = 0; i < 3; i++) {
>> +		struct resource	*res = platform_get_resource(pdev,
>> +							     IORESOURCE_MEM, i);
>> +		if (!res) {
>> +			dev_err(&pdev->dev, "couldn't find resource %d\n", i);
>> +			return -ENODEV;
>> +		}
> 
> No need to check "res". devm_request_and_ioremap() do all for us.
> 
>> -	l3->l3_base[2] = ioremap(res->start, resource_size(res));
>> -	if (!l3->l3_base[2]) {
>> -		dev_err(&pdev->dev, "ioremap failed\n");
>> -		ret = -ENOMEM;
>> -		goto err2;
>> +		l3->l3_base[i] = devm_request_and_ioremap(&pdev->dev, res);
>> +		if (!l3->l3_base[i]) {
> 
> if (IS_ERR(l3->l3_base[i]))
> 
>> +			dev_err(&pdev->dev, "ioremap %d failed\n", i);
> 
> Unnecessary.

I'm going to keep this since it tells which resource of the three has failed.

> 
>> +			return -ENOMEM;
> 
> return PTR_ERR(l3->l3_base[i]);
> 
> ---
> 


-- 
P?ter

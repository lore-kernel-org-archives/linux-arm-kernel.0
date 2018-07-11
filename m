From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 11 Jul 2018 09:56:13 -0700
Subject: [PATCH -next] pinctrl: nsp: fix potential NULL dereference in
 nsp_pinmux_probe()
In-Reply-To: <7b4361a5-f757-179c-57b6-44359801baad@broadcom.com>
References: <1531312461-134547-1-git-send-email-weiyongjun1@huawei.com>
 <7b4361a5-f757-179c-57b6-44359801baad@broadcom.com>
Message-ID: <0bd31938-7bf4-134c-18e7-cdcd12b6b370@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/11/2018 9:48 AM, Ray Jui wrote:
> 
> 
> On 7/11/2018 5:34 AM, Wei Yongjun wrote:
>> platform_get_resource() may fail and return NULL, so we should
>> better check it's return value to avoid a NULL pointer dereference
>> a bit later in the code.
>>
>> This is detected by Coccinelle semantic patch.
>>
>> @@
>> expression pdev, res, n, t, e, e1, e2;
>> @@
>>
>> res = platform_get_resource(pdev, t, n);
>> + if (!res)
>> +?? return -EINVAL;
>> ... when != res == NULL
>> e = devm_ioremap_nocache(e1, res->start, e2);

I forgot to mention this in my previous reply. Given that this is a fix 
for a potential NULL pointer dereference and then a kernel crash in the 
case when 'platform_get_resource' returns NULL, can you please add the 
Fixes tag so this fix is picked by all LTS kernels under maintenance?

Thanks,

Ray

>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
> 
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> 
> Change looks good to me, although the check could have been avoided if 
> 'devm_ioremap_resource' is used on the next line instead of 
> 'devm_ioremap_nocache', where validation of resource pointer is done.
> 
> But there's probably a reason why 'devm_ioremap_nocache' was used in 
> this code here.
>

>> ? drivers/pinctrl/bcm/pinctrl-nsp-mux.c | 2 ++
>> ? 1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-mux.c 
>> b/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
>> index 5cd8166..87618a4 100644
>> --- a/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
>> +++ b/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
>> @@ -577,6 +577,8 @@ static int nsp_pinmux_probe(struct platform_device 
>> *pdev)
>> ????????? return PTR_ERR(pinctrl->base0);
>> ????? res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +??? if (!res)
>> +??????? return -EINVAL;
>> ????? pinctrl->base1 = devm_ioremap_nocache(&pdev->dev, res->start,
>> ??????????????????????????? resource_size(res));
>> ????? if (!pinctrl->base1) {
>>

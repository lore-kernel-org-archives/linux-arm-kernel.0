From: b.brezillon@overkiz.com (boris brezillon)
Date: Sun, 08 Dec 2013 19:52:56 +0100
Subject: [PATCH v4 1/3] usb: ohci-at91: replace request_mem_region +
 ioremap by devm_ioremap_resource
In-Reply-To: <52A4BAF6.501@cogentembedded.com>
References: <1386514980-6383-1-git-send-email-b.brezillon@overkiz.com>
 <1386514980-6383-2-git-send-email-b.brezillon@overkiz.com>
 <52A4BAF6.501@cogentembedded.com>
Message-ID: <52A4C008.6050705@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le 08/12/2013 19:31, Sergei Shtylyov a ?crit :
> Hello.
>
> On 12/08/2013 06:02 PM, Boris BREZILLON wrote:
>
>> Replace the request_mem_region + ioremap calls by the
>> devm_ioremap_resource call which does the same things but with device
>> managed resources.
>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>> ---
>>   drivers/usb/host/ohci-at91.c |   28 +++++++---------------------
>>   1 file changed, 7 insertions(+), 21 deletions(-)
>
>> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
>> index 8c356af..fe2ecc5 100644
>> --- a/drivers/usb/host/ohci-at91.c
>> +++ b/drivers/usb/host/ohci-at91.c
>> @@ -158,24 +158,18 @@ static int usb_hcd_at91_probe(const struct 
>> hc_driver *driver,
>>       hcd->rsrc_start = res->start;
>>       hcd->rsrc_len = resource_size(res);
>>
>> -    if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, 
>> hcd_name)) {
>> -        pr_debug("request_mem_region failed\n");
>> -        retval = -EBUSY;
>> -        goto err1;
>> -    }
>> -
>> -    hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
>> -    if (!hcd->regs) {
>> -        pr_debug("ioremap failed\n");
>> -        retval = -EIO;
>> -        goto err2;
>> +    hcd->regs = devm_ioremap_resource(dev, res);
>> +    if (IS_ERR(hcd->regs)) {
>> +        dev_dbg(dev, "devm_ioremap_resource failed\n");
>
>    I've already told you devm_ioremap_resource() prints the detailed 
> error message. No need to duplicate it.
>

Oops, sorry, this is an oversight.
I'll send a new version removing this line.

Best Regards,

Boris

>> +        retval = PTR_ERR(hcd->regs);
>> +        goto err;
>>       }
>
> WBR, Sergei
>

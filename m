From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sun, 11 May 2014 20:14:00 +0530
Subject: [PATCH 5/6] usb: host: ehci-tegra: Use devm_ioremap_resource
 instead of devm_ioremap
In-Reply-To: <536E814E.4020805@cogentembedded.com>
References: <1399715823-19839-1-git-send-email-gautam.vivek@samsung.com>
 <1399715823-19839-6-git-send-email-gautam.vivek@samsung.com>
 <536E814E.4020805@cogentembedded.com>
Message-ID: <CAFp+6iGSfhLB4J4Wr80WSih2bdzcO8vWhgZAonPv6SXbCp-Cmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Sun, May 11, 2014 at 1:13 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 05/10/2014 01:57 PM, Vivek Gautam wrote:
>
>> Using devm_ioremap_resource() API should actually be preferred over
>> devm_ioremap(), since the former request the mem region first and then
>> gives back the ioremap'ed memory pointer.
>> devm_ioremap_resource() calls request_mem_region(), therby preventing
>> other drivers to make any overlapping call to the same region.
>
>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>> ---
>>   drivers/usb/host/ehci-tegra.c |    3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>
>
>> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
>> index 572634c..ccc6433 100644
>> --- a/drivers/usb/host/ehci-tegra.c
>> +++ b/drivers/usb/host/ehci-tegra.c
>> @@ -411,9 +411,8 @@ static int tegra_ehci_probe(struct platform_device
>> *pdev)
>>         }
>>         hcd->rsrc_start = res->start;
>>         hcd->rsrc_len = resource_size(res);
>> -       hcd->regs = devm_ioremap(&pdev->dev, res->start,
>> resource_size(res));
>> +       hcd->regs = devm_ioremap_resource(&pdev->dev, res);
>>         if (!hcd->regs) {
>
>
>    This has to be changed as well as devm_ioremap_resource() returns error,
> not NULL.

Have already updated in the v2 version of this patch, and others in the series.

>
>
>> -               dev_err(&pdev->dev, "Failed to remap I/O memory\n");
>>                 err = -ENOMEM;
>
>
>    This needs to be changed as well, to pass up the error code
> devm_ioremap_resource() returned.

ditoo



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India

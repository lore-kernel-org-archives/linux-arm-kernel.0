From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Jul 2013 23:25:06 +0100
Subject: [RFC/RFT PATCH 3/5] scsi: Use dma_max_pfn(dev) helper for
 bounce_limit calculations
In-Reply-To: <51E07B6E.5090900@cogentembedded.com>
References: <1373665694-7580-1-git-send-email-santosh.shilimkar@ti.com>
 <1373665694-7580-4-git-send-email-santosh.shilimkar@ti.com>
 <51E07B6E.5090900@cogentembedded.com>
Message-ID: <20130712222506.GI24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 13, 2013 at 01:55:58AM +0400, Sergei Shtylyov wrote:
> Hello.
>
> On 07/13/2013 01:48 AM, Santosh Shilimkar wrote:
>
>> DMA bounce limit is the maximum direct DMA'able memory beyond which
>> bounce buffers has to be used to perform dma operations. SCSI driver
>> relies on dma_mask but its calculation is based on max_*pfn which
>> don't have uniform meaning across architectures. So make use of
>> dma_max_pfn() which is expected to return the DMAable maximum pfn
>> value across architectures.
>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: linux-scsi at vger.kernel.org
>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>   drivers/scsi/scsi_lib.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index 86d5220..e8275fa 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -1668,7 +1668,7 @@ u64 scsi_calculate_bounce_limit(struct Scsi_Host *shost)
>>
>>   	host_dev = scsi_get_device(shost);
>>   	if (host_dev && host_dev->dma_mask)
>> -		bounce_limit = *host_dev->dma_mask;
>> +		bounce_limit = dma_max_pfn(host_dev) << PAGE_SHIFT;
>
>    You definitely forgot -1 here.

Please explain your point.

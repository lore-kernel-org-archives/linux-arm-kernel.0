From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 9 Sep 2016 15:18:16 +0530
Subject: [PATCH 4/8] of: dma: Split of_configure_dma() into mask and ops
 configuration
In-Reply-To: <CANqRtoRVRrP9dc3qc-xSE_Wct2HPznzzi1hdrHeC8h2gA=JcKg@mail.gmail.com>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
 <1470696550-3416-5-git-send-email-sricharan@codeaurora.org>
 <CANqRtoRVRrP9dc3qc-xSE_Wct2HPznzzi1hdrHeC8h2gA=JcKg@mail.gmail.com>
Message-ID: <000701d20a7f$4df2ae40$e9d80ac0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

>On Tue, Aug 9, 2016 at 7:49 AM, Sricharan R <sricharan@codeaurora.org> wrote:
>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>
>> The of_configure_dma() function configures both the DMA masks and ops.
>> Moving DMA ops configuration to probe time would thus also delay
>> configuration of the DMA masks, which might not be safe. To avoid issues
>> split the configuration in two to allow keeping masks configuration at
>> device add time and move ops configuration to device probe time.
>
>Hi Sricharan, Laurent, everyone,
>
>I'm currently having a look at this series. Want to give it a spin
>with the IPMMU driver, however it takes a bit of time to wrap around
>my head on init ordering issues with both OF method and standard
>platform device setup on two different architectures...
>
>FWIW, here's some cosmetic feedback for this patch to begin with:
>
>In the patch title and commit message you probably want to do perform
>a s/of_configure_dma()/of_dma_configure()/g.
>
  Ya, that right.
 Thanks for having a look. I am going to post V2 shortly
  Infact on the next post, this split patch won't be there.

 Also, there is a bug in this series which missed before posting,
 https://patchwork.kernel.org/patch/9269913/


Regards,
 Sricharan
 

>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> ---
>>  drivers/of/device.c       | 48 ++++++++++++++++++++++++++++++++++-------------
>>  drivers/of/platform.c     |  6 ++++--
>>  drivers/pci/probe.c       |  3 ++-
>>  include/linux/of_device.h | 11 +++++++++--
>>  4 files changed, 50 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index 1c843e2..e1fad50 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -71,7 +71,7 @@ int of_device_add(struct platform_device *ofdev)
>>  }
>>
>>  /**
>> - * of_dma_configure - Setup DMA configuration
>> + * of_dma_configure - Setup DMA masks and offset
>>   * @dev:       Device to apply DMA configuration
>>   * @np:                Pointer to OF node having DMA configuration
>>   *
>
>The hunk above should be "of_dma_configure_masks" to make the
>documentation match the function name.
>
>> @@ -82,13 +82,11 @@ int of_device_add(struct platform_device *ofdev)
>>   * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
>>   * to fix up DMA configuration.
>>   */
>> -void of_dma_configure(struct device *dev, struct device_node *np)
>> +void of_dma_configure_masks(struct device *dev, struct device_node *np)
>>  {
>> -       u64 dma_addr, paddr, size;
>> -       int ret;
>> -       bool coherent;
>> +       u64 dma_addr, paddr, size, range_mask;
>>         unsigned long offset;
>> -       const struct iommu_ops *iommu;
>> +       int ret;
>>
>>         /*
>>          * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
>
>Thanks,
>
>/ magnus
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

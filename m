From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 23 Aug 2011 21:29:43 +0530
Subject: [PATCH 2/3] ARM: SAMSUNG: Modify pl330 channel filter function
In-Reply-To: <20110822215255.GB3895@n2100.arm.linux.org.uk>
References: <1314050385-9617-1-git-send-email-thomas.abraham@linaro.org>
	<1314050385-9617-2-git-send-email-thomas.abraham@linaro.org>
	<1314050385-9617-3-git-send-email-thomas.abraham@linaro.org>
	<20110822215255.GB3895@n2100.arm.linux.org.uk>
Message-ID: <CAJuYYwRL0LGA_TAQtfxAZhz4kYgvFnXfb=81s7ohH03dDTK8Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 23 August 2011 03:22, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Aug 23, 2011 at 03:29:44AM +0530, Thomas Abraham wrote:
>> With the change in dma channels private data information, the pl330
>> channel filter function is modified to look for a simple u8 value
>> instead of the now unused 'struct dma_pl330_peri' value.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?arch/arm/plat-samsung/dma-ops.c | ? ?4 ++--
>> ?1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
>> index 6e3d9ab..4f1430b 100644
>> --- a/arch/arm/plat-samsung/dma-ops.c
>> +++ b/arch/arm/plat-samsung/dma-ops.c
>> @@ -19,8 +19,8 @@
>>
>> ?static inline bool pl330_filter(struct dma_chan *chan, void *param)
>> ?{
>> - ? ? struct dma_pl330_peri *peri = chan->private;
>> - ? ? return peri->peri_id == (unsigned)param;
>> + ? ? u8 *peri_id = chan->private;
>> + ? ? return *peri_id == (unsigned)param;
>> ?}
>
> As a word of warning - this will fail horribly if you have mixed DMA
> engines in the system. ?While we wait for a better scheme, we really
> need to sort out these filter functions properly and stop poking
> about in data which may not be what we expect.
>
> One solution to that is to move pl330_filter() into drivers/dma/pl330.c
> and have it check chan->device->dev->driver == &pl330_driver.driver
> _before_ we start accessing chan->private.
>
> That's not a comment against your patch - you're not really changing
> the brokenness of this function. ?It would be good to see a follow up
> patch fixing it properly though.
>

Ok. I will prepare a patch to move the pl330_filter function into
drivers/dma/pl330.c and also add the check that you have proposed.

Thanks for your help.

Regards,
Thomas.

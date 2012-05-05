From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 5 May 2012 12:50:30 -0700
Subject: [PATCH] dma: pl330: assign a new cookie when restarting tx
 descriptors in cyclic mode
In-Reply-To: <1336103059.1593.28.camel@vkoul-udesk3>
References: <1336092630-20627-1-git-send-email-thomas.abraham@linaro.org>
 <1336103059.1593.28.camel@vkoul-udesk3>
Message-ID: <CAJuYYwRecbOgkegB4BcY_JUqtW9vW2FPk+Yz1YfkrRxyGxHVPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 May 2012 20:44, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Thu, 2012-05-03 at 17:50 -0700, Thomas Abraham wrote:
>> The cookie of completed transfer descriptors are marked as zero. In case of
>> cyclic transfers, a new cookie needs to be assigned to the transfer descriptors
>> which are picked up from the work_list list before they are re-enabled for
>> transfer. This prevents hitting BUG_ON in dma_cookie_complete function when
>> transfer descriptors are recycled from the work_list list.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?drivers/dma/pl330.c | ? ?1 +
>> ?1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>> index 2ee6e23..7f8f422 100644
>> --- a/drivers/dma/pl330.c
>> +++ b/drivers/dma/pl330.c
>> @@ -2265,6 +2265,7 @@ static inline void handle_cyclic_desc_list(struct list_head *list)
>> ? ? ? ? ? ? ? dma_async_tx_callback callback;
>>
>> ? ? ? ? ? ? ? /* Change status to reload it */
>> + ? ? ? ? ? ? dma_cookie_assign(&desc->txd);
>> ? ? ? ? ? ? ? desc->status = PREP;
>> ? ? ? ? ? ? ? pch = desc->pchan;
>> ? ? ? ? ? ? ? callback = desc->txd.callback;
> Nope, this doesn't seem correct to me for two reasons:
> 1. client doesnt know this new descriptor, so how will it keep track
> 2. What does marking cyclic descriptor complete mean... Nothing IMO
>
> So it is better *NOT* to mark the descriptor complete.
> And below is a better fix this for you, Please test.

Ok.

>
> ----------
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 2ee6e23..fa3fb21 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2322,7 +2322,8 @@ static void pl330_tasklet(unsigned long data)
> ? ? ? ?/* Pick up ripe tomatoes */
> ? ? ? ?list_for_each_entry_safe(desc, _dt, &pch->work_list, node)
> ? ? ? ? ? ? ? ?if (desc->status == DONE) {
> - ? ? ? ? ? ? ? ? ? ? ? dma_cookie_complete(&desc->txd);
> + ? ? ? ? ? ? ? ? ? ? ? if (pch->cyclic)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_cookie_complete(&desc->txd);
> ? ? ? ? ? ? ? ? ? ? ? ?list_move_tail(&desc->node, &list);
> ? ? ? ? ? ? ? ?}
>
>
> --
> ~Vinod
>

I have tested this patch. You can add:
Tested-by: Thomas Abraham <thomas.abraham@linaro.org>

Thanks,
Thomas.

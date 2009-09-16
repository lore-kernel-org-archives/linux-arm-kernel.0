From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 16 Sep 2009 09:46:53 +0900
Subject: [PATCH 6/7] S3C64XX DMA: dbg_showbuffs cleanup
In-Reply-To: <20090915234432.GC13508@trinity.fluff.org>
References: <1253008884-7657-1-git-send-email-jassi.brar@samsung.com>
	<20090915234432.GC13508@trinity.fluff.org>
Message-ID: <1b68c6790909151746o5a9c127cq114f6ad29122921c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 8:44 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Tue, Sep 15, 2009 at 07:01:24PM +0900, Jassi wrote:
>> Removed unused variable and cleaned up.
>>
>> Signed-Off-by: Jassi <jassi.brar@samsung.com>
>> ---
>> ?arch/arm/plat-s3c64xx/dma.c | ? 14 ++++----------
>> ?1 files changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
>> index e68469d..727072b 100644
>> --- a/arch/arm/plat-s3c64xx/dma.c
>> +++ b/arch/arm/plat-s3c64xx/dma.c
>> @@ -71,20 +71,14 @@ static void show_lli(struct pl080s_lli *lli)
>> ?static void dbg_showbuffs(struct s3c2410_dma_chan *chan)
>> ?{
>> ? ? ? struct s3c64xx_dma_buff *ptr;
>> - ? ? struct s3c64xx_dma_buff *end;
>
> you are right that the end is not used.
>
>> ? ? ? pr_debug("DMA%d: buffs next %p, curr %p, end %p\n",
>> ? ? ? ? ? ? ? ?chan->number, chan->next, chan->curr, chan->end);
>>
>> - ? ? ptr = chan->next;
>> - ? ? end = chan->end;
>> -
>> - ? ? if (debug_show_buffs) {
>> - ? ? ? ? ? ? for (; ptr != NULL; ptr = ptr->next) {
>> - ? ? ? ? ? ? ? ? ? ? pr_debug("DMA%d: %08x ",
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?chan->number, ptr->lli_dma);
>> - ? ? ? ? ? ? ? ? ? ? show_lli(ptr->lli);
>> - ? ? ? ? ? ? }
>> + ? ? for (ptr = chan->curr; debug_show_buffs && ptr != NULL; ptr = ptr->next) {
>
> this isn't a very nice change, for a start this means debug_show_buffs
> is going to end up being evaluated each loop and secondly these sort of
> changes do not help the code readability and can introduce bugs of their
> own.
yes and i knew the counter will be evaluated for every loop.
i wanted to keep the counter and not change much the code.

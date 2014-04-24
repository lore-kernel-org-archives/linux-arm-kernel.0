From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 24 Apr 2014 11:11:28 +0200
Subject: [PATCH 1/4] dma: ste_dma40: Maintain spinlock order while
 handling pause
In-Reply-To: <53582519.7020805@cogentembedded.com>
References: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
 <53582519.7020805@cogentembedded.com>
Message-ID: <CAPDyKFphEP93WhLpodfzH-QL4Rw5tGiXkkebWM+dbUcVnxaN+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 April 2014 22:39, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 04/23/2014 11:52 PM, Ulf Hansson wrote:
>
>> The runtime PM resume callback needs to be executed while holding the
>> spinlock, make sure to maintain this for the pause operation as well.
>
>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>   drivers/dma/ste_dma40.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>
>
>> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
>> index bf18c78..6e97cf6 100644
>> --- a/drivers/dma/ste_dma40.c
>> +++ b/drivers/dma/ste_dma40.c
>> @@ -1495,8 +1495,8 @@ static int d40_pause(struct d40_chan *d40c)
>>         if (!d40c->busy)
>>                 return 0;
>>
>> -       pm_runtime_get_sync(d40c->base->dev);
>>         spin_lock_irqsave(&d40c->lock, flags);
>> +       pm_runtime_get_sync(d40c->base->dev);
>
>
>   That function may sleep AFAIK, so you can't really call it with a spinlock
> held. Or do I miss something?

That's the default behaviour from the runtime PM core.

But, since we have invoked "pm_runtime_irq_safe()" at ->probe(), that
means the pm_runtime_get_sync() function won't sleep.

Kind regards
Ulf Hansson

>
> WBR, Sergei
>

From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Fri, 12 Dec 2014 12:58:25 -0500
Subject: [PATCH] Mailbox: Complete wait event only if Tx was successful
In-Reply-To: <CAJe_ZhcxQffJ16SczB9VRXoDMp7VMAR6fK8JrN=ogniv4tnfnA@mail.gmail.com>
References: <1418242572-20998-1-git-send-email-ashwin.chaugule@linaro.org>
 <CAJe_ZhcxQffJ16SczB9VRXoDMp7VMAR6fK8JrN=ogniv4tnfnA@mail.gmail.com>
Message-ID: <CAJ5Y-eY8KhM0=_XvTkcNEzCvQ=jxcsdTkg_e2=nPDkHoJpkPFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 December 2014 at 05:21, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 11 December 2014 at 01:46, Ashwin Chaugule
> <ashwin.chaugule@linaro.org> wrote:
>> If a wait_for_completion_timeout() call returns due to a timeout,
>> the mbox code can still call complete() after returning from the wait.
>> This can cause subsequent transmissions on a channel to fail, since
>> the wait_for_completion_timeout() sees the completion variable
>> is !=0, caused by the erroneous complete() call, and immediately
>> returns without waiting for the time as expected by the client.
>>
>> Fix this by calling complete() only if the TX was successful.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> ---
>>  drivers/mailbox/mailbox.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
>> index 17e9e4a..4acaddb 100644
>> --- a/drivers/mailbox/mailbox.c
>> +++ b/drivers/mailbox/mailbox.c
>> @@ -101,7 +101,7 @@ static void tx_tick(struct mbox_chan *chan, int r)
>>         if (mssg && chan->cl->tx_done)
>>                 chan->cl->tx_done(chan->cl, mssg, r);
>>
>> -       if (chan->cl->tx_block)
>> +       if ((!r) && chan->cl->tx_block)
>>                 complete(&chan->tx_complete);
>>
> Thanks for finding the bug.
> However the fix is flawed. complete() could also be done from
> mbox_chan_txdone() calling tx_tick(). And if the controller returned
> error, we could never pass on that error code to the user (timeout
> fires and then we will move on with -EIO).

If the controller returned error, wouldnt it be passed to the user via
chan->cl->tx_done()?
However, I agree that with this fix, it won't call complete(), when
the controller finished the Tx with an Err.

> Since we could never prevent the controller from returning -EIO as the
> error, I think we have to explicitly tell tx_tick() if it needs to
> complete() or not.

Hm. How about checking if the wait_for_completion_timeout() returned
the timeout value? If so, then return with -EIO and don't complete().

>
> -Jassi

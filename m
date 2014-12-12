From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 12 Dec 2014 14:13:01 +0530
Subject: [Linaro-acpi] [PATCH] Mailbox: Complete wait event only if Tx
 was successful
In-Reply-To: <1418242572-20998-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1418242572-20998-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <548AAA95.6020001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ashwin,

On Thursday 11 December 2014 01:46 AM, Ashwin Chaugule wrote:
> If a wait_for_completion_timeout() call returns due to a timeout,
> the mbox code can still call complete() after returning from the wait.
> This can cause subsequent transmissions on a channel to fail, since
> the wait_for_completion_timeout() sees the completion variable
> is !=0, caused by the erroneous complete() call, and immediately
> returns without waiting for the time as expected by the client.
>
> Fix this by calling complete() only if the TX was successful.
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>   drivers/mailbox/mailbox.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 17e9e4a..4acaddb 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -101,7 +101,7 @@ static void tx_tick(struct mbox_chan *chan, int r)
>   	if (mssg && chan->cl->tx_done)
>   		chan->cl->tx_done(chan->cl, mssg, r);
>
> -	if (chan->cl->tx_block)
> +	if ((!r) && chan->cl->tx_block)
>   		complete(&chan->tx_complete);

Just curious to check if there's another possible race which is
a different issue.

Suppose the timer fired and indicated that the Tx is complete, then
it tries to execute complete while the wait_for_completion_timeout timed
out. Does that make sense ?

So if yes, how about adding !completion_done(..) to the check while you
are at this ?

Regards,
Sudeep

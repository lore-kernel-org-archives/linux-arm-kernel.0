From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 12 Dec 2014 15:51:54 +0530
Subject: [PATCH] Mailbox: Complete wait event only if Tx was successful
In-Reply-To: <1418242572-20998-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1418242572-20998-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <CAJe_ZhcxQffJ16SczB9VRXoDMp7VMAR6fK8JrN=ogniv4tnfnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 December 2014 at 01:46, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
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
>  drivers/mailbox/mailbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 17e9e4a..4acaddb 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -101,7 +101,7 @@ static void tx_tick(struct mbox_chan *chan, int r)
>         if (mssg && chan->cl->tx_done)
>                 chan->cl->tx_done(chan->cl, mssg, r);
>
> -       if (chan->cl->tx_block)
> +       if ((!r) && chan->cl->tx_block)
>                 complete(&chan->tx_complete);
>
Thanks for finding the bug.
However the fix is flawed. complete() could also be done from
mbox_chan_txdone() calling tx_tick(). And if the controller returned
error, we could never pass on that error code to the user (timeout
fires and then we will move on with -EIO).
Since we could never prevent the controller from returning -EIO as the
error, I think we have to explicitly tell tx_tick() if it needs to
complete() or not.

-Jassi

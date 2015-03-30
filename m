From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 30 Mar 2015 22:17:17 +0530
Subject: [PATCH] dmaengine: pl330: fix the race condition in pl330 driver.
In-Reply-To: <1427414105-3480-1-git-send-email-sbranden@broadcom.com>
References: <1427414105-3480-1-git-send-email-sbranden@broadcom.com>
Message-ID: <CABb+yY3s8ZXWe3YAsEeKZ6Vx2av2yvdjWiBGiy7_uGCcai=Rpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 5:25 AM, Scott Branden <sbranden@broadcom.com> wrote:
> From: ismail <ismail@broadcom.com>
>
> Update the thread running index before issuing the
> GO command to the DMAC.
>
> Tested-by: Mohamed Ismail Abdul Packir Mohamed <ismail@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Arun Parameswaran <aparames@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Signed-off-by: Scott Branden <sbranden@broadcom.com>
> Signed-off-by: Mohamed Ismail Abdul Packir Mohamed <ismail@broadcom.com>
> ---
>  drivers/dma/pl330.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 0e1f567..631642d 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -1072,11 +1072,11 @@ static bool _trigger(struct pl330_thread *thrd)
>         /* Set to generate interrupts for SEV */
>         writel(readl(regs + INTEN) | (1 << thrd->ev), regs + INTEN);
>
> +       thrd->req_running = idx;
> +
>         /* Only manager can execute GO */
>         _execute_DBGINSN(thrd, insn, true);
>
> -       thrd->req_running = idx;
> -
It would help to know what the behavior looks like before and after
the patch. If anything we should look at locking rather the
reordering.

Thanks

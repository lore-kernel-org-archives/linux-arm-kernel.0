From: wangx@marvell.com (Xiang Wang)
Date: Tue, 20 Aug 2013 10:27:37 +0800
Subject: [PATCH v4 1/4] dma: mmp_pdma: only complete one transaction from
 dma_do_tasklet()
In-Reply-To: <1376672707-24527-2-git-send-email-zonque@gmail.com>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
 <1376672707-24527-2-git-send-email-zonque@gmail.com>
Message-ID: <5212D419.5030504@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2013 01:05 AM, Daniel Mack wrote:
> Currently, when an interrupt has occured for a channel, the tasklet
> worker code will only look at the very last entry in the running list
> and complete its cookie, and then dispose the entire running chain.
> Hence, the first transaction's cookie will never complete.
>
> In fact, the interrupt we should handle will be the one related to the
> first descriptor in the chain with the ENDIRQEN bit set, so complete
> the second transaction that is in fact still running.
>
> As a result, the driver can't currently handle multiple transactions on
> one chanel, and it's likely that no drivers exist that rely on this
> feature.
>
> Fix this by walking the running_chain and look for the first
> descriptor that has the interrupt-enable bit set. Only queue
> descriptors up to that point for completion handling, while leaving
> the rest intact. Also, only make the channel idle if the list is
> completely empty after such a cycle.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>   drivers/dma/mmp_pdma.c | 35 +++++++++++++++++++++--------------
>   1 file changed, 21 insertions(+), 14 deletions(-)
>

Hi, Daniel
I think we would not run into the situation that there is a descriptor 
with ENDIRQEN set in the middle of the running chain.

in mmp_pdma.c:
mmp_pdma_tx_submit() -> append_pending_queue() ->
tail->desc.dcmd &= ~DCMD_ENDIRQEN;

So in the pending list (same for running list), only the last descriptor 
will have ENDIRQEN set.

Please correct me if any problems.
-- 
Regards,
Xiang

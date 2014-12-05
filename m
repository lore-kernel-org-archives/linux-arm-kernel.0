From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 05 Dec 2014 14:38:59 +0100
Subject: [PATCH] dma: pl330: revert commit 04abf5daf7d
In-Reply-To: <1417785296-4435-1-git-send-email-jaswinder.singh@linaro.org>
References: <1417785296-4435-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <5481B573.8090902@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2014 02:14 PM, Jassi Brar wrote:
>  From Documentation/crypto/async-tx-api.txt
>    "... Once a driver-specific threshold is met the driver
> automatically issues pending operations.  An application can force
> this event by calling async_tx_issue_pending_all() ..."
>   That is, the DMA controller drivers may buffer transfer requests
> for optimization. However it is perfectly legal to start dma as soon
> as the user calls .tx_submit() on the descriptor, as the documentation
> specifies in include/linux/dmaengine.h

It's not according to what is in the DMAengine documentation 
(Documentation/dmaengine.txt) and what we have been telling people for the 
last couple of years.

There are supposed to be two different queues one for pending descriptors 
and one for active descriptors. submit() adds a descriptor to the pending 
list and issue_pending() moves all descriptors from the pending list to the 
active list. Especially the driver must not automatically start transferring 
a descriptor after it has been submitted but before issue_pending() has been 
called.

- Lars

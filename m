From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 11 Feb 2016 10:41:45 +0100
Subject: [PATCH v2] dmaengine: edma: Implement device_synchronize callback
In-Reply-To: <1455181722-32099-1-git-send-email-peter.ujfalusi@ti.com>
References: <1455181722-32099-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <56BC5759.80000@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2016 10:08 AM, Peter Ujfalusi wrote:
> We need the callback to support the dmaengine_terminate_sync().
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Looks good, but I noticed a slight race condition in
edma_completion_handler(). You need to fetch echan->desc while holding the
vchan.lock. Otherwise this can race against terminate_all() and the callback
might get scheduled even though terminate_all() completed and then there is
a race where the synchronize() operation could be called before the callback
gets scheduled, which means it doesn't do its intended job. Highly unlikely
to happen, but theoretically possible.

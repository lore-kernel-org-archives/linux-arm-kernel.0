From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 22 Aug 2013 14:36:53 -0600
Subject: [PATCH v2] DMA: add help function to check whether dma controller
 registered
In-Reply-To: <1377153781-18006-1-git-send-email-rizhao@nvidia.com>
References: <1375423458-6868-1-git-send-email-rizhao@nvidia.com>
 <1377153781-18006-1-git-send-email-rizhao@nvidia.com>
Message-ID: <52167665.90602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2013 12:43 AM, Richard Zhao wrote:
> DMA client device driver usually needs to know at probe time whether
> dma controller has been registered to deffer probe. So add a help
> function of_dma_check_controller.
> 
> DMA request channel functions can also used to check it, but they
> are usually called at open() time.

This new function is almost identical to the existing
of_dma_request_slave_channel(). Surely the code should be shared?

But that said, I don't see any need for a new function; why can't
drivers simply call of_dma_request_slave_channel() at probe time; from
what I can see, that function doesn't actually request the channel, but
rather simply looks it up, just like this one. The only difference is
that of_dma_xlate() is also called, but that's just doing some data
transformation, not actually recording channel ownership.

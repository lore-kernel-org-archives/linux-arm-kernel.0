From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 25 Jan 2017 14:12:38 +0100
Subject: [PATCH v7 2/4] dmaengine: Forward slave device pointer to
 of_xlate callback
In-Reply-To: <1485340088-25481-3-git-send-email-m.szyprowski@samsung.com>
References: <1485340088-25481-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125102824eucas1p1cf027184286131ff628eb7113c3f9e60@eucas1p1.samsung.com>
 <1485340088-25481-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <26397455-1237-2a66-acf8-215aacc7c9ce@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2017 11:28 AM, Marek Szyprowski wrote:
> Add pointer to slave device to of_dma_xlate to let DMA engine driver
> to know which slave device is using given DMA channel. This will be
> later used to implement non-irq-safe runtime PM for DMA engine driver.

of_dma_xlate() is used to translate from a OF phandle and a specifier to a
DMA channel. On one hand this does not necessarily mean that the channel is
actually going to be used by the slave that called the xlate function.
Modifying the driver state when a lookup of the channel is done is a
layering violation. And this approach is also missing a way to disassociate
a slave from a DMA channel, e.g. when it is no longer used.

On the other hand there are other mechanisms to translate between some kind
of firmware handle to a DMA channel which are completely ignored here.

So this approach does not work. This is something that needs to be done at
the dmaengine level, not a the firmware resource translation level. And it
needs a matching method that is called when the channel is disassociated
from a device, when the device no longer uses the DMA channel.

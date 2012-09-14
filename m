From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 14 Sep 2012 10:07:23 +0300
Subject: [PATCH v2 04/15] dmaengine: Pass no_wakeup parameter via
 device_prep_dma_cyclic() callback
In-Reply-To: <1347593040.1943.24.camel@vkoul-udesk3>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-5-git-send-email-peter.ujfalusi@ti.com>
 <1347593040.1943.24.camel@vkoul-udesk3>
Message-ID: <5052D7AB.1090804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2012 06:24 AM, Vinod Koul wrote:
> On Thu, 2012-09-13 at 16:37 +0300, Peter Ujfalusi wrote:
>> Change the parameter list of device_prep_dma_cyclic() so the DMA drivers
>> can receive the no_wakeup request coming from client drivers.
>> This feature can be used during audio operation to disable all audio
>> related interrupts.
> We already have a flag to indicate this, see 
> * @DMA_PREP_INTERRUPT - trigger an interrupt (callback) upon completion  of
> *  this transaction

I have also noticed this flag. It is not really a direct match for our case
since the notion of "completion of this transfer" is not applicable for cyclic
mode, but it is close enough.

> Unfortunately, the addition of cyclic API missed having this flag. So
> right way would be to add flag argument in the API.

I have not looked at the non cyclic APIs, but I think I can modify the
dmaengine_prep_dma_cyclic() to pass the flags instead of the 'bool no_wakeup'.
If the DMA_PREP_INTERRUPT is not set dma drivers can interpret it in a way
that they will disable all interrupts during cyclic mode.
None of the dma drivers in cyclic mode cares about the flags AFAIK or they can
just ignore this parameter for now (as they did with my no_wakeup parameter).
Will resend the series soon with this change.

-- 
P?ter

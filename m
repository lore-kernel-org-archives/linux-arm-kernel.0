From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 14 Sep 2012 14:20:30 +0530
Subject: [PATCH v2 03/15] dmaengine: Add no_wakeup parameter to
 dmaengine_prep_dma_cyclic()
In-Reply-To: <5052E72A.8040207@metafoo.de>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-4-git-send-email-peter.ujfalusi@ti.com>
 <5051FB4D.3000009@metafoo.de> <1347593217.1943.26.camel@vkoul-udesk3>
 <5052E72A.8040207@metafoo.de>
Message-ID: <1347612630.1943.29.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-14 at 10:13 +0200, Lars-Peter Clausen wrote:
> On 09/14/2012 05:26 AM, Vinod Koul wrote:
> > On Thu, 2012-09-13 at 17:27 +0200, Lars-Peter Clausen wrote:
> >> Hi,
> >>
> >> Hm... Do you think it would work as well if we implement this by
> >> setting the
> >> callback for the descriptor to NULL? If the callback is NULL there is
> >> nothing to at the end of a transfer/period and the dma engine driver
> >> may
> >> choose to disable interrupts. This would also benefit non cyclic
> >> transfers
> >> where the callback is NULL and we do not need add the new parameter to
> >> dmaengine_prep_dma_cyclic.
> > That will work too.... BUT the idea of no_wake mode in ALSA is that we
> > should not have any interrupts, so anything which is going to cause
> > interrupts to AP in undesired. The interrupts still happen and it just
> > that dmaengine driver is not notifying client.
> 
> Well, the idea was that the driver would disable interrupts if there is no
> callback to call, since there would be nothing to do in the interrupt
> handler anyway. But I guess the flags approach should work fine as well.
Yes we _could_ do that, but this relies on dmaengine driver to have this
implicit understanding. Anyone using dmaengine library in ASoC may or
may not be aware of this, so i would consider it hackish.

Using this flag explicitly makes everyone aware what the intended
behaviour is.

-- 
~Vinod

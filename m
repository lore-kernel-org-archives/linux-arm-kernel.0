From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 12 Sep 2012 15:53:47 +0300
Subject: [PATCH 11/11] ASoC: omap-pcm: Convert to use dmaengine
In-Reply-To: <20120912120028.GC28448@n2100.arm.linux.org.uk>
References: <1347450427-27627-1-git-send-email-peter.ujfalusi@ti.com>
 <1347450427-27627-12-git-send-email-peter.ujfalusi@ti.com>
 <20120912120028.GC28448@n2100.arm.linux.org.uk>
Message-ID: <505085DB.5000407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 03:00 PM, Russell King - ARM Linux wrote:
> On Wed, Sep 12, 2012 at 02:47:07PM +0300, Peter Ujfalusi wrote:
>> 2. Pause/Resume
>>    OMAP DMA engine backend does not support pausing and resuming
>>    an in-progress transfer.  It is unclear from the specs what
>>    effect clearing the enable bit has on the DMA position of a
>>    destination synchronized transfer, and whether the transfer
>>    can be restarted from the exact point that it was paused (or
>>    whether the data in the FIFO read from memory is simply
>>    discarded.)
> 
> It's worth noting that this comment (which was in my original patch)
> is there to spark _comment_ and _discussion_ and should not make its
> way into the final version of these patches.
> 
> Given that suspend/resume is important on OMAP platforms, it's something
> that needs to be resolved - in a way that complies with what ALSA expects.
> I do not believe that the way the existing drivers do this is compliant
> as the manuals imply that stopping memory->peripheral transfers results
> in data being discarded from the DMA's FIFOs.  As I understand it, ALSA
> requires no data to be discarded.
> 
> As we have no way to know how much data may be discarded from the DMA
> FIFO...

I need to look at this, but at first look we do wait for the drain in
omap_stop_dma(). We used to use omap_stop_dma/omap_start_dma for pause/resume
operations.
But sDMA also have a bit: CDPi: PAUSE_LINK_LIST which should do what we are
looking for.
Need to read the relevant parts of the TRM, but AFAIK we are using normal mode
with linked list (self linking).
I already have the patch for this, I just need to test it on HW.

-- 
P?ter

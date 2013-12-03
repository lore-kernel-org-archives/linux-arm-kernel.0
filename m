From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Dec 2013 10:52:09 -0700
Subject: [PATCH V2] dma: tegra: register as an OF DMA controller
In-Reply-To: <201311292208.26215.arnd@arndb.de>
References: <1385416416-3536-1-git-send-email-swarren@wwwdotorg.org>
 <2205346.2EJcydzRLA@wuerfel> <5293CF9F.6040305@wwwdotorg.org>
 <201311292208.26215.arnd@arndb.de>
Message-ID: <529E1A49.6050808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 02:08 PM, Arnd Bergmann wrote:
> On Monday 25 November 2013, Stephen Warren wrote:
>> Well, you suggested not using of_dma_simple_xlate() since it wasn't
>> appropriate. I then started to implement an open-coded xlate function,
>> but found that it was 99% identical to the same thing in the mmp driver,
>> and hence created a common of_dma_slave_xlate() so as not to just
>> cut/paste it everywhere. Unfortunately, I only sent that patch to
>> dmaengine at vger.kernel.org and the DMA maintainers, and there's no
>> archive of that list:-(
> 
> Ok, I see. However, I think the need for nontrivial code to be duplicated
> across drivers is not a sign that we are missing a generic xlate function
> and another indirection level, but rather that we got the interface
> for dma_get_slave_channel() wrong (yes, that would be my fault).
> 
> Can you try coming up with a different method to achieve the same
> where you use a different helper from the driver specific xlate
> function that does not require a callback?
> 
> I think dma_get_slave_channel is great if you have one channel per
> request line and you can directly look up the channel from the
> DT data, but it is not good if you have pick a channel and work
> around the race.

Hmm. Can you take a look at "[PATCH V4] dma: add
dma_get_any_slave_channel(), for use in of_xlate()" at the link below.
It still implements this via xlate, but I don't see any benefit in
making drivers use a different API to request slave channels based on
how the DMA controller works.

http://lkml.org/lkml/2013/11/26/408

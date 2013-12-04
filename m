From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Dec 2013 02:22:03 +0100
Subject: [PATCH V2] dma: tegra: register as an OF DMA controller
In-Reply-To: <529E1A49.6050808@wwwdotorg.org>
References: <1385416416-3536-1-git-send-email-swarren@wwwdotorg.org>
 <201311292208.26215.arnd@arndb.de> <529E1A49.6050808@wwwdotorg.org>
Message-ID: <201312040222.03604.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 December 2013, Stephen Warren wrote:
> On 11/29/2013 02:08 PM, Arnd Bergmann wrote:

> > Can you try coming up with a different method to achieve the same
> > where you use a different helper from the driver specific xlate
> > function that does not require a callback?
> > 
> > I think dma_get_slave_channel is great if you have one channel per
> > request line and you can directly look up the channel from the
> > DT data, but it is not good if you have pick a channel and work
> > around the race.
> 
> Hmm. Can you take a look at "[PATCH V4] dma: add
> dma_get_any_slave_channel(), for use in of_xlate()" at the link below.
> It still implements this via xlate, but I don't see any benefit in
> making drivers use a different API to request slave channels based on
> how the DMA controller works.
> 
> http://lkml.org/lkml/2013/11/26/408
> 

Yes, I think that is good. I can think of a few variations of that
that I would prefer slightly over your code, but it's essentially
what I had in mind and I'm fine with that version getting merged
as well. Here are my ideas for further improvements, I'll leave
it up to you and the dmaengine maintainers to decide what to do
about them:

* Rather than calling private_candidate(), open-code the part you
  need and remove the pointless dma_cap_mask comparison:

	err = -EBUSY;
        list_for_each_entry(chan, &dev->channels, device_node) {
                if (!chan->client_count) {
			err = dma_chan_get(chan);
			break;
		}
	}

* Merge the new function with dma_get_slave_channel(). They really
  do different things, but I think it still makes sense as an API
  to require to always pass the dma_device pointer, and drivers
  that want to get an arbitrary channel can just pass NULL as the
  channel pointer.

	Arnd

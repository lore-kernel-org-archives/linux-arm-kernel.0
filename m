From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 Jul 2014 11:46:54 -0500
Subject: [PATCH 4/5] tty: serial: 8250 core: add runtime pm
In-Reply-To: <53C6AAE1.7090802@linutronix.de>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
 <1405521903-5877-5-git-send-email-bigeasy@linutronix.de>
 <20140716151604.GG1365@saruman.home>
 <53C6A050.2050409@linutronix.de>
 <20140716160614.GI1365@saruman.home>
 <53C6AAE1.7090802@linutronix.de>
Message-ID: <20140716164654.GC3016@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 06:40:01PM +0200, Sebastian Andrzej Siewior wrote:
> On 07/16/2014 06:06 PM, Felipe Balbi wrote:
> 
> >>> well, other than in probe and other functions which need to
> >>> make sure clocks are on, but it seems unnecessary to
> >>> enable/disable in every function.
> >> 
> >> What do you have in mind? Do you plan to let the uart on while
> >> the minicom is attached but is doing nothing? In that case,
> >> ->startup() and ->shutdown() should be enough.
> > 
> > no the idea was to keep it on for as long as it's transferring 
> > characters and idle it otherwise, if that can't be done easily,
> > then I guess your way is the only way.
> 
> But maybe we have to add some additional logic here to keep it up for
> the transfer. I've been just (maybe over)thinking: If you send 300
> bytes over DMA via 300 baud it should take 10 seconds. The PM-timeout
> could hit before the transfer is complete.

hmm, good point. So we _do_ need a way to get early and only put after
we know transfer has completed and I was assuming stop_tx() to be that
hint, but apparently it isn't.

> Same thing with hw-flowcontrol where you could get stalled for a few
> seconds.
> However it doesn't seem to be a problem in current omap-serial driver.

I don't think current omap-serial driver is a great example.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/7ee27622/attachment.sig>

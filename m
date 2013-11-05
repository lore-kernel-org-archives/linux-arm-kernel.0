From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 5 Nov 2013 11:03:14 -0700
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <201311050939.21071.arnd@arndb.de>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <1704730.RnIqE1USnv@wuerfel>
 <20131104212930.GB9638@obsidianresearch.com>
 <201311050939.21071.arnd@arndb.de>
Message-ID: <20131105180314.GB14706@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 09:39:20AM +0100, Arnd Bergmann wrote:

> I was aware of this for the interrupts, my plan for this was to either
> leave the interrupt disabled when requesting it and leave it up to the
> probe function to call enable_irq(), or to have the irq request function
> last in the list, and preceded by a custom per-driver callback. AFAIK
> this is only required for some drivers anyway, while other drivers
> would function just fine when the irq is enabled early, because they
> never raise an IRQ without first having something touch their registers.
> Another option would be to have a flag in the driver data that lets
> the irq handler know it should ignore the interrupt (or disable the source)
> if the probe function has not completed yet.

Requiring enable_irq() would be symmetric with the DMA channels at
least.

I would not assume that most drivers don't need this - anything but
the simplest cases have a problem. Eg even a simple RTC driver
could have the driver attach while the RTC is configured to generate
an alarm IRQ. An I2C driver could attach while the HW is executing an
I2C transaction, etc.

The mistake in drivers is assuming that the device is already
quiescent at probe..

I like the idea of having a DEVM_QUIESCE_DEVICE(foo_reset)
action. That at least documents the need, and makes it clearer to
reviewers.

> I think we can handle the first case by adding a per-subsystem DEV_ALLOC
> variant. For the second case, I don't see a solution other than than
> changing the subsystem not to steal the driver_data pointer. I need
> to find out how common this case is. If a lot of subsystems do it,
> we probably want a different solution.

I've been brewing a patch set to fix TPM, but it is a large effort. I
would think other legacy subsystems that are not fully class device
enabled will have similar challenges?

How about an alternate entry point:

 net = alloc_etherdev(sizeof(foo_priv));
 priv = netdev_priv(net);
 devm_probe_priv(priv, probes);

Don't touch the drvdata for that flow.

Regards,
Jason

From: mgrosen@ti.com (Grosen, Mark)
Date: Mon, 27 Jun 2011 23:54:30 +0000
Subject: [RFC 1/8] drivers: add generic remoteproc framework
In-Reply-To: <20110627222401.GE20865@ponder.secretlab.ca>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-2-git-send-email-ohad@wizery.com>
	<20110627204958.GB20865@ponder.secretlab.ca>
	<FFF198FBBF957F4393BA834040FEFFA202EE00@DFLE35.ent.ti.com>
	<20110627222401.GE20865@ponder.secretlab.ca>
Message-ID: <FFF198FBBF957F4393BA834040FEFFA202EF28@DFLE35.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Grant Likely
> Sent: Monday, June 27, 2011 3:24 PM

> > Our AMPs (remote processors) have a variety of boot mechanisms that vary
> > across the different SoCs (yes, TI likes HW diversity). In some cases, the
> > boot address is more like an entry point and that comes from the firmware,
> > so it is not a static attribute of a driver. Correct me if I misunderstood
> > your question.
> 
> More to the point, I would expect the boot_address to be a property of
> the rproc instance because it represents the configuration of the
> remote processor.  It seems odd that the caller of ->start would know
> better than the rproc driver about the entry point of the processor.
> 
> g.

Yes, in many cases the boot_address will be defined by the HW. However, we have
processors that are "soft" - the boot_address comes from the particular firmware
being loaded and can (will) be different with each firmware image. We factored
out the firmware loader to be device-independent (in remoteproc.c) so it's not
repeated in each device-specific implementation like omap_remoteproc.c and
davinci_remoteproc.c. In the cases where the HW dictates what happens, the start()
method should just ignore the boot_address.

Mark

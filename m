From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 7 May 2013 11:20:42 -0400 (EDT)
Subject: [RFC PATCH v2] drivers: bus: add ARM CCI support
In-Reply-To: <20130507134943.GB19477@e102568-lin.cambridge.arm.com>
References: <1367425108-4698-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1367425108-4698-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.03.1305011239240.11070@syhkavp.arg>
 <20130507134943.GB19477@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1305071113310.13109@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 May 2013, Lorenzo Pieralisi wrote:

> On Mon, May 06, 2013 at 04:05:28PM +0100, Nicolas Pitre wrote:
> > When compiled in, module_init() is translated into device_initcall().
> > This is way too late for bringing up secondary CPUs during boot via the
> > MCPM layer.  That is not an issue as far as the code presented here is
> > concerned since there is no integration with MCPM yet, but eventually
> > we'd want the MCPM power_up_setup method to integrate with the port
> > discovery performed here instead of having them hardcoded in the
> > assembly code.  This means it would have to become early_initcall()
> > instead.  And at that point the driver infrastructure isn't fully
> > operational, meaning that driver_probe() won't be usable either (looking
> > at what we did to the TC2 spc init code is a good example of what I mean
> > here).
> 
> Yes, I thought about that. This means that CCI driver should not rely on
> platform device structs, and yes I can mirror SPC probing code to take care
> of ordering issues. I am quite tempted to remove the platform device/driver
> infrastructure altogether and just rely on the DT layer (as GIC, PL310
> do) to initialize CCI. What do you think ?

I think that's probably the best approach.  That's what we ended up 
doing to the spc code for the same reasons.

> I think I will leave the
> platform driver infrastructure, and at probe it will check if data
> structures have already been initialized by an exported function, say:
> 
> cci_of_init()

Please let's try to avoid propagating the "of" acronym further.  We 
don't use Open Firmware here.  Using "dt" is more appropriate IMHO.

> if the data structures are already initialized basically the probe
> function will do precious little and just succeeds otherwise it will
> initialize the driver as it does now.
> 
> Is there really a point in having the CCI driver represented as a
> platform driver ? Not sure at all.

I'm not sure either.


Nicolas

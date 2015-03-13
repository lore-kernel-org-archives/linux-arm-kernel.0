From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 16:08:31 +0100
Subject: [PATCH 5/9] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <20150313124748.GI8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <65456683.XbdNkPUDTs@wuerfel> <20150313124748.GI8656@n2100.arm.linux.org.uk>
Message-ID: <2439386.JhP59gsGzr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 March 2015 12:47:48 Russell King - ARM Linux wrote:
> On Fri, Mar 13, 2015 at 01:42:35PM +0100, Arnd Bergmann wrote:
> > On Friday 13 March 2015 12:29:44 Russell King - ARM Linux wrote:
> > > The hardware requires a specific sequence of register writes for the
> > > PM domain code, which includes the reset register.
> > > 
> > > The problem is that if we were to use the reset API directly from the
> > > PM domain code, we would have to separate the locks for the reset code
> > > from the PM domain code.  That then leads to there being a race between
> > > the reset code potentially being able to write to the reset register in
> > > the middle of a PM domain sequence.
> > 
> > I see. I may be missing something here, but I think you could still
> > use of_reset_controller_get() once the reset controller is enabled
> > and then manually access the register from the PM domain code while
> > holding the pmu lock. You wouldn't be able to use device_reset()
> > or similar as you explain, but you could avoid parsing the DT manually.
> 
> What about the case when CONFIG_RESET_CONTROLLER is disabled?  In that
> case, I would then need to manually parse this anyway.

I think the easiest and cleanest way would be to let that case not
happen. Adding the reset controller core makes the kernel about 2kb
larger, but in most multiplatform configurations, you get it already.

	Arnd

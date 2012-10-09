From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 10 Oct 2012 00:18:48 +0200
Subject: pm: add suspend_mem and suspend_standby support
In-Reply-To: <20121009155241.GQ12801@game.jcrosoft.org>
References: <20121009151704.GP12801@game.jcrosoft.org>
 <Pine.LNX.4.44L0.1210091141270.1441-100000@iolanthe.rowland.org>
 <20121009155241.GQ12801@game.jcrosoft.org>
Message-ID: <3395599.MgZOPkqiWY@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 of October 2012 17:52:41 Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:44 Tue 09 Oct     , Alan Stern wrote:
> > On Tue, 9 Oct 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > 
> > > > Why do you need to know the difference in your driver?  We used to
> > > > provide this information a long time ago, but it turned out to not be
> > > > needed at all and just caused problems.
> > > because on at91 I need to handle the mem standby at drviers level.
> > > 
> > > We do it today already by a hack in different drivers at91_udc (usb device),
> > > atmel_serail and at91_ohci. Those 3 IP have specifci handling when switching
> > > to mem pm. On at91 when switch to mem we shutdown everything and run form a slow
> > > clock - this is done at soc level - but those IP have issue and need specific
> > > care before doing so. Ohterwise when the SoC will wakeup but those IP will not
> > > 
> > > in this patch series I send the update of those 3 drivers too
> > > and kill the hack
> > 
> > How about adding a platform-specific callback routine to tell drivers 
> > whether or not they will run from the slow clock?  Something like:
> > 
> > 	bool at91_suspend_will_use_slow_clock(void);
> > 
> > That would not involve making any changes to the driver core, and your 
> > three drivers could still get the information they need.
> I already do so and I want to drop it as the IP is shared with multiple ARCH
> and I want to have a clean code no hack

So, what about actually adding a platform layer to your PM instead of doing
all PM in device drivers?

ACPI has exactly the same problem that you have, but it's never has to tell
device drivers what system sleep state is going to be entered.  Drivers just
call acpi_pm_device_sleep_state() and that tells them what power state to
put the device into (which depends on the sleep state being entered, but
drivers really don't need to know that state).

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

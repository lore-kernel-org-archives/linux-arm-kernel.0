From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 9 Oct 2012 11:44:40 -0400 (EDT)
Subject: pm: add suspend_mem and suspend_standby support
In-Reply-To: <20121009151704.GP12801@game.jcrosoft.org>
Message-ID: <Pine.LNX.4.44L0.1210091141270.1441-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Oct 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:

> > Why do you need to know the difference in your driver?  We used to
> > provide this information a long time ago, but it turned out to not be
> > needed at all and just caused problems.
> because on at91 I need to handle the mem standby at drviers level.
> 
> We do it today already by a hack in different drivers at91_udc (usb device),
> atmel_serail and at91_ohci. Those 3 IP have specifci handling when switching
> to mem pm. On at91 when switch to mem we shutdown everything and run form a slow
> clock - this is done at soc level - but those IP have issue and need specific
> care before doing so. Ohterwise when the SoC will wakeup but those IP will not
> 
> in this patch series I send the update of those 3 drivers too
> and kill the hack

How about adding a platform-specific callback routine to tell drivers 
whether or not they will run from the slow clock?  Something like:

	bool at91_suspend_will_use_slow_clock(void);

That would not involve making any changes to the driver core, and your 
three drivers could still get the information they need.

Alan Stern

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 13:14:08 +0000
Subject: [PATCH 02/02] mach-shmobile: KZM9D board prototype support
In-Reply-To: <20120503144703.6390.20689.sendpatchset@w520>
References: <20120503144645.6390.62303.sendpatchset@w520>
 <20120503144703.6390.20689.sendpatchset@w520>
Message-ID: <201205041314.08701.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 May 2012, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add experimental KZM9D board support that makes
> use of the Emma Mobile EV2 SoC code.
> 
> Nothing except serial ports and timer are supported
> at this point. On-board ethernet support can be
> added after proper GPIO bindings are implemented.
> Without GPIO we cannot make use of external IRQs.
> 
> Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>

Given that this doesn't do anything, I see no reason to leave this
machine based on ATAG rather than DT probing:

+MACHINE_START(KZM9D, "kzm9d")
+       .map_io         = emev2_map_io,
+       .init_early     = emev2_add_early_devices,
+       .nr_irqs        = NR_IRQS_LEGACY,
+       .init_irq       = emev2_init_irq,
+       .handle_irq     = gic_handle_irq,
+       .init_machine   = emev2_add_standard_devices,
+       .timer          = &shmobile_timer,
+MACHINE_END

Just make this DT_MACHINE_START and add a minimal .dts file for
it that has the right compatible value. That will already enable
people to add devices in their .dts files without touching
the platform code.

It would also be really easy to just add DT support for the three
devices you actually support (GIC, STI, uart), because two of
them already have bindings and the third one is a new driver.
When we discussed this new soc earlier, you said that using DT
based booting would be extra work, but given the set of devices
that you are putting into this, I don't think that argument holds
any more.

	Arnd

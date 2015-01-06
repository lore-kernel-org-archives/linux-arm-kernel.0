From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Jan 2015 14:13:59 +0100
Subject: [PATCH] serial: 8250: Make ISA ports optional
In-Reply-To: <1420513785-23660-1-git-send-email-peter@hurleysoftware.com>
References: <1420513785-23660-1-git-send-email-peter@hurleysoftware.com>
Message-ID: <9492211.AECobr3jIN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 January 2015 22:09:45 Peter Hurley wrote:
> Some arches have no need to create unprobed 8250 ports; these phantom
> ports are primarily required for ISA ports which have no probe
> mechanism or to provide non-operational ports for userspace to
> configure (via TIOCSSERIAL and TIOCSERCONFIG ioctls).
> 
> Provide CONFIG_SERIAL_8250_PHANTOM_UARTS knob to disable phantom port
> registration; ie., CONFIG_SERIAL_8250_PHANTOM_UARTS=N only registers
> probed ports (ACPI/PNP, "serial8250" platform devices, PCI, etc).
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

The intent is definitely right, but I think a better approach is
possible.

I haven't tried it here, but how about moving the serial8250_init
function into a separate module, along with all the other parts
that are only used for ISA devices, but leaving the actual core
(all exported symbols) in this file?

At the same time, the serial8250_pnp_init/serial8250_pnp_exit calls
can be removed from the serial8250_init function and become
standalone initcalls.

	Arnd

From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 06 Jan 2015 09:32:02 -0500
Subject: [PATCH] serial: 8250: Make ISA ports optional
In-Reply-To: <9492211.AECobr3jIN@wuerfel>
References: <1420513785-23660-1-git-send-email-peter@hurleysoftware.com>
 <9492211.AECobr3jIN@wuerfel>
Message-ID: <54ABF1E2.1010905@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2015 08:13 AM, Arnd Bergmann wrote:
> On Monday 05 January 2015 22:09:45 Peter Hurley wrote:
>> Some arches have no need to create unprobed 8250 ports; these phantom
>> ports are primarily required for ISA ports which have no probe
>> mechanism or to provide non-operational ports for userspace to
>> configure (via TIOCSSERIAL and TIOCSERCONFIG ioctls).
>>
>> Provide CONFIG_SERIAL_8250_PHANTOM_UARTS knob to disable phantom port
>> registration; ie., CONFIG_SERIAL_8250_PHANTOM_UARTS=N only registers
>> probed ports (ACPI/PNP, "serial8250" platform devices, PCI, etc).
>>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> 
> The intent is definitely right, but I think a better approach is
> possible.
> 
> I haven't tried it here, but how about moving the serial8250_init
> function into a separate module, along with all the other parts
> that are only used for ISA devices, but leaving the actual core
> (all exported symbols) in this file?

Unfortunately, I don't see a way to remove the stacked initialization
without risking tons of breakage.

Since later probes can "find" an already-existing port and
re-initialize it, the probe order is crucial. For example, a PCI
probe can "find" an existing "serial8250" platform device port,
resulting in only one device node.

And the configuration knob will be required on all arches anyway because
that's how user-configurable device nodes are created.

> At the same time, the serial8250_pnp_init/serial8250_pnp_exit calls
> can be removed from the serial8250_init function and become
> standalone initcalls.

PNP probe must occur before the phantom ports are registered.
See commit 835d844d1a28efba81d5aca7385e24c29d3a6db2
("8250_pnp: do pnp probe before legacy probe").

Regards,
Peter Hurley

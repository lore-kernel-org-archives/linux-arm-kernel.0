From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Dec 2013 15:01:26 +0100
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <20131219113051.GL2736@xora-haswell.xora.org.uk>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <20131217112914.GB32118@arm.com>
 <20131219113051.GL2736@xora-haswell.xora.org.uk>
Message-ID: <201312191501.26362.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 December 2013, Graeme Gregory wrote:
> Hopefully the documenation of what real armv8 server architecture will look
> like will come in the new year. Things like regulators and clocks I do not
> have answers to yet as obviously in Intel world these things are hidden
> from view, I do not know what the plan is for armv8 silicon/motherboards.

The clocks and regulators (and a handful of other subsystems) are
the key thing to work out IMHO. For all I know these are either completely
static (turned on by firmware at boot time) on current servers, or they
are done in a way that each device can manage itself using power states
in the PCI configuration space. If you have on-chip devices that do not
look like PCI devices to software, or that interact with other on-chip
controllers at run-time as on typical arm32 embedded SoCs, you are in
trouble to start with, and there are two possible ways to deal with this
in theory:

a) Hide all the register-level setup behind AML code and make Linux only
   aware of the possible device states that it can ask for, which would
   make this look similar to today's servers.

b) Model all the soc-internal registers as devices and write OS-specific
   SoC-specific device drivers for them, using yet-to-be-defined ACPI
   extensions to describe the interactions between devices. This would
   be modeled along the lines of what we do today with DT, and what Intel
   wants to do on their embedded SoCs with ACPI in the future.

I think anybody would agree that we should not try to mix the two models
in a single system, as that would create an endless source of bugs when
you have two drivers fighting over the same hardware. There is also a
rough consensus that we really only want a) and not b) on ARM, but there
have been indications that people are already working on b), which I
think is a bit worrying. I would argue that anyone who wants b) on 
ARM should not use ACPI at all but rather describe the hardware using
DT as we do today. This could possibly change if someone shows that a)
is actually not a realistic model at all, but I also think that doing b)
properly will depend on doing a major ACPI-6.0 or ACPI-7.0 release
to actually specify a standard model for the extra subsystems.

> On the multiple venders same hardware issue I guess Intel guys must have
> already seen this happen. We shall have to ask them what their solution was?

There is basically only one SoC vendor on x86, which makes this a lot
easier. Off-chip devices on the board are typically PCI based and
don't need any special treatment because the PCI vendor/device ID
pair is enought to identify the hardware. Anything that does not fall
into these categories (e.g. vendor specific laptop extensions) is
handled with drivers in drivers/platform/x86/. This works fine
because that code is only needed for _optional_ features such as
multimedia buttons or sensors, and the total amount of code for
all the platforms is fairly contained.

The main concern for ARM is that if we need to do the same, it ends up
as a direct replacement for the "board files" that we just spent years
on making obsolete. We can do this as a workaround for the oddball broken
firmware in shipping products, but we should not go back to having to
add platform-specific code that is only meant to interface with how
a random vendor decided to expose standard hardware in their ACPI BIOS.

	Arnd

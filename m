From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Mar 2016 15:37:48 +0000
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <56EAC40F.1080504@codeaurora.org>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <20160316100759.GA18387@arm.com> <56E95A4E.4050709@codeaurora.org>
 <20160316141802.GC13423@e104818-lin.cambridge.arm.com>
 <56E97B10.4050401@codeaurora.org>
 <20160317142716.GC11623@e104818-lin.cambridge.arm.com>
 <56EAC40F.1080504@codeaurora.org>
Message-ID: <20160317153747.GD11623@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 09:49:51AM -0500, Timur Tabi wrote:
> Catalin Marinas wrote:
> >>>Yes, that's exactly it.  Ours is an ACPI system, and so we have to have our
> >>>own defconfig for now.  We're holding off on pushing our own defconfig
> >>>changes (enabling drivers, etc) until ACPI is enabled in
> >>>arch/arm64/configs/defconfig.
> 
> >Is there anything that prevents you from providing a dtb/dts for this
> >SoC?
> 
> We don't have a boot loader capable of passing a device tree to the kernel.
> It's an ARM Server chip.  It doesn't do device tree.  It's 100% ACPI.  We
> boot with UEFI that configures the system and generates ACPI tables.

Well, I disagree with the idea that server == ACPI. But I guess you knew
this already.

> I just want to make this crystal clear, because it comes up every now and
> then.  The QDF2432 is an ACPI-only SOC with no device tree support
> whatsoever.  Zero.  Zip.  Nada.  It's not an option.

That's your choice really, I don't care much (as long as current ACPI
support has all the features you need; if it doesn't, there is a good
chance that your SoC won't be supported in mainline until it's sorted).

> Keep in mind that on an ACPI system like ours, the boot loader (UEFI in our
> case) configures the system extensively.  It does a lot of things that the
> kernel would normally do on a device tree system.  For example, pin control
> is handled completely by UEFI.  The kernel does not set the pin muxes or
> GPIO directions.  That means we don't support dynamic pin muxing.  Before
> the kernel is booted, the GPIO pins are fixed.

And that's great. But you are mistaken in thinking that DT requires lots
of drivers in the kernel and prevents the firmware from doing sane
stuff. DT rather gained additional features out of necessity since the
firmware was not always doing a proper job at hardware initialisation.
A DT-enabled kernel does not impose restrictions on such firmware
features. With ACPI, the choice is not as wide and forces vendors to
look into their firmware story from a different angle (until they figure
the _DSD+PRP0001 out and we end up with DT emulated in ACPI).

If the GPIO pins are fixed at boot-time, they don't even need to be
described in the DT, just let the firmware configure them. However, if
they need to be changed at run-time (which does not seem to be your
case), that's where you have a choice of either kernel driver (DT) or
AML code (ACPI) (or both). Otherwise, without this run-time aspect, both
DT and ACPI are just slightly different ways to provide a static
platform description.

> We're not going to create an entire device tree from scratch for this chip,
> and then make the extensive modifications necessary to our boot loader for
> parsing and modifying that device tree.  That would take months of work, and
> it would be all throw-away code.

As I said above, that's your choice and it depends on your timeline and
mainline support requirements. I however disagree with this being
"throw-away code" (or even taking "months of work").

-- 
Catalin

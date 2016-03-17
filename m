From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 17 Mar 2016 09:49:51 -0500
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <20160317142716.GC11623@e104818-lin.cambridge.arm.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <20160316100759.GA18387@arm.com> <56E95A4E.4050709@codeaurora.org>
 <20160316141802.GC13423@e104818-lin.cambridge.arm.com>
 <56E97B10.4050401@codeaurora.org>
 <20160317142716.GC11623@e104818-lin.cambridge.arm.com>
Message-ID: <56EAC40F.1080504@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
>> >Yes, that's exactly it.  Ours is an ACPI system, and so we have to have our
>> >own defconfig for now.  We're holding off on pushing our own defconfig
>> >changes (enabling drivers, etc) until ACPI is enabled in
>> >arch/arm64/configs/defconfig.

> Is there anything that prevents you from providing a dtb/dts for this
> SoC?

We don't have a boot loader capable of passing a device tree to the 
kernel.  It's an ARM Server chip.  It doesn't do device tree.  It's 100% 
ACPI.  We boot with UEFI that configures the system and generates ACPI 
tables.

I just want to make this crystal clear, because it comes up every now 
and then.  The QDF2432 is an ACPI-only SOC with no device tree support 
whatsoever.  Zero.  Zip.  Nada.  It's not an option.

Keep in mind that on an ACPI system like ours, the boot loader (UEFI in 
our case) configures the system extensively.  It does a lot of things 
that the kernel would normally do on a device tree system.  For example, 
pin control is handled completely by UEFI.  The kernel does not set the 
pin muxes or GPIO directions.  That means we don't support dynamic pin 
muxing.  Before the kernel is booted, the GPIO pins are fixed.

We're not going to create an entire device tree from scratch for this 
chip, and then make the extensive modifications necessary to our boot 
loader for parsing and modifying that device tree.  That would take 
months of work, and it would be all throw-away code.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.

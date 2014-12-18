From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 18 Dec 2014 14:04:02 -0600
Subject: [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
Message-ID: <CAOZdJXWaQk+f6MLngDzdmUU8x=4cPrt9kpJG6L529MhV0uQwdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 17, 2014 at 8:37 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:

> If acpi=force is used, the kernel
> +will ONLY use device configuration information contained in the ACPI tables.

Based on this statement, ...

> +In order for the kernel to load and use ACPI tables, the UEFI implementation
> +MUST set the ACPI_20_TABLE_GUID to point to the RSDP table (the table with
> +the ACPI signature "RSD PTR ").  If this pointer is incorrect and acpi=force
> +is used, the kernel will disable ACPI and try to use DT to boot.

wouldn't it be more correct to say "If this pointer is incorrect OR
acpi=force is used"?

> +Forum provides a mechanism for registering such bindings [URL TBD by ASWG]

Did you intend to replace the text in []?

> +so that they may be used on any operating system supporting ACPI.  Device
> +properties that have not been registered with the UEFI Forum should not be
> +used.

Blech.  I guess it's necessary, but the information needs to be documented here.

> +Drivers should look for device properties in the _DSD object ONLY; the _DSD
> +object is described in the ACPI specification section 6.2.5, but more
> +specifically, use the _DSD Device Properties UUID:
> +
> +   -- UUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301
> +
> +   -- http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf)

Extra ) here.

> +The kernel has an interface for looking up device properties in a manner
> +independent of whether DT or ACPI is being used and that interface should
> +be used; it can eliminate some duplication of code paths in driver probing
> +functions and discourage divergence between DT bindings and ACPI device
> +properties.

How about a pointer to the documentation for this method?

> +Such code in _PS? methods will of course be very platform specific.  But,

I would use _PSx instead of _PS? here.

> +this allows the driver to abstract out the interface for operating the device
> +and avoid having to read special non-standard values from ACPI tables. Further,
> +abstracting the use of these resources allows the hardware to change over time
> +without requiring updates to the driver.
> +
> +
> +Clocks
> +------
> +ACPI makes the assumption that clocks are initialized by the firmware --
> +UEFI, in this case -- to some working value before control is handed over
> +to the kernel.  This has implications for devices such as UARTs, or SoC
> +driven LCD displays, for example.

SOC-driven should be hyphenated.

> +When the kernel boots, the clock is assumed to be set to reasonable

to A reasonable

> +working value.  If for some reason the frequency needs to change -- e.g.,
> +throttling for power management -- the device driver should expect that
> +process to be abstracted out into some ACPI method that can be invoked
> +(please see the ACPI specification for further recommendations on standard
> +methods to be expected).  If is not, there is no direct way for ACPI to

If IT is not

> +control the clocks.
> +
> +
> +Driver Recommendations
> +----------------------
> +DO NOT remove any DT handling when adding ACPI support for a driver.  The
> +same device may be used on many different systems.
> +
> +DO try to structure the driver so that it is data driven.  That is, set up

data-driven


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

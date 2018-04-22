From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sun, 22 Apr 2018 11:27:10 +0200
Subject: [PATCH] ACPI / bus: ignore rather than fail bus driver
 registrations on non-ACPI boot
In-Reply-To: <20180419165825.13008-1-ard.biesheuvel@linaro.org>
References: <20180419165825.13008-1-ard.biesheuvel@linaro.org>
Message-ID: <CAJZ5v0jE4Ler2OWeKEWuHwEwM4RHYC5r8BwgcPrT6XBxFjnSNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 6:58 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> When building ACPI bus drivers such as button.ko into the core kernel,
> other drivers that depend on its symbols are loadable even when booting
> with ACPI disabled. For instance, nouveau.ko has a link time dependency
> on acpi_lid_open() on ACPI capable kernels, and calls it regardless of
> whether the system booted via ACPI.
>
> However, when building button.ko as a module, it will refuse to load if
> the system did not boot in ACPI mode, which subsequently prevents the
> nouveau driver from loading as well, resulting in broken graphics.
>
> Given that returning an error from an initcall() is ignored for drivers
> that are built into the kernel,

Which makes sense, because they are present in the kernel anyway.

> let's align the module case with this,
> and not return an error when registering an ACPI bus driver on a system
> that did not boot via ACPI.

But why is loading a module that's never going to be used actually OK?

Isn't this a problem with the assumptions made by the nouveau driver
that need not be met depending on what configuration the kernel is run
in?

Honestly, it doesn't appear quite right to try to change the rest of
the kernel to follow the nouveau's expectations.

Thanks,
Rafael

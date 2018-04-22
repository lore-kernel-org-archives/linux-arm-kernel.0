From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 22 Apr 2018 14:34:17 +0200
Subject: [PATCH] ACPI / bus: ignore rather than fail bus driver
 registrations on non-ACPI boot
In-Reply-To: <CAKv+Gu8xY-RvJKTKfv-e0qonL4oECDBK+ppxztvh9BgdpG8CUg@mail.gmail.com>
References: <20180419165825.13008-1-ard.biesheuvel@linaro.org>
 <CAJZ5v0jE4Ler2OWeKEWuHwEwM4RHYC5r8BwgcPrT6XBxFjnSNw@mail.gmail.com>
 <CAKv+Gu8xY-RvJKTKfv-e0qonL4oECDBK+ppxztvh9BgdpG8CUg@mail.gmail.com>
Message-ID: <CAKv+Gu8PmKe+X5b0P_KuWfB6U-P-EngJw04JdJUkEkwrqNK97g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 April 2018 at 11:57, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 22 April 2018 at 11:27, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Thu, Apr 19, 2018 at 6:58 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> When building ACPI bus drivers such as button.ko into the core kernel,
>>> other drivers that depend on its symbols are loadable even when booting
>>> with ACPI disabled. For instance, nouveau.ko has a link time dependency
>>> on acpi_lid_open() on ACPI capable kernels, and calls it regardless of
>>> whether the system booted via ACPI.
>>>
>>> However, when building button.ko as a module, it will refuse to load if
>>> the system did not boot in ACPI mode, which subsequently prevents the
>>> nouveau driver from loading as well, resulting in broken graphics.
>>>
>>> Given that returning an error from an initcall() is ignored for drivers
>>> that are built into the kernel,
>>
>> Which makes sense, because they are present in the kernel anyway.
>>
>>> let's align the module case with this,
>>> and not return an error when registering an ACPI bus driver on a system
>>> that did not boot via ACPI.
>>
>> But why is loading a module that's never going to be used actually OK?
>>
>> Isn't this a problem with the assumptions made by the nouveau driver
>> that need not be met depending on what configuration the kernel is run
>> in?
>>
>> Honestly, it doesn't appear quite right to try to change the rest of
>> the kernel to follow the nouveau's expectations.
>>
>
> I don't disagree here, I am just unsure whether other options are any better.
>
> I think the alternative is to make acpi_lid_open() a non-modular
> function of the ACPI core that invokes the button ACPI bus driver if
> it was loaded, and always returns false otherwise. Would that work for
> you?

BTW not only nouveau invokes acpi_lid_open(), i915 does it as well.

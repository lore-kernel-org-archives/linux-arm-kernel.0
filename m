From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 27 Feb 2018 14:54:48 +0000
Subject: [PATCH] arm64/acpi: make ACPI boot preference configurable
In-Reply-To: <1454e833-e3b9-780b-c5db-a6f73e799352@redhat.com>
References: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
 <CAKv+Gu9FVD18v6WA8MMG5LFX9GPObq_79hFuYv6j+S98a5Ej6w@mail.gmail.com>
 <1454e833-e3b9-780b-c5db-a6f73e799352@redhat.com>
Message-ID: <CAKv+Gu9fJXXZ8U71+vnR-bhnecCZnMfF9bSm2sOagDbuxZSu=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2018 at 14:28, Jonathan Toppins <jtoppins@redhat.com> wrote:
> On 02/27/2018 02:22 AM, Ard Biesheuvel wrote:
>> Hi Jonathan,
>>
>> On 27 February 2018 at 06:05, Jonathan Toppins <jtoppins@redhat.com> wrote:
>>> This patch allows a user to configure ACPI to be preferred over
>>> device-tree.
>>>
>>
>> This comes up once a year or so, and the consensus has been so far
>> that it is not up to the kernel to reason about whether DT or ACPI
>> should be preferred if both are supplied, Instead, it is up to the
>> firmware to ensure that only one of those is provided, and we added a
>> generic driver to EDK2 that implements this.
>
> I am assuming EDK2 is some sort of firmware code base, not that I have
> ever heard of it before. This logic compared with the implementation in
> the kernel seems divergent. The kernel is clearly making a choice about
> which boot table (DT vs ACPI) to configure with. So to claim it is not
> the kernel's job to reason about which to use is clearly incorrect.

The arm64 ACPI kernel requires DT support to boot in the first place
(due to its dependency on UEFI), and DT support predates ACPI support
by a couple of years. So it is far from unreasonable that the default
assumption is DT.

> The
> only thing this patch is doing is making it easier for distributions to
> configure which preference the kernel has.
>

No, it does more than that:
- it doubles the size of your validation matrix, because now you will
have 'DT kernels' and 'ACPI kernels'
- it will remove the little incentive vendors have to get with the
program, adhere to the SBBR and ensure that the OS is not left to
choose between DT and ACPI.

>>
>>> Currently for ACPI to be used a user either has to set acpi=on on the
>>> kernel command line or make sure any device tree passed to the kernel
>>> is empty. If the dtb passed to the kernel is non-empty then device-tree
>>> will be chosen as the boot method of choice even if it is not correct.
>>
>> Your firmware is terminally broken if it provides an incorrect DT, and
>> we should not be fixing it in the kernel.
>
> This logic would seem akin to me asking Bjorn to remove all PCI quirks
> from the kernel, because the systems that use them are "terminally
> broken" or "don't follow the standard".

Do you really think PCI quirks are there to work around software bugs?

> This doesn't seem like a valid
> reason to deny a change that would allow the kernel to boot on more
> hardware. Further it seems rather rigid to effectively say that we only
> run on perfect firmware.
>

Could you please try to respond to what is actually being said rather
than put words in my mouth?

Nobody is saying we only run on perfect firmware. I am saying it
should not be left to the OS to reason about which hardware
description it should use.

>>
>>> To prevent this situation where a system is only intended to be booted
>>> via ACPI a user can set this kernel configuration so it ignores
>>> device-tree settings unless ACPI table checks fail.
>>>
>>
>> 'only intended to be booted via ACPI' is a property of the system, not
>> of the OS. If you need this functionality for development, you can
>> append 'acpi=on' to the kernel command line via kconfig.
>
> This is not for development this is for production rate shipping firmware.

... that is unmaintained and exposes a broken DT alongside ACPI tables?

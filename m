From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 May 2014 12:07:28 -0500
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency in
 non-SMP platforms
In-Reply-To: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CAL_JsqJy=dYpVFbgjGVRHrgwfaB7dkJVGazpfjf9qf7Z9poJuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 10:50 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> Disclaimer: this is an RFC patch series.
>
> Several of the latest Marvell Armada EBU platforms have a special
> feature that is fairly uncommon on ARM platforms: hardware I/O
> coherency. This feature allows to remove all cache maintenance
> operations that are normally needed when doing DMA transfers (only an
> I/O sync barrier is needed for DMA transfers from device).
>
> This hardware I/O coherency mechanism needs a set of ARM core
> requirements to operate properly:
>
>  * On Armada 370 (a single core processor)
>
>    - The cache policy of pages must be set to "write allocate".

Why do we want !SMP to be no write allocate in the first place? Seems
like we should always enable write-allocate at least for v7.

>  * On Armada XP (which has dual core and quad core variants)
>
>    - The cache policy of pages must be set to "write allocate".
>    - The SMP bit in the Auxiliary Functional Modes Control Register 0
>      must be set (remember the CPU core is PJ4B)

I know you don't like my answer of this should be done in the bootloader.

>    - The pages must be set as shareable.

What is the impact of setting shareable bit for !SMP? I would think it
would be a don't care for true UP systems. Does the 370 actually not
work with shareable pages? AMP systems could have an issue though.

>  * On Armada 375/38x (which have single core and dual core variants)
>
>    - The cache policy of pages must be set to "write allocate".
>    - The SMP and TLB broadcast bits must be set in the Auxiliary
>      Control Register (the core is a Cortex-A9)

bootloader :)

>    - The pages must be set as shareable.
>    - The SCU must be enabled

This is also needed on A9s using ACP port. (Could be in the bootloader as well.)

While I understand the we can't update the bootloader/firmware
arguments, we also would reasonably expect ACPI based server systems
from the same vendor. Those systems are going to have to get things
right in the firmware and thus will require firmware updates in the
early stages before production systems and OS's are ready. I don't
know that the vendor mindset will ever be changed other than by
refusing to accept changes upstream which should be fixed in firmware
(and distros also refusing to carry them).

> All of these requirements are met when the kernel is configured with
> CONFIG_SMP *and* when the processor is actually a multiple core
> processors (otherwise, due to the CONFIG_SMP_ON_UP logic, is_smp()
> returns false, and most of the requirements above are not met).

I think there are some other problems here with is_smp(). For example,
there are several cases where it is used for determining to read the
MPIDR register. For things such as matching MPIDR to DT cpu nodes, we
need that to work for !SMP kernels.

> For example, as of today, Armada 370 is broken because even if we
> build the kernel CONFIG_SMP, the pages do not have the "write
> allocate" attribute, because Armada 370 is single core, therefore the
> CONFIG_SMP_ON_UP logic decides that we're not on an SMP system, and
> therefore is_smp() returns false. Therefore, the fact that hardware
> I/O coherency is enabled on Armada 370 today is incorrect, and there
> is no way to fix that without making changes to the ARM core code.
>
> Similarly, the Armada 380 (single core variant of the Armada 385) will
> have the same problem: it's a single core processor, but that requires
> several characteristics of an SMP configuration to properly use
> hardware I/O coherency.
>
> Also:
>
>  - Not being able to use hardware I/O coherency on Armada 370 and
>    Armada 380 is not really an option, as it is a major feature of
>    those SoCs.
>
>  - Having to enable CONFIG_SMP is also not very nice, as it comes with
>    other performance penalties that could be avoided by using a
>    !CONFIG_SMP configuration on those single core systems. And again,
>    enabling CONFIG_SMP does *not* work for single core processors due
>    to CONFIG_SMP_ON_UP.
>
> Therefore, this RFC patch series proposes one solution to allow these
> requirements to be met in the situations we are interested. The patch
> series is *only* a proposal, and I'm definitely interested in hearing
> about other implementation possibilites to make things look nicer.
>
> Basically, the patch series goes like this:
>
>  * PATCH 1 adds a 'flags' field to 'struct machine_desc' so that each
>    platform can tell the ARM kernel core some of its requirements. We
>    maybe could have used the Device Tree as well, but accessing the
>    Device Tree as early as in paging_init() is a bit problematic as
>    far as I understand.
>
>    Two flags are defined: MACHINE_NEEDS_CPOLICY_WRITEALLOC and
>    MACHINE_NEEDS_SHAREABLE_PAGES. We need separate flags because
>    Armada 370 cannot have the shareable attribute on page tables.

I think these are too specific. We used to have arch_is_coherent()
which somewhat does what you need, but it was not multi-platform
friendly. I think you need something like "is_io_coherent" and/or
"is_mp".

Rob

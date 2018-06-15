From: james.morse@arm.com (James Morse)
Date: Fri, 15 Jun 2018 17:29:32 +0100
Subject: [PATCH 0/3] arm64: kexec,kdump: fix boot failures on acpi-only
 system
In-Reply-To: <20180615075623.13454-1-takahiro.akashi@linaro.org>
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
Message-ID: <81a9a385-3b9f-113d-96f0-379be74c19f0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

Thanks for putting this together,

On 15/06/18 08:56, AKASHI Takahiro wrote:
> This patch series is a set of bug fixes to address kexec/kdump
> failures which are sometimes observed on ACPI-only system and reported
> in LAK-ML before.
> 
> In short, the phenomena are:
> 1. kexec'ed kernel can fail to boot because some ACPI table is corrupted
>    by a new kernel (or other data) being loaded into System RAM. Currently
>    kexec may possibly allocate space ignoring such "reserved" regions.
>    We will see no messages after "Bye!"
> 
> 2. crash dump (kdump) kernel can fail to boot and get into panic due to
>    an alignment fault when accessing ACPI tables. This can happen because
>    those tables are not always properly aligned while they are mapped
>    non-cacheable (ioremap'ed) as they are not recognized as part of System
>    RAM under the current implementation.
> 
> After discussing several possibilities to address those issues,
> the agreed approach, in my understanding, is
> * to add resource entries for every "reserved", i.e. memblock_reserve(),
>   regions to /proc/iomem.
>   (NOMAP regions, also marked as "reserved," remains at top-level for
>   backward compatibility.)

This means user-space can tell the difference between reserved-system-ram and
reserved-address-space.


> * For case (1), user space (kexec-tools) should rule out such regions
>   in searching for free space for loaded data.

... but doesn't today, because it fails to account for second-level entries.
We've always had second-level entries, so this is a user-space bug. We need both
fixed to fix the issue.

Our attempts to fix this just in the kernel reached a dead end, because Kdump
needs to include reserved-system-ram, whereas kexec has to avoid it. User-space
needs to be able to tell reserved-system-ram and reserved-address-space apart.
Hence we need to expose that information, and pick it up in user-space.

Patched-kernel and unpatch-user-space will work the same way it does today, as
the additional reserved regions are ignored by user-space.

Unpatched-kernel and patched-user-space will also work the same way it does
today as the additional reserved regions are missing.

I think this is the only way forwards on this issue...


> * For case (2), the kernel should access ACPI tables by mapping
>   them with appropriate memory attributes described in UEFI memory map.
>   (This means that it doesn't require any changes in /proc/iomem, and
>   hence user space.)

(this one is handled entirely in the kernel)


Thanks,

James

From: james.morse@arm.com (James Morse)
Date: Tue, 15 May 2018 18:10:06 +0100
Subject: [PATCH] arm64: export memblock_reserve()d regions via /proc/iomem
In-Reply-To: <20180507024024.GA11326@linaro.org>
References: <20180425132250.9397-1-james.morse@arm.com>
 <2708a0b0-72c7-b518-cced-a87b8a94ab79@arm.com>
 <20180507024024.GA11326@linaro.org>
Message-ID: <13c0db9d-8dfb-73f0-01a2-252505a53c5d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 07/05/18 03:40, Akashi Takahiro wrote:
> On Wed, May 02, 2018 at 11:35:04AM +0100, James Morse wrote:
>> On 25/04/18 14:22, James Morse wrote:
>>> There has been some confusion around what is necessary to prevent kexec
>>> overwriting important memory regions. memblock: reserve, or nomap?
>>> Only memblock nomap regions are reported via /proc/iomem, kexec's
>>> user-space doesn't know about memblock_reserve()d regions.

>>> But this was always broken, as the UEFI memory map is also reserved
>>> and not marked as nomap.

>>> Lastly, we add the memblock_reserved() regions using
>>> reserve_region_with_split(), which will fill in the gaps between the
>>> existing named regions. (e.g. the regions occupied by the __init code).
>>> This call uses the slab allocator, so has to run from an initcall.

>> Re-reading Akashi's description of how kdump generates the ELF headers for
>> /proc/vmcore, this change might break kdump, as now the memblock_reserved()
>> regions may be missing from /proc/vmcore. (I'll test that).

> I also tested your patch, and there seems to be something wrong.

(excellent, I've been trying to remember how to build crash!)


> Actually, crash utility fails to read the core:
>         crash-arm64: read error: kernel virtual address: ffff0000091fa998  \
>                                         type: "shadow_timekeeper xtime_sec"
>         crash-arm64: read error: kernel virtual address: ffff0000091fda48  \
>                                         type: "high_memory"

> Adding some debug messages shows that "shadow_timekeeper" variable
> belongs to the range (A), which is originally part of "Kernel data"
> and should have been unmarked from "reserved" list.

Heh, so it caught fire even earlier. I was expecting only the per-cpu regions to
go missing.

Yes, the problems are going to be spurious-reserved and regions that aren't
reserved anymore, but were when the /proc/iomem list was generated.


>> Unless there is a 'name' for a region that kexec-tools interprets as "don't
>> overwrite this, but do include it in the ELF header", then we're stuck. We can't
>> fix kexec without breaking kdump, we have to change user-space.
>>
>> Of the two, missing data from kdump vmcore would be preferable to failed-to-boot
>> kexec.
> 
> Well, kexec has had this potential bug since the day One in mainline.
> (we were then using "boot wrapper" instead of normal boot loaders though.)

> Even if we accept your assertion above now, future new-comers may
> "rediscover" a kdump bug and make a complaint time to time.
> So I think that we would be better off fixing the issue right now
> completely with accompanying user-space change.

I agree we need to fix this 'now'. But changing user-space means people still
hit this bug, and are told 'update both user-space and your kernel'.

This is because kexec-tools is using the /proc/iomem list for two things:
1 don't write here, you need it to boot.
2 preserve this memory, you need it in the vmcore.

I think kdump is less common and more best-effort, my preference would be:

>> If we have to change user-space, I'd like to make use of the kernels
>> ability to generate the ELF header itself, (e.g. kexec_file_load()).

For kexec-tools to load the vmcore data it currently generates itself from
/sys/kernel/kdump_elf_header or similar.

This splits the 1&2 cases above, meaning the kernel can export information for
(1) via /proc/iomem and (2) via the new file.

old kexec-tools still works for kexec, but hits the problem you found for kdump.
new kexec-tools aware of (2) works in both cases.

But merging this patch to fix old kexec-tools will prevent us doing anything
'neater', and any fix for old-kexec is going to break kdump with the same
user-space.


For your proposed kexec-tool and kernel changes, how will old kexec-tools work?
Is it going to be any worse than today?



Thanks,

James

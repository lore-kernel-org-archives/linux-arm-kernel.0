From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 1 Feb 2017 14:06:45 +0000
Subject: [PATCH/RFC] arm64: defconfig: Enlarge CMA alignment to 2 MiB
In-Reply-To: <CANqRtoQJaRK7Kys-fudyxJuojBmZyXMsNoDudSt4p=gj5srviA@mail.gmail.com>
References: <1485532996-19719-1-git-send-email-geert+renesas@glider.be>
 <CANqRtoQJaRK7Kys-fudyxJuojBmZyXMsNoDudSt4p=gj5srviA@mail.gmail.com>
Message-ID: <a4e171b0-6403-9d88-3b8f-e63f3f050689@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/17 13:45, Magnus Damm wrote:
> Hi Geert,
> 
> On Sat, Jan 28, 2017 at 1:03 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> Some IOMMUs (e.g. Renesas IPMMU/VMSA) support only page sizes of 4 KiB,
>> 2 MiB, and 1 GiB.
>>
>> With the default setting of CONFIG_CMA_ALIGNMENT = 8, allocations larger
>> than 1 MiB are aligned to a 1 MiB boundary only.  Hence a 2 MiB
>> allocation may not be aligned, leading to a mapping of 512 4 KiB pages.
>>
>> Increase CONFIG_CMA_ALIGNMENT to allow mapping a 2 MiB buffer using a
>> single PTE, decreasing memory usage and TLB pressure.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Is this useful?
>>
>> Should there instead be different defaults in Kconfig, depending on
>> enabled platform support?
> 
> I think there is a dependency on the kernel page size configuration as
> well. In case of 16 KiB or 64 KiB page size configuration other large
> page sizes may be required.

I don't see the original patch (linux-arm-kernel doesn't look to have it
archived either), but I think bumping the default up to 2MB to match our
normal section size sounds generally reasonable - users can still
override it manually in their config, right? For 16KB and 64KB granules,
it is at least the size covered by contiguous-hinted pages; the actual
section sizes there are far too big to be practical for alignment
purposes anyway (32MB and 512MB respectively).

Robin.

> 
> Thanks,
> 
> / magnus
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

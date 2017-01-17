From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jan 2017 22:07:11 -0800
Subject: [PATCH v4] ARM64: dts: meson-gx: Add reserved memory zone and
 usable memory range
In-Reply-To: <7fcb8d94-840a-de2c-f43b-9123ccc65514@baylibre.com>
References: <1484129414-23325-1-git-send-email-narmstrong@baylibre.com>
 <m21sw66828.fsf@baylibre.com> <d3a00788-c3c1-4b10-90bf-2a8bc6a138f8@suse.de>
 <7fcb8d94-840a-de2c-f43b-9123ccc65514@baylibre.com>
Message-ID: <CAOesGMhYfhrd-hy=N-FYDEPmumR0=QNzn5xTLxFuKG7apo5qiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 2:39 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 01/15/2017 03:43 PM, Andreas F?rber wrote:
>> Am 13.01.2017 um 21:03 schrieb Kevin Hilman:
>>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>>
>>>> The Amlogic Meson GXBB/GXL/GXM secure monitor uses part of the memory space,
>>>> this patch adds this reserved zone and redefines the usable memory range.
>>>>
>>>> The memory node is also moved from the dtsi files into the proper dts files
>>>> to handle variants memory sizes.
>>>>
>>>> This patch also fixes the memory sizes for the following platforms :
>>>> - gxl-s905x-p212 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>>>> - gxm-s912-q201 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>>>> - gxl-s905d-p231 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>>>> - gxl-nexbox-a95x : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>>>>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>
>>> Queued for v4.10-rc.
>>
>> What is the motivation for this change? I have a local U-Boot patch to
>> detect the amount of memory available as done downstream, but U-Boot
>> only updates the reg property that you seem to be abandoning here...
>>
>> So for devices that come in multiple RAM configurations - like R-Box Pro
>> - this would require separate .dts files now! This looks very wrong to
>> me, especially since I am not aware of other platforms doing the same.
>> Instead, there's memory reservations for top and bottom done in U-Boot
>> for reg, plus reserved-memory nodes for anything in the middle.
>>
>> Another thing to consider is that uEFI boot (bootefi) handles memory
>> reservation differently yet again, on the bootloader level. I have had
>> that working fine on Odroid-C2 and Vega S95.
>>
>> So if there's no bug this is fixing (none mentioned in commit message) I
>> strongly object to this patch.
>>
>> Regards,
>> Andreas
>>
>
> Hi Andreas,
>
> Like I replied of my RFT patch :
> I really disagree about relying on any work or properties added by any bootloader here, Amlogic SoCs has
> a lot of u-boot versions in the field, and the Odroid-C2 is part of this.
>
> Even if Odroid-c2 is in mainline U-Boot or not, the mainline Linux kernel should work using
> any U-boot version even with the one provided by Amlogic on their openlinux distribution channel.
>
> Handling multiple RAM configuration is another story, and the Arm-Soc and DT maintainers should give us
> their advices.

Is there a way to detect what firmware is running and marking off
memory from early kernel init instead? That'll take care of the
concerns about memory size variance as well.

> Actually there is a severe bug fixed here that cause a huge crash if such memory is not reserved while
> running stock u-boot version on various shipped products and Amlogic's own development boards.
>
> The bug is easily triggered by running :
> # stress --vm 4 --vm-bytes 128M --timeout 10s &
> [   46.937975] Bad mode in Error handler detected on CPU1, code 0xbf000000 -- SError
> ...
> [   47.058536] Internal error: Attempting to execute userspace memory: 8600000f [#3] PREEMPT SMP
> ...
>
> Note this is a fix targeted for 4.10 to make the system stable and various users reported some severe
> crash now the system has more drivers and read-world use-cases are running on Amlogic SoCs.
>
> Please feel free to push whatever changes that makes this memory reservation more coherent for 4.11,
> and respect the behavior of already shipped u-boot version and mainline U-Boot, UEFI, whatever...

Technically we're not in regression territory here, since the platform
is obviously still in bringup and these aren't bugs that have been
introduced in this release. So I think we can take a little while to
sort out if there's a solution that, even if not ideal, at least is on
the path towards the proper fix and not away from it -- which this
seems to be.


-Olof

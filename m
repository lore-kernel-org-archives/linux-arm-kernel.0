From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 May 2016 17:03:46 +0100
Subject: [PATCH] arm64: dts: r8a7795: Increase the size of GIC-400 mapped
 registers
In-Reply-To: <5731FE44.8010906@gmail.com>
References: <1461047395-6532-1-git-send-email-dirk.behme@de.bosch.com>
 <CAMuHMdV6XOSiSv-mwovnCAMEPsgOc_vEhPPu0aYCgz74EF242g@mail.gmail.com>
 <5731ED92.6080804@arm.com> <5731FE44.8010906@gmail.com>
Message-ID: <57320662.9010807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/16 16:29, Dirk Behme wrote:
> On 10.05.2016 16:17, Marc Zyngier wrote:
>> On 10/05/16 14:33, Geert Uytterhoeven wrote:
>>> CC Marc, lakml
>>>
>>> On Tue, Apr 19, 2016 at 8:29 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>>>> From: Pooya Keshavarzi <Pooya.Keshavarzi@de.bosch.com>
>>>>
>>>> There are some requirements about the GIC-400 memory layout and its
>>>> mapping if using 64k aligned base addresses like on r8a7795.
>>>>
>>>> See e.g.
>>>>
>>>> http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=21550029f709072aacf3b9
>>>>
>>>> Map the whole memory range instead of only 0x2000. This will fix
>>>> the issue that some hypervisors, e.g. Xen, fail to handle the
>>>> interrupts correctly.
>>>>
>>>> Signed-off-by: Pooya Keshavarzi <Pooya.Keshavarzi@de.bosch.com>
>>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>>
>>> Based on my understanding below
>>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>
>>>> ---
>>>> Note: This patch is against renesas-drivers-2016-04-12-v4.6-rc3
>>>>
>>>>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>> index 8be9424..d880fd4 100644
>>>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>> @@ -160,9 +160,9 @@
>>>>                          #address-cells = <0>;
>>>>                          interrupt-controller;
>>>>                          reg = <0x0 0xf1010000 0 0x1000>,
>>>> -                             <0x0 0xf1020000 0 0x2000>,
>>>> +                             <0x0 0xf1020000 0 0x20000>,
>>>>                                <0x0 0xf1040000 0 0x20000>,
>>>> -                             <0x0 0xf1060000 0 0x2000>;
>>>> +                             <0x0 0xf1060000 0 0x20000>;
>>>>                          interrupts = <GIC_PPI 9
>>>>                                          (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>>>>                  };
>>>
>>> Region 0:
>>>      4 KiB-pages 0xf1011000-0xf101ffff are aliased to 0xf1010000-0xf1010fff,
>>>      but we need the first 4 KiB only.
>>>
>>> Region 1:
>>>      4 KiB-pages 0xf1021000-0xf102ffff are aliased to 0xf1020000-0xf1020fff,
>>>      4 KiB-pages 0xf1030000-0xf103ffff are all zeroes, probably due to
>>>      non-secure mode?
>>
>> No. This 4kB page only contain a single register (GICC_DIR), which is
>> WO/RAZ.
>>
>>>
>>> Region 2:
>>>      4 KiB-pages 0xf1041000-0xf104ffff are aliased to 0xf1040000-0xf1040fff,
>>>      4 KiB-pages 0xf1050000-0xf105ffff are all zeroes, probably due to
>>>      non-secure mode?
>>
>> Neither. The aliases are an unused feature of GIC400 exposing the other
>> CPUs view of the same registers...
>>
>>>
>>> Region 3:
>>>      4 KiB-pages 0xf1061000-0xf106ffff are aliased to 0xf1060000-0xf1060fff,
>>>      4 KiB-pages 0xf1070000-0xf107ffff are all zeroes, probably due to
>>>      non-secure mode?
>>
>> Same as region 1.
>>
>>>
>>> Region 2 already had a 128 KiB size before, which allowed to use 8 KiB at
>>> 0xf104f000.
>>
>> No. This region (GICH) only needs the first 256 bytes or so. The rest is
>> either RAZ/WI or useless stuff.
>>
>>>
>>> An 8 KiB size for regions 1 and 3 indeed didn't make much sense, as this
>>> covered two identical (aliased) 4 KiB pages, instead of two different pages
>>> at offset 0xf000.
>>
>> While we're at it, adding a pointer to the documentation (GIC400 and
>> SBSA) would be tremendously useful, as it'd avoid misinterpreting the
>> various bits.
> 
> 
> If anybody could give a short description I could copy & paste into 
> the commit message that would be quite helpful :)

Well, there is my reply to an earlier email in this very thread, as well
as the xen commit which quotes my original commit (which you could also
refer to).

I'll leave it to you to eradicate the swear words (or to leave them in
place as a testimony of what 4 years of GIC hacking can do to an
otherwise sane person).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

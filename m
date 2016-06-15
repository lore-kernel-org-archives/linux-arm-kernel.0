From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 15 Jun 2016 13:43:32 +0100
Subject: [PATCH 00/10] ARM: V7M: Support caches
In-Reply-To: <57612A90.5030808@st.com>
References: <1465830189-20128-1-git-send-email-vladimir.murzin@arm.com>
 <575EDAB9.2070809@st.com> <575EDD28.40500@arm.com> <575EDF55.2020304@st.com>
 <57612A90.5030808@st.com>
Message-ID: <57614D74.1040308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/06/16 11:14, Alexandre Torgue wrote:
> Hi Vladimir,
> 
> On 06/13/2016 06:29 PM, Alexandre Torgue wrote:
>> Hi Vladimir,
>>
>> On 06/13/2016 06:19 PM, Vladimir Murzin wrote:
>>> Hi Alex,
>>>
>>> On 13/06/16 17:09, Alexandre Torgue wrote:
>>>> Hi Vladimir,
>>>>
>>>> On 06/13/2016 05:02 PM, Vladimir Murzin wrote:
>>>>> Hi,
>>>>>
>>>>> This patch set allows M-class cpus benefit of optional cache support.
>>>>> It originaly was written by Jonny, I've been keeping it localy mainly
>>>>> rebasing over Linux versions.
>>>>>
>>>>> The main idea behind patches is to reuse existing cache handling code
>>>>> from v7A/R. In case v7M cache operations are provided via memory
>>>>> mapped interface rather than co-processor instructions, so extra
>>>>> macros have been introduced to factor out cache handling logic and
>>>>> low-level operations.
>>>>>
>>>>> Along with the v7M cache support the first user (Cortex-M7) is
>>>>> introduced.
>>>>>
>>>>> Patches were tested on MPS2 platform with Cortex-M3/M4/M7. The later
>>>>> one showed significant boot speed-up.
>>>>>
>>>>> Based on 4.7-rc3.
>>>>>
>>>>> Thanks!
>>>>> Vladimir
>>>>>
>>>>
>>>> Thanks for the series.
>>>> Did you change something in those patches compare to patches you
>>>> sent in
>>>> the RFC ?
>>>
>>> Only 04, 05, 06 have been changed (each has it's own changelog
>>> included).
>>>
>>> I did try to hammer patches because of your report of instability with
>>> caches on, but all run fine... so nothing has been changed in regard of
>>> your case.
>>>
>> Ok. Thanks for this input. From now, I will use this series to perform
>> my tests. I will continue to debug my instabilities this week.
>> I will let you know.
>>
> I fixed my instabilities and it was linked to my SDRAM timings :(.
> I don't see behavior issues with your series (You can add my Tested-by:
> Alexandre TORGUE <alexandre.torgue@st.com>).
> 

Great! Since I have to re-work series per Russell comments I'd very
appreciate your Tested-by on further versions of the patch set.

> I have two others questions for you:
> 
> 1- Maybe I didn't search deeper in the code but when you enable Dcache
> and Icache, what is the state of cache ? I mean we need to invalidate
> caches before enable it. It is done by kernel (with your patches) or it
> has to be done by a bootloader ?
> 

I believe it follows A/R practice, so, yes, it is up to the bootloader
to make sure that cache state is consistent.

> 2- I observe an issue (IMO not linked to your series) when I switch
> off/switch on my board. During the first boot after an hard reset I get
> a bus error  (BFSR part in CFSR register indicates an "A bus fault on an
> instruction prefetch has occurred."). After SRST reset through JTAG, the
> kernel boot correctly.
> Do you already seen this kind of issue ?
> 

I didn't see anything like that, sorry.

Thanks
Vladimir

> I add the backtrace and registers info.
> 
> __invalid_entry () at arch/arm/kernel/entry-v7m.S:33
> 33    1:    b    1b
> (gdb) bt
> #0  __invalid_entry () at arch/arm/kernel/entry-v7m.S:33
> #1  0xc000bc2a in unwind_exec_insn (ctrl=<optimized out>) at
> arch/arm/kernel/unwind.c:321
> #2  unwind_frame (frame=0xc023d0c0 <reset_devices>) at
> arch/arm/kernel/unwind.c:449
> #3  0xc000caec in ?? () at arch/arm/mm/cache-v7.S:69
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> (gdb) f 3
> #3  0xc000caec in ?? () at arch/arm/mm/cache-v7.S:69
> 69           ret     lr
> (gdb) info reg
> r0             0x1    1
> r1             0x0    0
> r2             0x1    1
> r3             0x0    0
> r4             0x0    0
> r5             0x100    256
> r6             0x0    0
> r7             0xa    10
> r8             0x40096    262294
> r9             0x0    0
> r10            0xc012b004    -1072517116
> r11            0x0    0
> r12            0x29    41
> sp             0xc0230018    0xc0230018 <cpu_cache+4>
> lr             0xc000caed    -1073689875
> pc             0xc000caec    0xc000caec <v7_flush_icache_all>
> xPSR           0x81000005    -2130706427
> 
> 
> Thanks for your time.
> 
> Alex
> 
> 
> 
> 

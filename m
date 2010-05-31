From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 31 May 2010 09:56:31 +0900
Subject: [PATCH] s5pv210: Change the base ram address to 0x3000'0000
In-Reply-To: <AANLkTilMSARvhdta47LieosduQPJLhwqEts8MDrbbBSI@mail.gmail.com>
References: <20100528023559.GA8174@july>
	<20100531003911.GM7248@trinity.fluff.org>
	<AANLkTilMSARvhdta47LieosduQPJLhwqEts8MDrbbBSI@mail.gmail.com>
Message-ID: <AANLkTilwyDab6MC_hC5L2AeI6yrDCKZ3GsNlztbsAwo3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 9:47 AM, Kyungmin Park <kmpark@infradead.org> wrote:
> On Mon, May 31, 2010 at 9:39 AM, Ben Dooks <ben-linux@fluff.org> wrote:
>> On Fri, May 28, 2010 at 11:35:59AM +0900, Kyungmin Park wrote:
>>> s5pc110 (aka s5pv210) has 2 DRAM port and used it both usually.
>>> Assume DMC0 starts with 0x2000'0000 with 128MiB.
>>> DMC1 starts with 0x4000'0000 with 128MiB.
>>> Note that DMC1 has to start address 0x4000'0000 at least.
>>>
>>> Then there's too much memory hole 0x1800'0000 (128MiB + 256MiB)
>>>
>>> To reduce memory waste, the DMC0 start with 0x3000'0000.
>>>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> ---
>>> diff --git a/arch/arm/mach-s5pv210/Makefile.boot b/arch/arm/mach-s5pv210/Makefile.boot
>>> index ff90aa1..b0909e3 100644
>>> --- a/arch/arm/mach-s5pv210/Makefile.boot
>>> +++ b/arch/arm/mach-s5pv210/Makefile.boot
>>> @@ -1,2 +1,2 @@
>>> - ? zreladdr-y ? ? ? ?:= 0x20008000
>>> -params_phys-y ? ? ? ?:= 0x20000100
>>> + ? zreladdr-y ? ? ? ?:= 0x30008000
>>> +params_phys-y ? ? ? ?:= 0x30000100
>>
>> Apart from the technical comments that have been in this thread, I would
>> like to share notes about making changes like these that affect the entire
>> SoC kernel build.
>>
>> Firstly, changing this effects the rest of the users, not everyone is
>> using the same device with same layout. This configuration boots on
>> both S5PC110 and S5PV210 devices. Some of these _have_ to support 1GiB
>> of memory. Some of them have their bootloaders programemd to start at
>> 0x20... So please think of how this will affect everyone else.
>>
>> Secondly, if you have thought about point 1, then please let us know in
>> the commit messages. ?The commit message isn't just a log of what the
>> patch does, it can also be used to show any necessary working about what
>> is happening and side-effects of it.
>>
>> Thirdly, the kernel's default configuration for a SoC/arch isn't meant to
>> be the best-fit for your board(s) or development practicies. It is meant
>> to cover as many devices as possible, to allow build testing and to have
>> something that people can test with. If it is not the most efficient on
>> the board, then make your own defconfig that is a best fit for your
>> purposes.
>>
>> So, sometimes when this sort of change is required there may be a case of
>> making it configurable so that your own defconfig/boardconfig can select
>> it for your own projects.
>>
>>
>> Please keep in mind that other people have/are using the kernel and that
>> some changes have an affect on other projects as well as your own. This
>> is why user-space facing changes are the most debated and difficult to
>> do, kernel internals shift quite easily, whilst the data exported to
>> userspace is kept as stable as possible.
>
> Definitely I agree with your opinions. and that's why I change it to
> 0x3000'0000.
> when we start the project. chip vendor guides us to use the
> 0x3000'0000. at that time there's some reason to use this address. As
> I know. but some time later they change it to 0x2000'0000.
> But we already setup and develop the all environment as 0x3000'0000.
> it's also difficult to change it to 0x2000'0000.

Please see the committed date.
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=8bc4ee9e8213abe4031ea1720aa02fa98d4402ad

+#
+# Copyright (C) 2008 # Samsung Elecgtronics
+# Kyungmin Park <kyungmin.park@samsung.com>
+#
+
+# On S5PC100 we use the 128 MiB OneDRAM bank at
+#
+# 0x30000000 to 0x35000000 (80MiB)
+# 0x38000000 to 0x40000000 (128MiB)
+#
+# On S5PC110 we use the 128 MiB OneDRAM bank at
+#
+# 0x30000000 to 0x35000000 (80MiB)
+# 0x40000000 to 0x48000000 (128MiB)
+#
+TEXT_BASE = 0x34800000

Thank you,
Kyungmin Park

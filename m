From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Jun 2017 20:02:38 +0200
Subject: [PATCH v4 20/28] ARM: owl: Implement CPU enable-method for S500
In-Reply-To: <333b3b63-f3c6-f449-40f0-69c294f4fb7a@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-21-afaerber@suse.de>
 <CAK8P3a1fLABzSc7kej6uw751uoZma1Qvpm7c3mkLB45rcBNQTA@mail.gmail.com>
 <CAK8P3a2epor2RZzJ1ySp2g-vUSTj+miWNJC26uYU7v3Knq=pvw@mail.gmail.com>
 <333b3b63-f3c6-f449-40f0-69c294f4fb7a@suse.de>
Message-ID: <CAK8P3a3MdzOe2E395TuDr0aBHE5a5-q2uNEPH-qjRAhpTu3M1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 6:48 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 21.06.2017 um 12:25 schrieb Arnd Bergmann:
>> On Wed, Jun 21, 2017 at 10:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Tue, Jun 6, 2017 at 2:54 AM, Andreas F?rber <afaerber@suse.de> wrote:
>>>> Allow to bring up CPU1.
>>>>
>>>> Based on LeMaker linux-actions tree.
>>>>
>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>> ---
>>>>  v3 -> v4: Unchanged
>>>>
>>>>  v3: new
>>>>
>>>>  arch/arm/mach-actions/Makefile  |   3 +
>>>>  arch/arm/mach-actions/headsmp.S |  68 ++++++++++++++++
>>>>  arch/arm/mach-actions/platsmp.c | 166 ++++++++++++++++++++++++++++++++++++++++
>>>
>>> I now see build errors in linux-next:
>>>
>>> /git/arm-soc/arch/arm/mach-actions/platsmp.c: In function 'write_pen_release':
>>> /git/arm-soc/arch/arm/mach-actions/platsmp.c:39:2: error:
>>> 'pen_release' undeclared (first use in this function); did you mean
>>
>> I have a fix and tested it now. Please fold this into your patch:
>>
>>        Arnd
>>
>> Subject: [PATCH] ARM: owl: fix non-SMP build
>>
>> arch/arm/mach-actions/platsmp.c: In function 'write_pen_release':
>> arch/arm/mach-actions/platsmp.c:39:2: error: 'pen_release' undeclared
>> (first use in this function); did you mean 'seq_release'?
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> diff --git a/arch/arm/mach-actions/Makefile b/arch/arm/mach-actions/Makefile
>> index 217e95d04b43..94f8dbafba21 100644
>> --- a/arch/arm/mach-actions/Makefile
>> +++ b/arch/arm/mach-actions/Makefile
>> @@ -1,4 +1,4 @@
>> -obj-$(CONFIG_ARCH_ACTIONS) += owl.o
>> -obj-${CONFIG_ARCH_ACTIONS} += platsmp.o headsmp.o
>> +obj-y += owl.o
>> +obj-$(CONFIG_SMP) += platsmp.o headsmp.o
>
> Sorry. Fixed up the two patches, thanks!
>
> Interestingly the below issue had been found by automatic patch testing,
> but the above wasn't. Maybe you can contribute your non-SMP config for
> the bots, to help catch this earlier?

This was just a randconfig build. On ARM32, we do test
"multi_v7_defconfig+CONFIG_SMP=n"
in kernelci, but that only tests mach-actions after that gets added to
multi_v7_defconfig. Not sure if it's worth adding an allmodconfig+CONFIG_SMP=n"
build, the allmodconfig builds are rather expensive.

        Arnd

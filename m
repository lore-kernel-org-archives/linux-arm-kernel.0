From: fengguang.wu@intel.com (Fengguang Wu)
Date: Fri, 17 Nov 2017 07:50:07 +0800
Subject: [GIT PULL 2/3] ARM: SoC driver updates for 4.15
In-Reply-To: <CAK8P3a3uwqeeg7--UDTWJ33g7YejXp5rtV9OFt=jrt-AzQi13Q@mail.gmail.com>
References: <CAK8P3a2Wp6EANLq7JZr=uAReKOhBYrc3VKUA7FpDvq7n3Lc2aQ@mail.gmail.com>
 <CA+55aFyvWnmLzYs+Hb+d=ir9Ww8gLcNn9=Oc=zwKdK=L-nmXZA@mail.gmail.com>
 <CAK8P3a3uwqeeg7--UDTWJ33g7YejXp5rtV9OFt=jrt-AzQi13Q@mail.gmail.com>
Message-ID: <20171116235007.6caupnnbddaguwqr@wfg-t540p.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 17, 2017 at 12:25:12AM +0100, Arnd Bergmann wrote:
>On Thu, Nov 16, 2017 at 11:29 PM, Linus Torvalds
><torvalds@linux-foundation.org> wrote:
>> On Thu, Nov 16, 2017 at 2:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> ARM: SoC driver updates for v4.15
>>
>> No. This is completely broken, and I can't imagine that it has ever
>> compiled for *anybody*.
>>
>>   drivers/soc/renesas/r8a77970-sysc.c:14:10: fatal error:
>> dt-bindings/power/r8a77970-sysc.h: No such file or directory
>>    #include <dt-bindings/power/r8a77970-sysc.h>
>>
>> and the compiler is completely right. This branch added that
>> r8a77970-sysc.c file, but never added the header file.
>>
>> And it's not some odd merge mistake of mine: I checked. That error is
>> there in the original branch too.
>>
>> Tssk.
>
>Right, I need to figure out how this could have slipped through. I did
>get several "BUILD SUCCESS" mails from the kbuild bot (see
>https://pastebin.com/JDw3EKDZ), which claims to have built it
>successfully in all configurations, including allmodconfig builds on
>arm/arm64 and x86-64. Fengguang, do you remember problems
>with false-negatives recently?

Sorry I checked log and didn't find any 0day reports for that error.

It actually hit the errors several times:

drivers/soc/renesas/r8a77970-sysc.c:14:11: sparse: unable to open 'dt-bindings/power/r8a77970-sysc.h'

2017-10-21 07:23:12 on arm-soc/next/drivers 1c6788e8746d5250ad9bd16e1e48140a396f4733 x86_64-allmodconfig


drivers/soc/renesas/r8a77970-sysc.c:14:45: fatal error: dt-bindings/power/r8a77970-sysc.h: No such file or directory

2017-11-03 07:45:22 on arm-soc/next/drivers 30f3b0678ce6fc46bcdde61ca35821032d0f25b5 i386-allmodconfig
2017-11-03 08:42:45 on arm-soc/next/drivers 30f3b0678ce6fc46bcdde61ca35821032d0f25b5 arm-allmodconfig
2017-11-03 08:43:06 on arm-soc/next/drivers 30f3b0678ce6fc46bcdde61ca35821032d0f25b5 arm64-allmodconfig

So the robot is not working well in that case, I'll work with Philip
to get that fixed.

Regards,
Fengguang

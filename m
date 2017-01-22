From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 22 Jan 2017 10:54:50 +0000
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <1485078760.1308.6.camel@crowfest.net>
References: <1485072424.14066.2.camel@crowfest.net>
 <9647813.NZ2c5cYUSH@localhost>
 <1485075528.14345.1.camel@crowfest.net> <20170122170523.3b4b1235@xhacker>
 <1485077887.1308.2.camel@crowfest.net>
 <CAKv+Gu9gBPenhOBj9G7rrqi3h_oMi3X7qpmsK+SB1dgBtzfKTg@mail.gmail.com>
 <1485078760.1308.6.camel@crowfest.net>
Message-ID: <CAKv+Gu8rM9b2QrkKRVW=7FQLherg9fcv+H+01s+axsN9uZCBmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2017 at 09:52, Michael Zoran <mzoran@crowfest.net> wrote:
> On Sun, 2017-01-22 at 09:43 +0000, Ard Biesheuvel wrote:
>> On 22 January 2017 at 09:38, Michael Zoran <mzoran@crowfest.net>
>> wrote:
>> > On Sun, 2017-01-22 at 17:05 +0800, Jisheng Zhang wrote:
>> > > On Sun, 22 Jan 2017 00:58:48 -0800 Michael Zoran wrote:
>> > >
>> > > > On Sun, 2017-01-22 at 09:52 +0100, Alexander Stein wrote:
>> > > > > Hi Michael,
>> > > > >
>> > > > > On Sunday, January 22, 2017, 12:07:04 AM CET Michael Zoran
>> > > > > wrote:
>> > > > > > I'm not sure if this if the correct place to be asking
>> > > > > > this.   The
>> > > > > > RPI
>> > > > > > 3 running ARM64 is slowly reaching the point of being about
>> > > > > > to
>> > > > > > seriously run a 32 bit vender OS like Raspbian.  When
>> > > > > > running
>> > > > > > Raspbian,
>> > > > > > I'm seeing a very large number(thousands) of kernel log
>> > > > > > messages
>> > > > > > about
>> > > > > > deprecated instructions especially setend and barrier
>> > > > > > instuctions.
>> > > > > > This can be very annoying and is completely filling the
>> > > > > > kernel
>> > > > > > log.
>> > > > > >
>> > > > > > I'm considering submitting a patch to add a Kconfig option
>> > > > > > to
>> > > > > > disable
>> > > > > > these warnings with the default being to keep the warnings
>> > > > > > enabled.  I
>> > > > > > was wondering if such a patch could be seriously
>> > > > > > considered.
>> > > > >
>> > > > > Could you please provide an example of those warning an what
>> > > > > is
>> > > > > trigging
>> > > > > those?
>> > > > >
>> > > > > Thanks and best regards,
>> > > > > Alexander
>> > > >
>> > > > Sure, here is a snipped from dmesg.  I think this is happening
>> > > > because
>> > > > the entire Raspbian OS is compiled with a custom gcc compiler
>> > > > that
>> > > > is
>> > > > targeting arm6+VFP.
>> > >
>> > > IMHO, this is the root cause. I didn't see below warnings from
>> > > dmesg
>> > > with
>> > > armhf debian and ubuntu If the underlying HW is armv8 compatible,
>> > > it
>> > > doesn't make sense to target the compiler to armv6
>> > >
>> > >
>> >
>> > Advanced users can install a different OS. Beginners can't and will
>> > need a single OS image for simple install.
>> >
>>
>> That single OS image can simply test for the presence of
>> /proc/sys/abi, and perform the writes if it is there.
>>
>> > Does anybody know if these instructions are detected at runtime?
>>
>> What do you mean by 'detected'?
>>
>> > I'm
>> > also looking into an issue with Mathmatica due to broken OS
>> > detection.
>> > It appears that arm64 is currently missing some of the CPU spoofing
>> > that happens on other architectures...
>> >
>>
>> Could you elaborate? What do you think should be there that isn't?
>
> I'm saying that when running a ELF32 executable, the system needs to
> fake the CPU architecture according to the uname system API and
> /proc/cpuinfo.
>
> Today, I run uname -a in Raspbian and I get aarch64.  I want it to
> display arm6l or whatever to get Mathematica to load.
>
> I see some code to make this work on other architectures such as X86,
> but most of this appears to be unimplemented on arm64.
>

Did you try linux32?

pi at raspberrypi:~$ uname -a
Linux raspberrypi 4.10.0-rc3-v8+ #3 SMP PREEMPT Sun Jan 15 15:22:12
WET 2017 aarch64 GNU/Linux
pi at raspberrypi:~ $ linux32 uname -a
Linux raspberrypi 4.10.0-rc3-v8+ #3 SMP PREEMPT Sun Jan 15 15:22:12
WET 2017 armv8l GNU/Linux

If the app in question cannot deal with the armv8l personality, the
app should be fixed instead.

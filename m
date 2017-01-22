From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 22 Jan 2017 09:36:32 +0000
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <1485077630.1308.0.camel@crowfest.net>
References: <1485072424.14066.2.camel@crowfest.net>
 <9647813.NZ2c5cYUSH@localhost>
 <1485075528.14345.1.camel@crowfest.net>
 <CAKv+Gu8LU3QjrUa6wMJF3WBNrhx34Pi_0ZUQVfrZy7w7y7237w@mail.gmail.com>
 <1485077630.1308.0.camel@crowfest.net>
Message-ID: <CAKv+Gu-fPg50LE0N=GPisq=YSV6TDAOQTG2f6DNPU7sGHZf8Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2017 at 09:33, Michael Zoran <mzoran@crowfest.net> wrote:
> On Sun, 2017-01-22 at 09:09 +0000, Ard Biesheuvel wrote:
>> On 22 January 2017 at 08:58, Michael Zoran <mzoran@crowfest.net>
>> wrote:
>> > On Sun, 2017-01-22 at 09:52 +0100, Alexander Stein wrote:
>> > > Hi Michael,
>> > >
>> > > On Sunday, January 22, 2017, 12:07:04 AM CET Michael Zoran wrote:
>> > > > I'm not sure if this if the correct place to be asking
>> > > > this.   The
>> > > > RPI
>> > > > 3 running ARM64 is slowly reaching the point of being about to
>> > > > seriously run a 32 bit vender OS like Raspbian.  When running
>> > > > Raspbian,
>> > > > I'm seeing a very large number(thousands) of kernel log
>> > > > messages
>> > > > about
>> > > > deprecated instructions especially setend and barrier
>> > > > instuctions.
>> > > > This can be very annoying and is completely filling the kernel
>> > > > log.
>> > > >
>> > > > I'm considering submitting a patch to add a Kconfig option to
>> > > > disable
>> > > > these warnings with the default being to keep the warnings
>> > > > enabled.  I
>> > > > was wondering if such a patch could be seriously considered.
>> > >
>> > > Could you please provide an example of those warning an what is
>> > > trigging
>> > > those?
>> > >
>> > > Thanks and best regards,
>> > > Alexander
>> >
>> > Sure, here is a snipped from dmesg.  I think this is happening
>> > because
>> > the entire Raspbian OS is compiled with a custom gcc compiler that
>> > is
>> > targeting arm6+VFP.
>> >
>> > I can double check, but I think the instructions are being emulated
>> > in
>> > hardware so they are just filling the log and slowing things down.
>> >
>>
>> You can disable the emulation by doing
>>
>> echo 2 >/proc/sys/abi/setend
>> echo 2 >/proc/sys/abi/cp15_barrier
>
> I don't want to disable the emulation since I want to run old binaries.
>    I just want to disable the warning...
>

That is exactly what this does: the A53 can execute these instructions
just fine, but due to the fact that they are deprecated by the
architecture, they are trapped and emulated by default.

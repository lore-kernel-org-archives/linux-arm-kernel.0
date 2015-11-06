From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 6 Nov 2015 17:55:31 +0900
Subject: [PATCH] ARM: proc-v7: Put stack in data section, handle XIP case
In-Reply-To: <20151106083233.GS8644@n2100.arm.linux.org.uk>
References: <20151106075319.19378.64286.sendpatchset@little-apple>
 <20151106083233.GS8644@n2100.arm.linux.org.uk>
Message-ID: <CANqRtoTqJRhY9zP2z3LKj5CW2ZbNvSTnef9cG3XUAFswYHww2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Nov 6, 2015 at 5:32 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 06, 2015 at 04:53:19PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Adjust the ARM v7 setup code to put the temporary stack in the
>> data section and also use PLAT_PHYS_OFFSET to handle the XIP case.
>>
>> The common case of XIP=n the code is considered to be position
>> independent while for XIP=y PLAT_PHYS_OFFSET is fixed. This
>> is based on that early code in head.S invoking PROCINFO_INITFUNC
>> seems position independent.
>>
>> At this point two places in proc-v7.S make use of the temporary
>> stack so the PLAT_PHYS_OFFSET calculation is duplicated.
>>
>> The XIP=n case has been tested with CPU Hotplug on r8a7779
>> (Cortex A9 Quad) and Chris [CCed] has tested the XIP=y
>> case.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> Tested-by: Chris.Brandt at renesas.com
>
> Sorry, but what's the problem with XIP=n ?  The above seems to avoid
> describing what the problem is there, but it spends an awful lot of
> words describing the XIP=n scenario and few describing the XIP=y
> scenario.

My apologies for the confusing commit message!

There is currently no problem with XIP=n, however to support XIP=y the
temporary stack needs to move into the data section. My plan is doing
that regardless of if XIP is enabled or not, but that makes the XIP=n
case a bit more complex.

If we move the stack into the data section then the "adr" instruction
may no longer be able to perform PC-relative addressing. Which
requires a rework of the code to not rely on "adr". That in turn
requires us to handle that the MMU is disabled. And unless I'm
mistaken the executing environment in case of XIP=n may not execute at
the actual link address, so because of an offset adjustment
calculation is also mandatory.

> I think the commit message needs improving.
>
> Thanks.

Sure, will do! Apart from that, do you agree with the offset
calculation and the duplication of the code? I'd be happy to rework
things if needed.

Thanks,

/ magnus

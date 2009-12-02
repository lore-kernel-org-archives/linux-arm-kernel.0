From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Dec 2009 15:50:57 +0000
Subject: strange, spurious seeming vector exception on pxa300
In-Reply-To: <4B167C69.6060903@comrex.com>
References: <4B159524.2020408@comrex.com>
	<f17812d70912012200m4532317eue21baf5e10925455@mail.gmail.com>
	<f17812d70912012207x28178b1bh98fbf560b6da536@mail.gmail.com>
	<4B167C69.6060903@comrex.com>
Message-ID: <20091202155057.GA30669@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2009 at 09:40:41AM -0500, Yeasah Pell wrote:
> Eric Miao wrote:
>> On Wed, Dec 2, 2009 at 2:00 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>> On Wed, Dec 2, 2009 at 6:13 AM, Yeasah Pell <yeasah@comrex.com> wrote:
>>>> Has anybody ever seen vector exceptions happen on an ARM (xscale, pxa300)
>>>> without 26-bit mode being used? I have some application and kernel code
>>>> which appears to work on most hardware, but we have at least one board which
>>>> causes periodic messages:
>>>>
>>>> Unhandled fault: vector exception (0x010) at 0x412c8a90

FSR=0x010, which decodes as: Read. Domain 1. Status 0.

>>>> (I also fudged the fault handler a bit to dump the SPSR: 0x80000010)

NZCV=1000, 32-bit, user mode.

> There's no 26-bit code in the system that I'm aware of, certainly not in  
> the application where the exception occurs. As you can see from the  
> saved CPSR, the processor isn't in 26-bit mode at the time of the  
> exception anyway. And even if it was, the load is from 0x412c8a90  
> (etc.), not 0x0-0x1f. From what I've seen in the ARM architecture manual  
> (mostly the part that you've copied above), this operation should not be  
> able to cause such an exception, so I'm wondering if there is some  
> alternate condition that can lead to this kind of exception.
>
> In gdb, things look like this (after the SEGV from the fault is received  
> by the target):
>
> (gdb) info registers
> r0             0x0    0
> r1             0x412c8a04    1093437956
> r2             0x0    0
> r3             0x401c57f8    1075599352
> r4             0x4029457c    1076446588
> r5             0x9    9
> r6             0x40390000    1077477376
> r7             0x412c94e0    1093440736
> r8             0x40390150    1077477712
> r9             0x3d0f00    4001536
> r10            0x4037a6bc    1077388988
> r11            0x412c8b84    1093438340

0x412c8a90 (the fault value) + 224 = 0x412c8b84, which is the r11 value.
So that's consistent.

> r12            0x401d6c20    1075670048
> sp             0x412c8a2c    0x412c8a2c
> lr             0x4029603c    1076453436
> pc             0x400ec47c    0x400ec47c <f1+172>
> fps            0x0    0
> cpsr           0x60000010    1610612752

CPSR says NZCV=0110 (zero, carry).  32-bit user mode.

Given that the conditions are clearly wrong for a vector exception, I would
say that you're hitting some kind of hardware bug - maybe caused by a dirty
power supply to the PXA, causing it to misbehave?

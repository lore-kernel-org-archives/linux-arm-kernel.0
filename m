From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu, 8 Jan 2015 13:54:29 -0800
Subject: [RFC] ARM: Make CPU_DCACHE_DISABLE depend on !SMP
In-Reply-To: <54AEA7E0.5070101@gmail.com>
References: <1420683088-1856-1-git-send-email-f.fainelli@gmail.com>
 <2868984.6iP3luxIAM@wuerfel> <20150108115219.GS12302@n2100.arm.linux.org.uk>
 <54AEA7E0.5070101@gmail.com>
Message-ID: <CADtm3G5Ebf6WkHG3fyiY3pm7fEBBNoW3DDEEwpvBXGj0fVE6jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 8, 2015 at 7:53 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Le 08/01/2015 03:52, Russell King - ARM Linux a ?crit :
>> On Thu, Jan 08, 2015 at 09:33:05AM +0100, Arnd Bergmann wrote:
>>> On Wednesday 07 January 2015 18:11:28 Florian Fainelli wrote:
>>>> Enabling CPU_DCACHE_DISABLE on a SMP capable system will prevent the
>>>> kernel from booting because of the following ldrex instruction in
>>>> arch_spin_lock:
>>>>
>>>> (gdb) x/10i $pc
>>>> => 0xc053cfa8 <_raw_spin_lock+4>:       ldrex   r3, [r0]
>>>>    0xc053cfac <_raw_spin_lock+8>:       add     r2, r3, #65536  ; 0x10000
>>>>
>>>> which is taken by the very first printk call:
>>>>
>>>>     at /home/fainelli/work/linux/arch/arm/include/asm/spinlock.h:65
>>>>     fmt=0xc0637650 "\001\066Booting Linux on physical CPU 0x%x\n", args=<incomplete type>)
>>>>     at kernel/printk/printk.c:1525
>>>>     fmt=0xc05370f4 <printk+52> "\024\320\215\342\004\340\235\344\020\320\215\342\036\377/\341\017") at kernel/printk/printk.c:1688
>>>>
>>>> ldrex requires exclusive monitor(s) (local or global) which are no longer
>>>> working when the Data cache is disabled in CP15 and will just hang the CPU
>>>> there.
>>>>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>
>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>
>>> We stumbled on this a while back when Kaixu was trying to fix allmodconfig
>>> builds to run on real hardware, but never submitted it in the end when
>>> Russell didn't like some of the other parts required for that to work.
>>>
>>> This one clearly makes sense independently.
>>
>> What about platforms where exclusives to strongly ordered memory do work?
>
> Do we have a comprehensive list of these platforms?

I haven't had a chance to go through all of the TRMs, but section
A3.4.5 of the ARMv7-A ARM says:

"It is IMPLEMENTATION DEFINED whether LDREX and STREX operations can
be performed to a memory region
with the Device or Strongly-ordered memory attribute. Unless the
implementation documentation explicitly
states that LDREX and STREX operations to a memory region with the
Device or Strongly-ordered attribute are
permitted, the effect of such operations is UNPREDICTABLE ."

>From 6.4.5 "Synchronization primitives" in the Cortex-A15 TRM:

"Use of synchronization primitives on addresses in regions marked as
Strongly-ordered or
Device is UNPREDICTABLE in the ARMv7-A Architecture. Code that makes
such accesses
is not portable."

It looks like this is not generally permissible for ARMv7, maybe
someone else can check the other versions.  Perhaps it would make
sense to disallow disabling the D-cache for !SMP in general and
special-case those architectures which do support exclusives to
strongly ordered memory.

Best regards,
Gregory

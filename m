From: ccross@google.com (Colin Cross)
Date: Tue, 15 Feb 2011 10:20:57 -0800
Subject: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <20110215105050.GA11199@n2100.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
	<AANLkTi=6zLxGxabBE4-+qGyRt7-219KE=4CB0jf9D=LG@mail.gmail.com>
	<AANLkTi=JF1c-aFHpSZ-XECLEPSMsFihXT+w3=NXdYn8L@mail.gmail.com>
	<20110215105050.GA11199@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin3u=2+sbXes-ZvzDM3cRQgJ-Xc7fa8rUZ8Da=r@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 2:50 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 14, 2011 at 08:11:23PM -0800, Colin Cross wrote:
>> Even with a cache flush, cpu_resume_turn_on_mmu fails because the page
>> table modification, done with the cache off, ends up in memory, but
>> the L2 contains the old value. ?When the MMU and cache are enabled,
>> the 1:1 mapping disappears. ?The page table would need to be
>> invalidated during suspend.
>>
>> I can avoid the problem entirely by leaving the MMU on and skipping
>> cpu_resume when the CPU does not go through reset.
>
> If you're not losing CPU state, what's the point in calling the suspend
> function? ?It's purpose is to save CPU state ready for the CPU going to
> sleep and losing power, and restoring that state when the CPU wakes up
> sometime later.

The CPU is going to a state where it may lose power (if the other CPU
enters the same state), or it may get an interrupt before the other
CPU powers down and wake back up again.  In the second case, it has
already called cpu_suspend, so it either needs to return without
calling cpu_resume (which I have working), or cpu_suspend/cpu_resume
needs to work with the L2 cache enabled.

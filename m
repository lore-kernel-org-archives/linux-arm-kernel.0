From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 6 Jun 2011 14:20:00 +0900
Subject: [PATCH] ARM: local timers: Allow boot CPU to have its timer
	running early
In-Reply-To: <20110603085500.GG10532@n2100.arm.linux.org.uk>
References: <1306937006-26597-1-git-send-email-marc.zyngier@arm.com>
	<20110602163152.GH32751@game.jcrosoft.org>
	<1307033815.31098.31.camel@e102391-lin.cambridge.arm.com>
	<4DE7E6AF.4020404@gmail.com>
	<20110603085500.GG10532@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=J2HEnDyS0-vPBg-P9KD4NgK42gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jun 3, 2011 at 5:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jun 02, 2011 at 02:38:23PM -0500, Rob Herring wrote:
>> On 06/02/2011 11:56 AM, Marc Zyngier wrote:
>>> On Thu, 2011-06-02 at 18:31 +0200, Jean-Christophe PLAGNIOL-VILLARD
>>> wrote:
>>>> On 15:03 Wed 01 Jun ? ? , Marc Zyngier wrote:
>>>>> Currently, the boot CPU has its local timer enabled long after
>>>>> the delay loop has been calibrated. This makes it impossible to
>>>>> boot a system that only uses local timers, like the A15.
>>>>>
>>>>> Use late_time_init hook to initialize the boot CPU local timer.
>>>>> Since shmobile is already using this hook, add an ARM specific
>>>>> arm_late_time_init hook that platforms can use instead.
>>>>>
>>>>> Cc: Paul Mundt<lethal@linux-sh.org>
>>>>> Cc: Magnus Damm<magnus.damm@gmail.com>
>>>>> Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
>>>> I propose to switch to early platform devce and earlytimer
>>>>
>>>> this will avoid the arm_late_time_init hook
>>>>
>>>> and will make it cross arch
>>>
>>> I believe this is orthogonal. shmobile (the only ARM user of
>>> late_time_init) is already doing some early_platform stuff for its
>>> timers.
>>>
>>> What I'm trying to achieve here is to make sure the timer on CPU0 is
>>> actually up, running and registered as a clock_event_device before we
>>> hit the delay loop.
>>>
>>> Or maybe I've misunderstood what you're pointing me to?
>>>
>>
>> I believe he is referring to this patch which generically enables the
>> shmobile code for ARM:
>>
>> http://www.spinics.net/lists/arm-kernel/msg123736.html
>>
>> I don't think it has been pulled into mainline yet.
>
> And I really don't like it:
> 1. It adds an additional layer of complexity.
> 2. We end up needing more ways to initialize stuff even earlier in the
> ? kernel boot sequence.
> 3. Tracking down what gets called when becomes a lot harder.
>
> At one time there used to be a good rule to follow: Keep it Simple, Damnit.
> This doesn't follow that.

I'm a big fan of KISS too, and I do agree the early platform code adds
a certain level of complexity. That aside, I believe the benefits of
early platform drivers justify the added complexity.

> And so far, no one has explained _why_ shmobile uses this stuff... so
> my presumption at the moment is that there's no real good reason.

The reason behind the early platform driver code is to reuse part of
the driver model early during boot. The normal driver model allows
platform devices and drivers to split device configuration and the
actual device driver that operates on the device configuration. This
is for instance very useful on SoCs where you have multiple instances
of hardware blocks and you'd like to allow the user to select instance
via platform data and/or kernel command line.

On the sh architecture and on shmobile ARM we use early platform
drivers for timers and for early console support. In practice this
means we allow the kernel to associate device data with a certain
driver before the regular driver model is fully initialized. Early
code is by definition rather fragile, but one nice outcome of all this
is that the serial driver now allows the user to select serial port
instance on the kernel command line. This while the I/O base and IRQ
configuration is kept with per-SoC code and the serial driver is a
slightly enhanced normal platform driver.

There may of course be better ways to achieve what we want, and I am
open to alternative solutions. But so far I have not seen any other
code that allows us to separate device configuration from driver code
early on during boot.

For more information, please have a look at:

commit 13977091a988fb0d21821c2221ddc920eba36b79
Author: Magnus Damm <damm@igel.co.jp>
Date:   Mon Mar 30 14:37:25 2009 -0700

    Driver Core: early platform driver

Cheers,

/ magnus

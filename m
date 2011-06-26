From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 26 Jun 2011 01:00:41 -0600
Subject: [RFC PATCH 2/4] ARM: dt: register local timers as early platform
	devices
In-Reply-To: <4E06513B.4030706@gmail.com>
References: <1308924659-31894-1-git-send-email-marc.zyngier@arm.com>
	<1308924659-31894-3-git-send-email-marc.zyngier@arm.com>
	<20110625204742.GB15026@ponder.secretlab.ca>
	<4E06513B.4030706@gmail.com>
Message-ID: <BANLkTimy6iyQyyvNUK3Kc6skSKyVxBwWPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[cc'ing Russell since discussing addition of early_platform_device to
arm core code]

On Sat, Jun 25, 2011 at 3:20 PM, Rob Herring <robherring2@gmail.com> wrote:
> Grant,
>
> On 06/25/2011 03:47 PM, Grant Likely wrote:
>> On Fri, Jun 24, 2011 at 03:10:57PM +0100, Marc Zyngier wrote:
>>> Use of_early_platform_populate() to collect nodes with the
>>> "localtimer" compatible property and register them with
>>> the early platform "bus".
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>> ?arch/arm/kernel/time.c | ? ?4 ++++
>>> ?1 files changed, 4 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
>>> index 32d0df8..08a28ef 100644
>>> --- a/arch/arm/kernel/time.c
>>> +++ b/arch/arm/kernel/time.c
>>> @@ -25,6 +25,7 @@
>>> ?#include <linux/timer.h>
>>> ?#include <linux/irq.h>
>>> ?#include <linux/platform_device.h>
>>> +#include <linux/of_platform.h>
>>>
>>> ?#include <linux/mc146818rtc.h>
>>>
>>> @@ -156,6 +157,9 @@ static void __init __arm_late_time_init(void)
>>> ? ? ? ? ? ? ?arm_late_time_init();
>>>
>>> ?#ifdef CONFIG_LOCAL_TIMER_DEVICES
>>> +#ifdef CONFIG_OF_FLATTREE
>>> + ? ?of_early_platform_populate("localtimer");
>>> +#endif
>>
>> Rather than #ifdeffing around the function call, it is often cleaner
>> to have an #else in the header file that defines an empty static
>> inline.
>>
>>> ? ? ?early_platform_driver_register_all("localtimer");
>>> ? ? ?early_platform_driver_probe("localtimer", 1, 0);
>>
>> I suggested in my other reply that early_platform_driver should not be
>> used. ?It looks like it is already being used, so I'll back off a bit
>> from that position. ?However, the structure of the code really
>> shouldn't be any different between clock devices being statically
>> declared vs. clock data being obtained from the DT.
>>
>
> It's not really already being used. It is added in Marc's previous patch
> series to move timers to drivers/clocksource.
>
> Deferring driver probe doesn't really help for timers as they have to be
> up early. If early platform drivers shouldn't be used, then why was it
> accepted into the kernel in the first place? It doesn't make sense that
> it is okay for one arch (sh), but not another (arm), ...

There is lots of things in the kernel that aren't necessarily a good
idea.  From what I've seen of early platform devices, I'm not thrilled
with the approach.  If Russell & crew think it is the right solution
for ARM, then I'm not going to make a big stink about it, but I cannot
say I like the model.

>... or that it is okay
> for non-DT, but not for DT.

For registering devices from the DT, it is definitely problematic in a
way that it isn't for non-DT.  When using the DT, how does the
platform know which devices should be registered as 'early' devices?
And once that is done, the population code has then ensure that
devices registered early don't end up with duplicate registrations,
while not difficult, it does complicate both the code and the
conceptual model of registering DT nodes as devices.  I tried to
implement something very similar with of_platform_prepare(), but when
I look at the result I'm just ashamed with myself.


>From bogus@does.not.exist.com  Wed Jun  1 12:03:18 2011
From: bogus@does.not.exist.com ()
Date: Wed, 01 Jun 2011 16:03:18 -0000
Subject: No subject
Message-ID: <mailman.34.1309071675.24103.linux-arm-kernel@lists.infradead.org>

to be dealt with early; timer, irq controller, and lldebug console.

>From bogus@does.not.exist.com  Wed Jun  1 12:03:18 2011
From: bogus@does.not.exist.com ()
Date: Wed, 01 Jun 2011 16:03:18 -0000
Subject: No subject
Message-ID: <mailman.35.1309071675.24103.linux-arm-kernel@lists.infradead.org>

code, and need to be reworked to allow multiplatform kernels.  irq
controllers (or at least the root ones) are initialized with (struct
machine_desc*)->init_irq().  lldebug is currently selected at build
time so that it is available right from head.S.  That's a pretty small
list.  Everything else is just another device, and I don't see
fiddling about with early registration or fiddling with init order to
be a maintainable approach in the long run.  Doing so means that for
each system, someone has to /choose/ which devices are special, and
the decision could be different for each board, and for each kernel
version.  It would be far better to have a driver model that treats
all devices as peers, and is intelligent enough to handle ordering
issues gracefully.

This isn't a big deal for non-DT because using individual board .c
files makes it easy to encode those per-board decisions, whereas the
DT model is a whole lot simpler if a generic & consistent approach can
be used.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

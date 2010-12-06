From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 6 Dec 2010 10:56:36 +0000
Subject: RFC: Dynamic hwcaps
In-Reply-To: <20101205151242.298922ad@surf>
References: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
	<20101205151242.298922ad@surf>
Message-ID: <AANLkTi=3oQDZGuSraXokf7VZ2YaGtaLGud92RcqYFMSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 5, 2010 at 2:12 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hi,
>
> On Fri, 3 Dec 2010 16:28:27 +0000
> Dave Martin <dave.martin@linaro.org> wrote:
>
>> This allows for more active power management of such functional
>> blocks: if the CPU is not fully loaded, you can turn them off -- the
>> kernel can spot when there is significant idle time and do this. ?If
>> the CPU becomes fully loaded, applications which have soft-realtime
>> constraints can notice this and switch to their accelerated code
>> (which will cause the kernel to switch the functional unit(s) on).
>> Or, the kernel can react to increasing CPU load by speculatively turn
>> it on instead. ?This is analogous to the behaviour of other power
>> governors in the system. ?Non-aware applications will still work
>> seamlessly -- these may simply run accelerated code if the hardware
>> supports it, causing the kernel to turn the affected functional
>> block(s) on.
>
> From a power management perspective, is it really useful to load the
> CPU instead of using specialized units which usually provide more
> computing power per watt consumed ?

No--- but you can't in general just exchange cycles on one functional
unit for cycles on another in the same way as you

Suppose 90% if your code (by execution time) can take advantage of a
specialised functional unit.  Should you turn that unit on?

Now, suppose only 5% of the code can take advantage, but the platform
is not completely busy.  Turning on a special functional unit consumes
extra power and will provide no speedup to the user -- is it still
worth turning it on?  What if the CPU is fully loaded doing other work
and your program is close to missing its realtime deadlines -- should
you turn on the separate unit now?

It not an easy thing to judge -- really, I'm just wondering whether
dynamic adaptation is feasible at all and whether it's worth
experimenting with...

> When the CPU is idle, it can enter sleep states to save power and let a
> more specialized unit do the optimized work. For example, when doing
> video decoding, probably specialized DSPs to a much better job from a
> power management perspective than the CPU would do, so it's better to
> keep the CPU idle and let the DSP do its video decoding job. No?

Often, definitely yes; however, it depends on various factors -- not
least, the software must have been ported to make use of the DSP in
order for this to be possible at all.

But the performance and power aspects are not trivial: separate DSP
units tend to have high setup and teardown costs, so as above, if the
total load on the DSP will be low, it may not be worth using it at all
from a power perspective; and using a DSP in the wrong way can also
lead to slower execution than doing everything on the CPU.

Cheers
---Dave

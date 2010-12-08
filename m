From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 8 Dec 2010 11:07:10 +0000
Subject: RFC: Dynamic hwcaps
In-Reply-To: <20101208110105.GR22787@shareable.org>
References: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
	<20101205151242.298922ad@surf>
	<AANLkTi=3oQDZGuSraXokf7VZ2YaGtaLGud92RcqYFMSA@mail.gmail.com>
	<20101208110105.GR22787@shareable.org>
Message-ID: <AANLkTinJ8CPk27iG1007OO1TasSvFx6jne1GYBQToH5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 8, 2010 at 11:01 AM, Jamie Lokier <jamie@shareable.org> wrote:
> Dave Martin wrote:
>> On Sun, Dec 5, 2010 at 2:12 PM, Thomas Petazzoni
>> <thomas.petazzoni@free-electrons.com> wrote:
>> > Hi,
>> >
>> > On Fri, 3 Dec 2010 16:28:27 +0000
>> > Dave Martin <dave.martin@linaro.org> wrote:
>> >
>> >> This allows for more active power management of such functional
>> >> blocks: if the CPU is not fully loaded, you can turn them off -- the
>> >> kernel can spot when there is significant idle time and do this. ?If
>> >> the CPU becomes fully loaded, applications which have soft-realtime
>> >> constraints can notice this and switch to their accelerated code
>> >> (which will cause the kernel to switch the functional unit(s) on).
>> >> Or, the kernel can react to increasing CPU load by speculatively turn
>> >> it on instead. ?This is analogous to the behaviour of other power
>> >> governors in the system. ?Non-aware applications will still work
>> >> seamlessly -- these may simply run accelerated code if the hardware
>> >> supports it, causing the kernel to turn the affected functional
>> >> block(s) on.
>> >
>> > From a power management perspective, is it really useful to load the
>> > CPU instead of using specialized units which usually provide more
>> > computing power per watt consumed ?
>>
>> No--- but you can't in general just exchange cycles on one functional
>> unit for cycles on another in the same way as you
>>
>> Suppose 90% if your code (by execution time) can take advantage of a
>> specialised functional unit. ?Should you turn that unit on?
>>
>> Now, suppose only 5% of the code can take advantage, but the platform
>> is not completely busy. ?Turning on a special functional unit consumes
>> extra power and will provide no speedup to the user -- is it still
>> worth turning it on? ?What if the CPU is fully loaded doing other work
>> and your program is close to missing its realtime deadlines -- should
>> you turn on the separate unit now?
>
> I think Thomas's point is that doing the 5% on the CPU may consume
> more power than turning on the special functional unit - even when
> the system is not busy and the user doesn't see a time difference.
>
> I don't know if that's true for available hardware, but it seems like
> it's worth investigating before taking the idea further.

Agreed -- either could be the case.  It's something you can never be
certain about without doing some measurements...

Cheers
---Dave

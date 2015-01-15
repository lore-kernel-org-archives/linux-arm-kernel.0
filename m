From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Jan 2015 10:26:45 +0100
Subject: [PATCH v2 1/5] irqchip: add dumb demultiplexer implementation
In-Reply-To: <alpine.DEB.2.11.1501151003430.5526@nanos>
References: <1421174781-4340-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421174781-4340-2-git-send-email-boris.brezillon@free-electrons.com>
 <CAL_JsqJ5DSo6jmAuHPDdV6pMca8BVbg5V-GZ5=2qu96_QYXMtQ@mail.gmail.com>
 <alpine.DEB.2.11.1501141110190.5526@nanos>
 <CAL_JsqLwBvV5s531_YsA=sCE4_LG=eXTua8mh069ufRjSNFhng@mail.gmail.com>
 <alpine.DEB.2.11.1501151003430.5526@nanos>
Message-ID: <54B787D5.9070408@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 15/01/2015 10:11, Thomas Gleixner a ?crit :
> On Wed, 14 Jan 2015, Rob Herring wrote:
>> On Wed, Jan 14, 2015 at 4:36 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> All attempts to work around that have resulted in horrible bandaids so
>>> far. That's why I guided Boris to implement this dummy demultiplexing
>>> mechanism. It solves the problem at hand nicely without adding nasty
>>> hackarounds into the suspend/resume code and inflicting platform
>>> knowledge on multi-platform device drivers.
>>
>> This change will break on old kernels with a new dtb. Would you be
>> happy if a BIOS update required a new kernel? Fixing this for any
>> platform requires a dtb update which may not be possible on some
>> platforms. I don't have a problem with this breakage for 1 platform
>> and the at91 guys may not care, but we'd ultimately be changing how
>> all shared irqs are specified for all DT. Maybe we decide that this is
>> how we want to describe things, but that needs much wider discussion
>> and agreement.
> 
> We do not change shared interrupts in any way. We provide an
> alternative mechanism for braindead hardware. And if the at91 folks

Let me add subtle details: "Old braindead hardware, with possibility to
use alternative set of timers which doesn't have shared interrupt lines" ;-)

> are fine with the DT change, then it's their decision. Nothing forces
> this on everyone.

Yes I do agree to change DT.

>>> If you have a proper solution for the problem at hand which
>>>
>>>    - avoids the demux dummy
>>>
>>>    - works straight forward with suspend/resume/wakeup
>>>
>>>    - does not add horrible new APIs
>>>
>>>    - does not add conditionals to the interrupt hotpath
>>>
>>>    - does not inflict platform knowledge about interrupt chip details
>>>      on drivers
>>>
>>> then I'm happy to take it.
>>>
>>> But as long as you can't come up with anything sane, the demux dummy
>>> is the best solution for this problem we've seen so far.
>>
>> What if during suspend you move all actions w/o IRQF_NO_SUSPEND to a
>> suspended action list? This would leave only the actions with
>> IRQF_NO_SUSPEND set in the active action list. The cost would be a
>> pointer in irq_desc and moving the actions during suspend and resume.
> 
> That's exactly what we want NOT. Because it prevents us to do proper
> sanity checks for IRQF_NO_SUSPEND. We've been there and I rejected it
> for that very reason.
>  
>> There are probably ways to do this demux irqchip without a DT change.
> 
> What's the problem with a DT change for a single platform, if the
> maintainers are willing to take it and deal with the fallout?
> 
> And in case of AT91 the new kernel will simply work with the old DT
> and just emit the same warning vs. the IRQF_NO_SUSPEND mismatch. Older
> kernels won't work with a new DT, but that's about it.
> 
> Aside of that, I'm quite amused about your DT update worries. DTs
> break with every kernel version on very popular platforms in very
> weird and subtle ways.

DT on AT91 is a Work In Progress (for 3.5 years) and the facts have told
us that DT updates were absolutely necessary. So, for now, I agree to
change DT as far as AT91 is concerned.

Bye,
-- 
Nicolas Ferre

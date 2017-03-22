From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 22 Mar 2017 16:17:32 +0000
Subject: [PATCH v3 3/5] coresight: add support for debug module
In-Reply-To: <CAJ9a7VhvCS3xXAHBt0AUVB2Zp2P1HP_LQm4KiptiBT9VJ1fC0Q@mail.gmail.com>
References: <1488520809-31670-1-git-send-email-leo.yan@linaro.org>
 <1488520809-31670-4-git-send-email-leo.yan@linaro.org>
 <671a0b39-b635-6e0e-d3fa-967651f2e29c@arm.com>
 <CAJ9a7VgCjXNGC4C49PxL-nBxzhMCmA8Mb-0C_epahizA5EL2HA@mail.gmail.com>
 <e7a97c52-f61a-e503-f626-09563fa100b8@arm.com>
 <CAJ9a7VhvCS3xXAHBt0AUVB2Zp2P1HP_LQm4KiptiBT9VJ1fC0Q@mail.gmail.com>
Message-ID: <4961636d-d77c-0f9a-7076-4db1ef456073@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/03/17 15:45, Mike Leach wrote:
> On 22 March 2017 at 14:07, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 22/03/17 12:54, Mike Leach wrote:
>>>
>>>
>>> On 21 March 2017 at 15:39, Sudeep Holla <sudeep.holla@arm.com
>>> <mailto:sudeep.holla@arm.com>> wrote:
>>>
>> [...]
>>
>>> I disagree with this approach. One of the main usefulness of such
>>> self hosted debug feature is to debug issues around features like
>>> cpuidle. Adding constraints like "cpuidle needs to be disabled" is
>>> not good IMO. There are ways to make it work with cpuidle enabled.
>>> Please explore them. In particular refer H9.2.39 EDPRCR, External
>>> Debug Power/Reset Control Register.
>>>
>>> So, "nohlt" option is not an option. I prefer some sysfs option like
>>> Suzuki suggested to enable this feature on demand if power saving in
>>> normal usecase is the concern. Using "nohlt" just disables idle and
>>> doesn't ensure the debug power domain is ON. Using the flag directly
>>> in this driver to enable debug power domain also sounds misuse of
>>> that flag for me.
>>>
>>> I think the key issue to remember here is that experience with
>>> external debug shows that CPU Idle means different things to
>>> different SoC designs / power management schemes. (and we are using
>>> external debug in a self hosted way here).
>>>
>>
>> Yes agreed on the point that meaning of "cpuidle" differs on each SoC.
>>
>>> Some designs will power down an entire cluster if all CPUs on the
>>> cluster are powered down - including the parts of the debug
>>> registers that should remain powered in the debug power domain.
>>
>> Interesting, at-least ETMv4 or some other coresight specification
>> clearly classify the power domains and the register access. The actual
>> power domain itself may vary depending on implementation.
> 
> Yes - the ETMv4 spec defines what should be in the core / debug power
> domains, but there is no architectural requirement for these to be
> separate.
> Most of power management is "implementation defined", & hw designers
> seem to have different criteria than sw engineers wanting to debug
> stuff.
> 

Yes I agree, no argument there.

>>> The bits in EDPRCR are not respected in these cases - these designs
>>> do not really support debug over power down in the way that the
>>> CoreSight / Debug designers anticipated. This means that even
>>> checking EDPRSR has the potential to cause a bus hang if the target
>>> register is unpowered. (and if the debug power domain is unpowered
>>> then the PC data is also lost).
>>>
>>
>> Agreed, but can we start supporting the sane designs in sane way first.
>> We can always add compatible and handle deviations. I agree we may need
>> to support such deviations but starting with that seems setting a bad
>> example.
>>
> 
> From a pragmatic point of view, we have to support the designs that we
> have and are currently using.
> Sadly this might include some that do not behave in an ideal way.
> 

We will have to support them. But I don't want that to be defacto
standard. They should be treated as deviations. Though specification
says the behavior is IMPDEF, it does provide standard interface(EDPRCR)
to use and we should have that in the driver IMO.

> I'm not saying disabling CPUIdle is right for all cases, or perhaps
> many, but it has in the past been useful in specific instances - not
> just for external debug, 

Yes I know but that's either issue with the firmware or the debugger
and we can work them around in user-space too instead of baking the
solution to kernel.

> but to use CoreSight trace etc, were powering
> down the a CPU / cluster takes out ETM accesses and breaks stuff.
> 

FYI, I added support in ETMv4 to emulate power-down during active trace
session and so far I have not seen any report on things breaking because
of that register access(may be no one has tested it on other platforms
yet :()

> The key is that to use this driver, the user has to be aware of the PM
> implications on their specific system - the kernel may not take care
> of it all for them - as SCP type power controllers are often external
> and may have unique firmware and capabilites.
> 

Sure

> Historically CPUIdle disable has been used as a blunt instrument to
> handle power management problems in real debug use cases - but it is
> one that has been successful. Where there are better methods then I am
> all for using these.
> 

Cool, thanks. Lets try out that and see if it helps first before bluntly
advertising CPUIdle disabling and that too in misleading ways like "nohlt"

>>> In these cases, accessing to the debug registers while they are not
>>> powered is a recipe for disaster - so preventing CPUIdle and the
>>> subsequent cluster power down allows investigation on this class of
>>> system - and allowing the CPUs of interest be interrogated without
>>> hanging the crash log process.
>>>
>>
>> Agreed. But my point is that many issues are around cpuidle and some
>> usecase and just eliminating that use-case sounds bad. For me,
>> core-sight was most useful to debug issues around cpu power management
>> and lockups where we can't stop cores but examine these registers.
>> There are other alternatives for other use-cases IMO.
> 
> For your case, removing what you are interested in debugging is
> evidently counter productive, so other techniques need to be used to
> ensure the CS regs remain alive.
> But equally there could be use cases where this might be just fine or
> even the only way.
>

Again not arguing on that. Just saying we can try out if that solves the
issue. As I said there are other ways to disable idle and we can
advertise those instead of such misuse. Also those alternative methods
are runtime and can be used when you need them.

>>>
>>> On systems that do behave correctly with respect to debug power
>>> domains, then disabling CPUIdle is unnecessary - these can be
>>> controlled by EDPRCR - perhaps; per the specification it is
>>> "implementation defined" if writing bits to this register have an
>>> effect on the system anyway even if the debug domain is correctly
>>> powered.
>>>
>>
>> We can always do that unconditionally. If implementations don't honor
>> those bits, it's different. If they hang on accessing something which is
>> on debug power domain and not on core power domain, then you have much
>> bigger issue to solve. How can you even trust and make any other
>> register accesses that are in debug power domain then ?
>>
> 
> It is difficult and highly platform dependent. For external debug we
> might have per-platform rules built into the debugger on what can and
> cannot be done and when, plus on occasion some power management
> scripts. Those platforms that get closest to the "standard" CoreSight
> power management are easiest to debug.
> 

Absolutely, so just mandating might just solve issue *accidentally*
not *intentionally*. So I don't want it to be advertised in that way
and that becomes defacto.

[...]
> 
> I'm not advocating /nohlt above anything else - it's just what is
> being discussed here. Furthermore, no one debug technique is ever
> going to be appropriate in all circumstances - debug and trace are
> always a compromise.
> 

True.

> I initially raised the issue of clusters powering down, and
> possibility that no CPUIdle might prevent this, to ensure that
> awareness is built in to driver / config / help text /documentation
> that these are real issues seen in the external debug world.
> 

Point taken. So we could just specify that all necessary power domains
need to be on for proper functionality for this feature and that it's
highly platform specific instead of mixing cpu/cluster idle details here.

> The key point is that the caveat in using this driver is that the
> power management has to be considered on a platform specific basis
> before it is configured; and appropriate actions may be needed for it
> to work correctly. Without this then the driver could cause more
> issues than it debugs. A user selecting this _must_ be told about
> these issues
> 

Exactly and the help text could be something on the similar lines as you
mention/summarize above.

-- 
Regards,
Sudeep

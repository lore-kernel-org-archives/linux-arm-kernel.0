From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Mar 2017 13:51:47 +0000
Subject: [PATCH v2 06/18] arm64: arch_timer: Add infrastructure for
 multiple erratum detection methods
In-Reply-To: <20170323173030.GA24630@mai>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
 <20170320174829.28182-7-marc.zyngier@arm.com> <20170322154114.GE30499@mai>
 <a922484a-1bb0-cfd0-1996-fab026a4feae@arm.com> <20170323173030.GA24630@mai>
Message-ID: <5e8faa45-bb1b-fd9b-f34f-93ce5babb0a3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 23/03/17 17:30, Daniel Lezcano wrote:
> On Wed, Mar 22, 2017 at 03:59:21PM +0000, Marc Zyngier wrote:
>> [Sorry, sent too quickly]
>>
>> On 22/03/17 15:41, Daniel Lezcano wrote:
>>> On Mon, Mar 20, 2017 at 05:48:17PM +0000, Marc Zyngier wrote:
>>>> We're currently stuck with DT when it comes to handling errata, which
>>>> is pretty restrictive. In order to make things more flexible, let's
>>>> introduce an infrastructure that could support alternative discovery
>>>> methods. No change in functionality.
>>>>
>>>> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>  arch/arm64/include/asm/arch_timer.h  |  7 +++-
>>>>  drivers/clocksource/arm_arch_timer.c | 80 +++++++++++++++++++++++++++++++-----
>>>>  2 files changed, 75 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>>>> index b4b34004a21e..5cd964e90d11 100644
>>>> --- a/arch/arm64/include/asm/arch_timer.h
>>>> +++ b/arch/arm64/include/asm/arch_timer.h
>>>> @@ -37,9 +37,14 @@ extern struct static_key_false arch_timer_read_ool_enabled;
>>>>  #define needs_unstable_timer_counter_workaround()  false
>>>>  #endif
>>>>  
>>>> +enum arch_timer_erratum_match_type {
>>>> +	ate_match_dt,
>>>> +};
>>>>  
>>>>  struct arch_timer_erratum_workaround {
>>>> -	const char *id;		/* Indicate the Erratum ID */
>>>> +	enum arch_timer_erratum_match_type match_type;
>>>
>>> Putting the match_fn instead will be much more simpler and the code won't
>>> have to deal with ate_match_type, no ?
>>
>> I'm not sure about the "much simpler" aspect. Each function is not
>> necessarily standalone (see patches 8 and 13 for example, dealing with
>> CPU-local defects).
> 
> Hi Marc,
> 
> I have been through the driver after applying the patchset. Again thanks for
> taking care of this. It is not a simple issue to solve, so here is my minor
> contribution.
> 
> The resulting code sounds like over-engineered because the errata check and its
> workaround are done at the same place/moment, that forces to deal with an array
> with element from different origin.
> 
> I understand you wanted to create a single array to handle the errata
> information from the DT, ACPI and CAPS. But IMHO, it does not fit well.
> 
> I would suggest to create 3 arrays: ACPI, DT and CAPS.
> 
> Those arrays contains the errata id *and* an unique private id.
> 
> At boot time, you go through the corresponding array and fill a list of
> detected errata with the private id.
> 
> On the other side, an array with the private id and its workaround makes the
> assocation. The private id is the contract between the errata and the workaround.
> 
> So the errata handling will occur in two steps:
>  1. Boot => errata detection
>  2. CPU up => workaround put in place
> 
> With this approach, you can write everything on a per cpu basis, getting rid of
> 'global' / 'local'.
> 
> What is this different from your approach ?
> 
>  - no match_id
>  - clear separation of errata and workaround
>  - Simpler code
>  - clear the scene for a more generic errata framework
> 
> That said, now it would make sense to create a generic errata framework to be
> filled by the different arch at boot time and retrieve from the different
> subsystem in an agnostic way. Well, may be that is a long term suggestion.
> 
> What do you think ?

I don't think this buys us anything at all. Separating detection and
enablement is not always feasible. In your example above, you assume
that all errata are detectable at boot time. Consider that with CPU
hotplug, we can bring up a new core at any time, possibly with an
erratum that you haven't detected yet.

And even then, what do we get: we trade a simple match ID for a list we
build at runtime, another private ID, and additional code to perform
that match. The gain is not obvious to me...

What would such a generic errata framework look like? A table containing
match functions returning a boolean, used to decide whether you need to
call yet another function with a bunch of arbitrary parameters.

In my experience, such a framework will be either an empty shell
(because you need to keep it as generic as possible), or will be riddled
with data structures ending up being the union of all the possible cases
you've encountered in the kernel. Not a pretty sight.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

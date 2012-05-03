From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 3 May 2012 09:01:46 +0200
Subject: [PATCH] arm: omap: Use only valid power domain states
In-Reply-To: <20120502220420.GA19579@animalcreek.com>
References: <1335821126-12994-1-git-send-email-mgreer@animalcreek.com>
 <CAORVsuUJQOL-aTaGdo6VsOGm3ZHU=nWinQYrP70Lx0kG6G34TQ@mail.gmail.com>
 <20120502220420.GA19579@animalcreek.com>
Message-ID: <CAORVsuUD6sHn+mDLQDLVD-K_JngcxY-BrVT8KQACd+9Z5s_SGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, May 3, 2012 at 12:04 AM, Mark A. Greer <mgreer@animalcreek.com> wrote:
> On Tue, May 01, 2012 at 10:47:35AM +0200, Jean Pihet wrote:
>> Hi Mark,
>
> Hi Jean. ?Thanks for the review.
>
>> On Mon, Apr 30, 2012 at 11:25 PM, Mark A. Greer <mgreer@animalcreek.com> wrote:
>> > From: "Mark A. Greer" <mgreer@animalcreek.com>
>
>> > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
>> > index 5358664..2c91711 100644
>> > --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> > @@ -175,19 +175,25 @@ static int next_valid_state(struct cpuidle_device *dev,
>> > ? ? ? ?struct cpuidle_state_usage *curr_usage = &dev->states_usage[index];
>> > ? ? ? ?struct cpuidle_state *curr = &drv->states[index];
>> > ? ? ? ?struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr_usage);
>> > - ? ? ? u32 mpu_deepest_state = PWRDM_POWER_RET;
>> > - ? ? ? u32 core_deepest_state = PWRDM_POWER_RET;
>> > + ? ? ? u32 mpu_deepest_state, mpu_deepest_possible;
>> > + ? ? ? u32 core_deepest_state, core_deepest_possible;
>> > ? ? ? ?int next_index = -1;
>> >
>> > + ? ? ? mpu_deepest_possible = pwrdm_get_deepest_state(mpu_pd);
>> > + ? ? ? mpu_deepest_state = max_t(u32, mpu_deepest_possible, PWRDM_POWER_RET);
>> I do not think you need to change the pwrdm API and the cpuidle code for that.
>> Instead you should use the pwrst* fields in the power domains data
>> files, which allow to specify the allowed states.
>> After reading the rest of your patches it seems you are addressing the
>> issue in a subsequent patch 'arm: omap3: am35x: Set proper powerdomain
>> states'.
>
> That patch sets the allowable power domain states for the am35x; the intent
> of this patch was to make the code respect what is set in the pwrst* fields.
>
>> > diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>> > index 96ad3dbe..9c80c19 100644
>> > --- a/arch/arm/mach-omap2/powerdomain.c
>> > +++ b/arch/arm/mach-omap2/powerdomain.c
>> > @@ -1078,3 +1078,28 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
>> >
>> > ? ? ? ?return 0;
>> > ?}
>> > +
>> > +/**
>> > + * pwrdm_get_deepest_state - Get deepest valid state domain can enter
>> > + * @pwrdm: struct powerdomain *
>> > + *
>> > + * Find and return the deepest valid state a power domain can be in.
>> > + * Returns the deepest state that @pwrdm can enter.
>> > + */
>> > +u32 pwrdm_get_deepest_state(struct powerdomain *pwrdm)
>> > +{
>> > + ? ? ? u32 valid_states, deepest_state;
>> > +
>> > + ? ? ? valid_states = pwrdm->pwrsts;
>> > +
>> > + ? ? ? if (valid_states & PWRSTS_OFF)
>> > + ? ? ? ? ? ? ? deepest_state = PWRDM_POWER_OFF;
>> > + ? ? ? else if (valid_states & PWRSTS_RET)
>> > + ? ? ? ? ? ? ? deepest_state = PWRDM_POWER_RET;
>> > + ? ? ? else if (valid_states & PWRSTS_INACTIVE)
>> > + ? ? ? ? ? ? ? deepest_state = PWRDM_POWER_INACTIVE;
>> > + ? ? ? else
>> > + ? ? ? ? ? ? ? deepest_state = PWRDM_POWER_ON;
>> > +
>> > + ? ? ? return deepest_state;
>> > +}
>>
>> The pwrdm API already performs those checks on pwrst*, cf.
>> pwrdm_set_next_pwrst for example.
>
> Well, sort of. ?pwrdm_set_next_pwrst() fails if its an invalid state
> returning -EINVAL. ?Very few of the callers actually check to see if
> it failed so they don't try the "next-one-up" power state. ?The net
> result is that the next state doesn't change even though it could
> move to a lower state (just not the one that was asked for).
>
> Is that acceptable?
No that is not acceptable. In fact the next power state should only be
set using omap_set_pwrdm_state, which falls back to the next valid
power state. Note: my latest patches about the functional power states
is using omap_set_pwrdm_state as the only function to set the power,
logic states.

> Another sort of strange one is omap3_pm_off_mode_enable(). ?If its
> called with 'enable' set and PWRDM_POWER_OFF isn't a valid state,
> omap_set_pwrdm_state() will return 0 and leave the next state alone.
> When omap3_pm_off_mode_enable() is called again with 'enable' set,
> omap_set_pwrdm_state() will find the lowest valid state >= RET.
> So, if you had a device where OFF wasn't valid but RET was and
> its currently ON, when the user enables OFF mode, it stays ON
> and when they disable OFF mode, it moves to RET.
>
> Is that acceptable?
No. omap_set_pwrdm_state should be fixed in that case.
In fact the enable_off_mode flag is scheduled for removal in favor of
the PM QoS constraints.

> If the things above are acceptable, then I think you're right, we can
> forget this patch. ?FYI, the am35x appears to work okay and no invalid
> states are entered (according to /sys/kernel/debug/pm_debug/count)
> without this patch.
I think we should fix the existing code if it has problems, not add
more specific code.

Kevin, what is your take on this?

> Mark

Regards,
Jean

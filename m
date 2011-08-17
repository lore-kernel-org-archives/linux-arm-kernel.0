From: santosh.shilimkar@ti.com (Santosh)
Date: Wed, 17 Aug 2011 21:45:27 +0530
Subject: [PATCH 03/17] ARM: gic: Use cpu pm notifiers to save gic state
In-Reply-To: <CAMbhsRQX+faGH9xPZPQKrtq5=Rb8JhRLo0ibJ1cOfTHrLRjw9A@mail.gmail.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>	<1310053830-23779-4-git-send-email-lorenzo.pieralisi@arm.com>	<4E27E40C.6020006@ti.com>	<20110721102736.GA3087@e102568-lin.cambridge.arm.com>	<4E2803A1.7000908@ti.com>	<CAMbhsRRT58vJWJ0ACSp_NJsvQJqzeBUKDD5bGGWM6tYh-zTxJQ@mail.gmail.com>	<4E290663.30403@ti.com>
	<CAMbhsRQX+faGH9xPZPQKrtq5=Rb8JhRLo0ibJ1cOfTHrLRjw9A@mail.gmail.com>
Message-ID: <4E4BE91F.1000102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin,

On Friday 22 July 2011 10:51 AM, Colin Cross wrote:
> On Thu, Jul 21, 2011 at 10:10 PM, Santosh Shilimkar

[....]

>>>> For my OMAP4 PM rebasing, for time-being I will go with exported
>>>> GIC functions so that I don't have too many redundancies with GIC
>>>> save/restore code.
>>>
>>> I think you should try to balance cpu idle latency with reuse of
>>> common code.  In this case, you are avoiding restoring 7 registers by
>>> reimplementing the bare minimum that is necessary for OMAP4, which is
>>> unlikely to make a measurable impact on wakeup latency.  Can you try
>>> starting with reusing all the common code, and add some timestamps
>>> during wakeup to measure where the longest delays are, to determine
>>> where you should diverge from the common code and use omap-optimized
>>> code?
>>
>> I am going to use all the common code but having them exported
>> functions gives more flexibility to call them in right and needed
>> places. As discussed earlier, I plan to use the common GIC code
>> wherever it's needed on OMAP.
>>
>> My main point was we are saving and restoring GIC CPU interface
>> registers for a case where they are actually not lost.
>
> Yes, but you're still avoiding 7 registers, which is unlikely to be
> worth the complexity of calling these functions differently from every
> other platform.

I managed to use pm notifiers for GIC and VFP on OMAP4 and
get that working. As discussed here, I decided to take the
hit on the latency in favour of re-use of the code for GIC
considering it's helping other platforms.

I did update notifiers patches for couple of things.

- VFP code now make use 'vfp_current_hw_state' instead of
'last_VFP_context'

- I have renamed CPU_COMPLEX to more appropriate CPU_CLUSTER

- I have dropped GIC dist. disable as part of GIC dist save
code. I saw lock ups with CPUIDLE and then tracked down, to
an issue where for some reason if cluster doesn't hit the
targeted low power state, CPU gets locked up since GIC
dist. remains disabled. The GIC restore is done only if
the cluster did hit the deeper state and GIC lost it's
context. As such this change should not impact anything.

What's your plan on these notifiers patches considering
there is a request to make them generic and not just ARM
specific?

Sorry for asking this but now I have dependency on this
series :)
If you want, I can participate here to get this moving.
Let me know.

Regards
Santosh

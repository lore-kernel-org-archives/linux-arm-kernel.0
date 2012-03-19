From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 19 Mar 2012 19:44:30 +0800
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
In-Reply-To: <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com>
 <87mx9ej8fp.fsf@ti.com>
 <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
Message-ID: <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 7:11 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
>
> I think you made very good point here. With the above patch, we are almost missing the capability of registering dmtimer as a clocksource for OMAP.
> It will always use 32k-counter, and never fall back to dmtimer.
>
> Then the only options we have here is,
>
> 1) Register both the timers, 32k-counter and dmtimer for clocksource; let
> ? Kernel pick up best rating clocksource out of these two.
>
> ? In case of OMAP1/2/3/4, kernel will use dmtimer, since it has better
> ? Rating. User can choose the 32k-counter clocksource via bootargs.
>
> ? Impact: without bootargs for clocksource selection, kernel will choose
> ? ? dmtimer, impacting loss of time during suspend/resume.
>
>
> 2) Let the current code be as is, means, the clocksource registration will
> ? Happened based on "#ifdef CONFIG_OMAP_32K_TIMER" and this option
> ? selection will be Controlled by Kconfig rules.

How about the 3rd option?

3), take the way in your patch 1) at default, but will switch to
register dmtimer
directly and bypass 32k-counter if user need it via kernel parameter.

As far as I can think of, the situations required for dmtimer are high-frequency
perf sample and high precision trace points, so looks it is OK to take
32k-counter
at default.

Thanks,
-- 
Ming Lei

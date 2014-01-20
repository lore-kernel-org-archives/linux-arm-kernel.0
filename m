From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 20 Jan 2014 14:56:33 +0000
Subject: [PATCH] arch_timer: Move delay timer to drivers clocksource
In-Reply-To: <52DD35C2.3070809@linaro.org>
References: <20140116121649.GG30257@mudshark.cambridge.arm.com>
 <878uufyo13.fsf@iki.fi> <52D8F403.9070602@linaro.org>
 <52D901B6.1070800@nvidia.com> <52D902D6.3090208@linaro.org>
 <52D915F3.3030500@nvidia.com> <52D91D3A.80800@linaro.org>
 <52D932B5.7020909@nvidia.com> <52D97831.6030700@codeaurora.org>
 <52DD35C2.3070809@linaro.org>
Message-ID: <20140120145633.GA2725@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 02:42:10PM +0000, Daniel Lezcano wrote:
> On 01/17/2014 07:36 PM, Stephen Boyd wrote:
> > On 01/17/14 05:40, Prashant Gaikwad wrote:
> >>
> >> Another requirement:
> >>
> >> We have 3 timers T1, T2, T3 used as wake events for 3 idle states C1,
> >> C2, C3 respectively.
> >>
> >> Rating of T2 is better than T3. If I register T2 and T3 both as
> >> broadcast timers then T3 will not be used. But ...
> >>      - T2 is not preserved in C3 idle state.
> >>      - T3 resolution is very poor (ms) and can not be used as wake
> >> event for C2.
> >>
> >> Possible solution, register only T3 as broadcast device and use T2 as
> >> per-CPU fallback timer.
> >
> > We have the same situation on MSM. I've been thinking about proposing we
> > allow multiple broadcast timers to exist in the system and then have the
> > clockevents_notify() caller indicate which C state is being entered. The
> > broadcast timers would need to indicate which C state they don't work in
> > though.
> 
> IMO, there are different solutions:
> 
> 1. extend the C3STOP to C1STOP, C2STOP, etc ... and pass the idle state 
> to the time framework where these flags are checked against. I don't 
> like this approach but it is feasible.
> 
> 2. use the generic power domain. When the power domain is shutdown via 
> the cpuidle backend driver, it switches the timer.

IMO, 2 is the way forward. It is the only solution that links resources to
the reason they need maintainance (ie power management). I am writing
v2 of C-state proposal where power domains are explicitly associated with
devices (eg arch timers), and 2 fits well with this approach.

Lorenzo

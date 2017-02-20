From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Mon, 20 Feb 2017 20:56:44 +0800
Subject: [PATCH 1/5] arm64: dts: Add basic DT to support Spreadtrum's
 SP9860G
In-Reply-To: <c28ee4e9-9abe-c019-2439-f9cb239b67e9@arm.com>
References: <1487063952-7113-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1487063952-7113-2-git-send-email-chunyan.zhang@spreadtrum.com>
 <CAPKp9ub35nL8gc_TKx02pSHHNwBhiMacWL=CuEmNGnecWikfGQ@mail.gmail.com>
 <20170217072839.GA8767@spreadtrum.com>
 <b5940598-f3e7-b2c5-9914-7bcbe3471f9e@arm.com>
 <20170220093750.GA9600@spreadtrum.com>
 <c28ee4e9-9abe-c019-2439-f9cb239b67e9@arm.com>
Message-ID: <20170220125644.GB9600@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?,  2? 20, 2017 at 10:47:56?? +0000, Sudeep Holla wrote:
> 
> 
> On 20/02/17 09:37, Chunyan Zhang wrote:
> > Hi Sudeep,
> > 
> > On ?,  2? 17, 2017 at 10:28:00?? +0000, Sudeep Holla wrote:
> >>
> >>
> >> On 17/02/17 07:28, Chunyan Zhang wrote:
> >>> Hi Sudeep,
> >>>
> >>> On ?,  2? 14, 2017 at 04:44:53?? +0000, Sudeep Holla wrote:
> >>>> On Tue, Feb 14, 2017 at 9:19 AM, Chunyan Zhang
> >>>> <chunyan.zhang@spreadtrum.com> wrote:
> >>
> >> [..]
> >>
> >>>>
> >>>>> +       idle-states{
> >>>>> +               entry-method = "arm,psci";
> >>>>> +
> >>>>> +               CORE_PD: core_pd {
> >>>>> +                       compatible = "arm,idle-state";
> >>>>> +                       entry-latency-us = <1000>;
> >>>>> +                       exit-latency-us = <700>;
> >>>>> +                       min-residency-us = <2500>;
> >>>>> +                       local-timer-stop;
> >>>>> +                       arm,psci-suspend-param = <0x00010002>;
> >>>>> +               };
> >>>>> +
> >>>>> +               CLUSTER_PD: cluster_pd {
> >>>>> +                       compatible = "arm,idle-state";
> >>>>> +                       entry-latency-us = <1000>;
> >>>>> +                       exit-latency-us = <1000>;
> >>>>> +                       min-residency-us = <3000>;
> >>>>> +                       local-timer-stop;
> >>>>> +                       arm,psci-suspend-param = <0x01010003>;
> >>>>> +               };
> >>>>> +
> >>>>> +               DEEP_SLEEP: deep_sleep {
> >>>>> +                       compatible = "arm,idle-state";
> >>>>> +                       wakeup-latency-us = <0xffffffff>;
> >>>>
> >>>> A value > 4294 seconds(i.e >1 hour) seems suspicious.
> >>>> Are you working around the firmware issue with high latency value so
> >>>> that it's never entered ? Why not remove advertising the state from DT.
> >>>>
> >>>
> >>> Haved checked with related colleagues, this node 'deep_sleep' was not for working
> >>> around any firmware issue, but was a trick utilization of idle subsystem, and that
> >>
> >> Really ? Any latency greater few milliseconds are sounds useless. I
> >> still don't understand what you mean by "trick utilization of idle
> >> subsystem".
> >>
> > 
> > Sorry for confused expression, I meant it was not a right way to utilize idle mechanism
> > and shouldn't be upstreamed.
> > 
> 
> No problem.
> 
> >>> was definitely not elegant, the author indeed intendly didn't want CPU entered this
> >>> state, I will remove this node therefore.
> >>
> >> It's quick and dirty "HACK* to retain and advertise the state but
> >> ensure it's never entered and obstruct the boot. It's not a trick to
> >> exploit any idle subsystem utilization.
> >>
> > 
> 
> > Right, actually deep_sleep was for 'suspend' (forces idleness upon 
> > the OS until a wake-up event resumes the OS from suspend), for 
> > example when users press power key on mobile phone to turn off the
> > screen. So the author implemented 'suspend' using cpu_psci_ops::cpu_suspend
> > I figure that this  way is not correct, I will remove this state from DT.
> 
> OK.
> 
> > I would appreciate any suggestion for how to implement this kind of
> > function properly.
> 
> 
> For the 'suspend' functionality you have described above, all you need
> is the firmware to implement PSCI SYSTEM_SUSPEND API in the firmware.
> The kernel psci driver detects the presence of the same and registers
> the suspend ops automatically. You need not add anything in the code or
> DT for the same.

Thank you Sudeep, I will have my colleague to study further according to
the direction you provided here.

Thanks for your comments,
Chunyan

> 
> -- 
> Regards,
> Sudeep

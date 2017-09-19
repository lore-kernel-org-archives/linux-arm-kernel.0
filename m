From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 20 Sep 2017 06:30:42 +0800
Subject: [PATCH v2] doc: coresight: correct usage for disabling idle states
In-Reply-To: <CANLsYkx++kM9Ocw+_Ar6d0_n0gTdzXLRyMZ8eiaJyHxbPJdgYQ@mail.gmail.com>
References: <1505470561-21982-1-git-send-email-leo.yan@linaro.org>
 <CANLsYkx++kM9Ocw+_Ar6d0_n0gTdzXLRyMZ8eiaJyHxbPJdgYQ@mail.gmail.com>
Message-ID: <20170919223042.GC2259@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 03:32:54PM -0600, Mathieu Poirier wrote:
> On 15 September 2017 at 04:16, Leo Yan <leo.yan@linaro.org> wrote:
> > In the coresight CPU debug document it suggests to use 'echo' command
> > to set latency request to /dev/cpu_dma_latency so can disable all CPU
> > idle states, but in fact this doesn't work.
> >
> > This is because when the command 'echo' exits, it releases the device
> > node's file descriptor and the kernel release function removes the QoS
> > constraint; finally when the command 'echo' finished there have no
> > constraint imposed on cpu_dma_latency.
> >
> > This patch changes to use 'exec' to access '/dev/cpu_dma_latency', the
> > command 'exec' can avoid the file descriptor to be closed so we can
> > keep the constraint on cpu_dma_latency.
> >
> > This patch also adds the info for reference docs for PM QoS and cpuidle
> > sysfs.
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Reported-by: Kim Phillips <kim.phillips@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  Documentation/trace/coresight-cpu-debug.txt | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/trace/coresight-cpu-debug.txt b/Documentation/trace/coresight-cpu-debug.txt
> > index b3da1f9..205ff95 100644
> > --- a/Documentation/trace/coresight-cpu-debug.txt
> > +++ b/Documentation/trace/coresight-cpu-debug.txt
> > @@ -149,11 +149,15 @@ If you want to limit idle states at boot time, you can use "nohlt" or
> >
> >  At the runtime you can disable idle states with below methods:
> >
> > -Set latency request to /dev/cpu_dma_latency to disable all CPUs specific idle
> > -states (if latency = 0uS then disable all idle states):
> > -# echo "what_ever_latency_you_need_in_uS" > /dev/cpu_dma_latency
> > -
> > -Disable specific CPU's specific idle state:
> > +By using PM QoS interface '/dev/cpu_dma_latency', we can set latency
> > +constraint to disable all CPUs specific idle states (see
> > +Documentation/power/pm_qos_interface.txt, section 'From user mode');
> > +below is one example to set latency constraint to '00000000', it is
> > +hexadecimal format with microsecond unit:
> > +# exec 3<> /dev/cpu_dma_latency; echo '00000000' >&3
> 
> Since doing echo '00000000' >&3 or simply echo 0 >&3 yields the same
> result I would go for the latter.  I also think it is important to
> specify that using an "echo" command without holding the file open
> won't give the desired result.  I would reformat your paragraph as
> follow:
> 
> >>> Begin >>>
> 
> It is possible to disable CPU idle states by way of the PM QoS
> subsystem, more specifically by using the "/dev/cpu_dma_latency"
> interface (see Documentation/power/pm_qos_interface.txt for more
> details).  As specified in the PM QoS documentation the requested
> parameter will stay in effect until the file descriptor is released.
> For example:
> 
> # exec 3<> /dev/cpu_dma_latency; echo 0 >&3
> ...
> Do some work...
> ...
> # exec 3<>-
> 
> The same can also be done from an application program.
> 
> <<< End <<<

Very appreciate your rephasing and reviewing. Will spin a new patch
with it.

Thanks,
Leo Yan

> > +
> > +Disable specific CPU's specific idle state from cpuidle sysfs (see
> > +Documentation/cpuidle/sysfs.txt):
> >  # echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
> >
> >
> > --
> > 2.7.4
> >

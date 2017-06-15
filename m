From: kim.phillips@arm.com (Kim Phillips)
Date: Wed, 14 Jun 2017 22:34:53 -0500
Subject: [PATCH 00/17] coresight: next v4.12-rc4
In-Reply-To: <20170614062229.GA28496@leoy-ThinkPad-T440>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
 <20170609175339.28d1d4d5a6c91a9e16c16bf7@arm.com>
 <CANLsYky8XLbOwinxVc2xKaNzhkpUOX0NsNxrFF4=MsjzC3iY1g@mail.gmail.com>
 <20170613161712.f1f3cac734939d8728c7ed77@arm.com>
 <20170614062229.GA28496@leoy-ThinkPad-T440>
Message-ID: <20170614223453.3357117a7f25ee68924a071c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Jun 2017 14:22:29 +0800
Leo Yan <leo.yan@linaro.org> wrote:

> Hi Kim,
> 
> On Tue, Jun 13, 2017 at 04:17:12PM -0500, Kim Phillips wrote:
> 
> [...]
> 
> > > > Also, do the current juno platforms not have CPU debug modules?  I'd
> > > > like to test the new driver.
> > > 
> > > By all means - Leo pointed out the patch adding the CPU debug entries in
> > > the DT  file for Juno.
> > 
> > Thanks, I applied it, was able to
> > toggle /sys/kernel/debug/coresight_cpu_debug/enable, but wasn't sure
> > how to trigger the cpu debug output...
> 
> You could trigger panic flow with command, then can see CPU debug output:
> echo c > /proc/sysrq-trigger

That worked, thanks.

The coresight CPU debug documentation states:

> At the runtime you can disable idle states with below methods:
> 
> Set latency request to /dev/cpu_dma_latency to disable all CPUs specific idle
> states (if latency = 0uS then disable all idle states):
> # echo "what_ever_latency_you_need_in_uS" > /dev/cpu_dma_latency
> 
> Disable specific CPU's specific idle state:
> # echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable

So I tried two values in /dev/cpu_dma_latency and expected a difference
in the per-cpu latency files, but didn't observe it:

root at juno:~# echo 0 > /dev/cpu_dma_latency
root at juno:~# more /sys/devices/system/cpu/cpu2/cpuidle*/state*/*laten*
::::::::::::::
/sys/devices/system/cpu/cpu2/cpuidle/state0/latency
::::::::::::::
1
::::::::::::::
/sys/devices/system/cpu/cpu2/cpuidle/state1/latency
::::::::::::::
1500
::::::::::::::
/sys/devices/system/cpu/cpu2/cpuidle/state2/latency
::::::::::::::
1600
root at juno:~# echo 1500 > /dev/cpu_dma_latency
root at juno:~# more /sys/devices/system/cpu/cpu2/cpuidle*/state*/*laten*
::::::::::::::
/sys/devices/system/cpu/cpu2/cpuidle/state0/latency
::::::::::::::
1
::::::::::::::
/sys/devices/system/cpu/cpu2/cpuidle/state1/latency
::::::::::::::
1500
::::::::::::::
/sys/devices/system/cpu/cpu2/cpuidle/state2/latency
::::::::::::::
1600
root at juno:~# cat /sys/kernel/debug/coresight_cpu_debug/enable
1

How does one tell whether writes to /dev/cpu_dma_latency are effective?

Thanks,

Kim

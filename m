From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 13 Jun 2017 16:17:12 -0500
Subject: [PATCH 00/17] coresight: next v4.12-rc4
In-Reply-To: <CANLsYky8XLbOwinxVc2xKaNzhkpUOX0NsNxrFF4=MsjzC3iY1g@mail.gmail.com>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
 <20170609175339.28d1d4d5a6c91a9e16c16bf7@arm.com>
 <CANLsYky8XLbOwinxVc2xKaNzhkpUOX0NsNxrFF4=MsjzC3iY1g@mail.gmail.com>
Message-ID: <20170613161712.f1f3cac734939d8728c7ed77@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jun 2017 10:50:43 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

Hi Mathieu,

> On 9 June 2017 at 16:53, Kim Phillips <kim.phillips@arm.com> wrote:
> 
> > On Mon,  5 Jun 2017 14:15:01 -0600
> > Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> > Hi Mathieu,
> >
> > > Please consider for inclusion in the 4.13 cycle.  Of particular interest
> > is
> > > patch 15/17, which adds a new driver under the CoreSight umbrella.
> >
> > After applying the patchseries, the devices now have self-named
> > subdirectories under them:
> >
> > $ find /sys/devices/ -name \*sink\*
> > /sys/devices/platform/20140000.etf/20140000.etf/enable_sink
> > /sys/devices/platform/20070000.etr/20070000.etr/enable_sink
> > /sys/devices/platform/20030000.tpiu/20030000.tpiu/enable_sink
> > /sys/devices/platform/20010000.etf/20010000.etf/enable_sink
> > $
> >
> 
> This is the expected behaviour.  CoreSight devices are found on the AMBA
> bus and like other AMBA devices they will show up under
> /sys/devices/platform/.

right, but there are subdevices of themselves, e.g.,
20010000.etf/20010000.etf:

kim at juno platform$ find /sys/devices/ -name \*etf\*
/sys/devices/platform/20140000.etf
/sys/devices/platform/20140000.etf/20140000.etf    <- THIS
/sys/devices/platform/20010000.etf
/sys/devices/platform/20010000.etf/20010000.etf    <- and this
/sys/devices/virtual/misc/20140000.etf
/sys/devices/virtual/misc/20010000.etf

'tree' output:

??? 20010000.etf
??? ??? 20010000.etf
??? ??? ??? enable_sink
??? ??? ??? mgmt
??? ??? ??? ??? ctl
??? ??? ??? ??? devid
??? ??? ??? ??? ffcr
??? ??? ??? ??? ffsr
??? ??? ??? ??? mode
??? ??? ??? ??? pscr
??? ??? ??? ??? rrp
??? ??? ??? ??? rsz
??? ??? ??? ??? rwp
??? ??? ??? ??? sts
??? ??? ??? ??? trg
??? ??? ??? power
??? ??? ??? ??? autosuspend_delay_ms
??? ??? ??? ??? control
??? ??? ??? ??? runtime_active_time
??? ??? ??? ??? runtime_status
??? ??? ??? ??? runtime_suspended_time
??? ??? ??? subsystem -> ../../../../bus/coresight
??? ??? ??? trigger_cntr
??? ??? ??? uevent
??? ??? driver -> ../../../bus/amba/drivers/coresight-tmc
??? ??? driver_override
??? ??? id
??? ??? of_node -> ../../../firmware/devicetree/base/etf at 20010000
??? ??? power
??? ??? ??? autosuspend_delay_ms
??? ??? ??? control
??? ??? ??? runtime_active_time
??? ??? ??? runtime_status
??? ??? ??? runtime_suspended_time
??? ??? resource
??? ??? subsystem -> ../../../bus/amba
??? ??? uevent

so things like power/ are duplicated, driver pointers missing from the
sub-node, etc.  I tried reading the documentation to find the reasoning
behind it, and didn't see any, but I may have missed it.  Normally each
platform device gets its own single node, and doesn't create a node
under itself with the same name.

If the subsystem pointer is of use, then I would have
thought 'bus/coresight' would have registered itself as a 'bus/amba'
node? 

> > Which doesn't match the coresight.txt usage documentation...
> 
> When operating CoreSight from the sysFS interface there is nothing
> preventing people from using the entries under /sys/devices/platform should
> they wish to.  It is simply easier to use /sys/bus/coresight/devices/, and
> that is well documented in coresight.txt.
> 
> > Also, do the current juno platforms not have CPU debug modules?  I'd
> > like to test the new driver.
> 
> By all means - Leo pointed out the patch adding the CPU debug entries in
> the DT  file for Juno.

Thanks, I applied it, was able to
toggle /sys/kernel/debug/coresight_cpu_debug/enable, but wasn't sure
how to trigger the cpu debug output...

Thanks,

Kim

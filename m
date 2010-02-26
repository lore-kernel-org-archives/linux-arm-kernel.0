From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Feb 2010 09:53:27 -0000
Subject: [PATCH 4/6] perf-events: export enable/disable event symbols to
	kernel modules
In-Reply-To: <20100226082315.GC15885@elte.hu>
References: <1267124175-21721-1-git-send-email-will.deacon@arm.com>
	<1267124175-21721-2-git-send-email-will.deacon@arm.com>
	<1267124175-21721-3-git-send-email-will.deacon@arm.com>
	<1267124175-21721-4-git-send-email-will.deacon@arm.com>
	<1267124175-21721-5-git-send-email-will.deacon@arm.com>
	<20100226082315.GC15885@elte.hu>
Message-ID: <000401cab6c9$8b9acc20$a2d06460$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ingo,

Thanks for the quick response.

> * Will Deacon <will.deacon@arm.com> wrote:
> 
> > The perf_event_enable and perf_event_disable functions are used to
> > control the activation of perf-events for a given context or CPU.
> >
> > This patch exports these symbols so that they can be used by kernel
> > modules. Without these symbols, an event must be destroyed and recreated
> > to disable or enable it respectively. The maximum number of perf-events
> > is also made available to modules via the perf_get_max_events function.
> >
> 
> Hm, what modules would like to use them, and in what fashion?
> 

The module I had in mind was OProfile [currently just the ARM port, but
perhaps other architectures may decide to do this too]. The patch I posted
here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/010479.html

removes the PMU control code from OProfile and replaces it with calls to perf.
This means that when OProfile starts or stops a profiling session, the
corresponding events are enabled or disabled respectively.

If you want to compile OProfile as a module, then the enable/disable functions
will need to be exported. I suppose the other solution is to prevent OProfile
from being compiled as a module.

Thanks,

Will

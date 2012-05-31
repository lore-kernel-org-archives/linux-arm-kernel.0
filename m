From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 May 2012 14:56:04 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <4FC706DA.5040308@gmail.com>
References: <20120530063858.GB6484@mudshark.cambridge.arm.com>
 <4FC5F017.4050202@gmail.com> <20120531030016.GB29372@mbp>
 <4FC6E172.4080601@gmail.com> <20120531031941.GA29906@mbp>
 <4FC6E7CE.9090004@gmail.com>
 <CAHkRjk4suj4x-mJwvLeOYCNga_YvudNmnz7YxTSzFZ4Jj0iJ+w@mail.gmail.com>
 <4FC6FC38.8090904@gmail.com>
 <CAHkRjk4jJphxST86km4ybuVTGxAr-a=3Ag9cQpEysLYxBt-6WQ@mail.gmail.com>
 <4FC706DA.5040308@gmail.com>
Message-ID: <20120531065603.GA2442@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 06:51:22AM +0100, bill4carson wrote:
> On 2012?05?31? 13:19, Catalin Marinas wrote:
> > On 31 May 2012 13:06, bill4carson<bill4carson@gmail.com>  wrote:
> >> On 2012?05?31? 11:58, Catalin Marinas wrote:
> >>> I still didn't fully understand what the problem is. So, to make sure,
> >>> if you run some applications from flash using a yaffs filesystem, you
> >>> get random crashes. Is this correct? If yes, a solution is to actually
> >>> call flush_dcache_page() on the CPU that does the page copying from
> >>> flash into RAM, which could be the yaffs filesystem.
> >>
> >> The story goes like this:
> >> function "flush_dcache_page" should be global effective
> >> but in ARMv6 MPCore, it was not, it was just local effective due
> >> to hardware design.
> >
> > Yes, I know this.
>
> Then, why not fix "flush_dcache_page" to make it globally effective?

Performance?

And it's also just ARM11MPCore microarchitecture specific.

> >> This may cause error in some cases for example:
> >>
> >> 1) Task running on Core-0 loading text section into memory.
> >>    It was preempted and then migrate into Core-1;
> >
> > BTW, do you have CONFIG_PREEMPT enabled?
> >
> Yes, CONFIG_PREEMPT enabled. Thus cause the task was preempted. :-)

I told you that CONFIG_PREEMPT is not supported on ARM11MPCore :).

> > To be clear - is your application reading some data from flash and
> > trying to execute or it's the kernel doing the load via the
> > page/prefetch abort mechanism?
> 
> In my current case, it is yaffs root file system.
> 
> > If the latter, task running on core 0 gets a prefetch abort when
> > trying to execute some code. The kernel reads the page from flash (via
> > mtd, block layer, VFS) and copies it into RAM. It can be on any CPU as
> > long as it calls flush_dcache_page on the same CPU that copied the
> > data.
> >
> > No matter where the task was running or migrated to, if the code doing
> > the copy also called flush_dcache_page() on the same core, there is no
> > data left in the D-cache for that page.
> 
> Yes, I agree with it.
> But how to flush the data cache on the same core with PREEMPT enabled?

That's not easily possible. But you may get better results with
VOLUNTARY_PREEMPT.

> And, I think according to the design, there is no such operation that
> guarantee it.

RFO/WFO tricks only work on ARM11MPCore.

> But any way, I think flush_dcache_page should be global effective.
> If ARMv6 MPCore didn't make it, we should try to accomplish it.

Do some performance tests first.

-- 
Catalin

From: kim.phillips@arm.com (Kim Phillips)
Date: Wed, 25 Oct 2017 21:22:10 -0500
Subject: [RFC 1/3] perf tool: Introduce arch-specific supplemental perf
 open strerror capability
In-Reply-To: <20171024202300.de189fde683c939966a6646c@arm.com>
References: <20171024030404.ec366ec2d9c38910ccd84ba5@arm.com>
 <20171024142744.GE2512@redhat.com>
 <20171024202300.de189fde683c939966a6646c@arm.com>
Message-ID: <20171025212210.fae60dcd543bafc312583ad3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Oct 2017 20:23:00 -0500
Kim Phillips <kim.phillips@arm.com> wrote:

> On Tue, 24 Oct 2017 12:27:44 -0200
> Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
> 
> > Em Tue, Oct 24, 2017 at 03:04:04AM -0500, Kim Phillips escreveu:
> > > Introduce new tools/perf/arch/*/util/evsel.c:perf_evsel__suppl_strerror()
<snip>
> > But then you're calling it _before_ the existing switch (err), humm...
> > I.e. it will add stuff before the string that will be formatted later...
> > The messages may end up being conflicting, I wonder if the model
> > wouldn't be better as: ask the arch specific if it wants to override
> > that specific error with something, if not, fallback to the existing
> > perf_evsel__open_strerror() code, that could be moved to be
> > __perf_evsel__open_strerror() and called by the arch specific code.
> > 
> > Thoughts?
> 
> Thanks for your good feedback, yes, very good idea, fully agreed and
> implemented - see below.

I take this back:  There's no way for the tool to tell whether it was
the PMU driver that croaked on the perf_event_open, or whether it was
due to another part of the syscall returning an error code.

WRT the CCN strerror code being able to tell whether it was the CCN
driver that did it, technically it could scan the event for strings
like 'vc=', but it still wouldn't be sure.

In the below example, the error being erroneously reported is the
default EINVAL case in the CCN strerror ("Invalid MN..."):

$ sudo ./perf stat -vv -e ccn/cycles/  -p 1330
ccn/cycles/: Invalid MN / XP / node ID, or node type, or node/XP port / vc or event, or mixed PMU group. See dmesg for details

^Cfailed to read counter ccn/cycles/

 Performance counter stats for process id '1330':

   <not supported>      ccn/cycles/                                                 

       2.343102253 seconds time elapsed

...and nothing was emitted in dmesg by the driver.

Any other ideas?

Kim

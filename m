From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 24 Oct 2017 19:47:05 -0500
Subject: [RFC 2/3] perf tool: stat: say more about why event is not
 supported by the kernel
In-Reply-To: <20171024133530.GB13445@arm.com>
References: <20171024030408.d29c81d6134bf63df18ae618@arm.com>
 <20171024133530.GB13445@arm.com>
Message-ID: <20171024194705.31c1af9508fa0c3195ab359e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Oct 2017 14:35:30 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Tue, Oct 24, 2017 at 03:04:08AM -0500, Kim Phillips wrote:
> > +++ b/tools/perf/builtin-stat.c
> > @@ -625,9 +625,13 @@ static int __run_perf_stat(int argc, const char **argv)
> >  			if (errno == EINVAL || errno == ENOSYS ||
> >  			    errno == ENOENT || errno == EOPNOTSUPP ||
> >  			    errno == ENXIO) {
> > -				if (verbose > 0)
> > +				if (verbose > 0) {
> >  					ui__warning("%s event is not supported by the kernel.\n",
> >  						    perf_evsel__name(counter));
> > +					perf_evsel__open_strerror(counter, &target,
> > +								  errno, msg, sizeof(msg));
> > +					ui__error("%s\n", msg);
> > +				}
> 
> Hmm, perf_evsel__open_strerror can already get called a few lines later, so

That's in the case when perf decides to fully abort, whereas this
change allows users to know why perf stat output lists '<not
supported>' instead of having a count figure next to the event requested:

BEFORE THIS SERIES:

# ./oldperf stat -v -e ccn/cycles/ku sleep 1
Warning:
ccn/cycles/ku event is not supported by the kernel.
failed to read counter ccn/cycles/ku

 Performance counter stats for 'system wide':

   <not supported>      ccn/cycles/ku                                               

       1.002756731 seconds time elapsed

AFTER THIS SERIES (amended to show only strerror_arch output):

The tool itself tells the user the event can't exclude execution
levels, rather than the user having to refer to dmesg:

# ./newperf stat -v -e ccn/cycles/ku sleep 1
Warning:
ccn/cycles/ku: Can't exclude execution levels!
failed to read counter ccn/cycles/ku

 Performance counter stats for 'system wide':

   <not supported>      ccn/cycles/ku                                               

       1.002935620 seconds time elapsed

> I don't think this change is right. It looks like the intention here is that
> we can push ahead skipping unsupported events unless they are the leader of
> a populated group. If this isn't working as intended, then it looks like we
> need a helper to identify unsupported events instead.

I could be wrong, but I think it's working as intended:  this patch
just adds more user-visible resolution into the event opening errors.

Kim

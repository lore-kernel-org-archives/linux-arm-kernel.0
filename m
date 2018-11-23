From: andrew.murray@arm.com (Andrew Murray)
Date: Fri, 23 Nov 2018 14:32:13 +0000
Subject: [PATCH 01/10] perf/core: Add macro to test for event exclusion
 flags
In-Reply-To: <87sgzw0yzh.fsf@concordia.ellerman.id.au>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-2-git-send-email-andrew.murray@arm.com>
 <87sgzw0yzh.fsf@concordia.ellerman.id.au>
Message-ID: <20181123143213.GB1617@e119886-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 10:28:34PM +1100, Michael Ellerman wrote:
> Andrew Murray <andrew.murray@arm.com> writes:
> 
> > Add a macro that tests if any of the perf event exclusion flags
> > are set on a given event.
> >
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  include/linux/perf_event.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 53c500f..89ee7fa 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1004,6 +1004,15 @@ perf_event__output_id_sample(struct perf_event *event,
> >  extern void
> >  perf_log_lost_samples(struct perf_event *event, u64 lost);
> >  
> > +static inline bool event_has_exclude_flags(struct perf_event *event)
> > +{
> > +	struct perf_event_attr *attr = &event->attr;
> > +
> > +	return attr->exclude_idle || attr->exclude_user ||
> > +	       attr->exclude_kernel || attr->exclude_hv ||
> > +	       attr->exclude_guest || attr->exclude_host;
> > +}
> 
> Sorry to be a total PITA, but using "flags" plural suggests that it only
> returns true if there is more than one exclude flag set.
> 
> A better name would be event_has_exclude_flag() or maybe
> event_has_any_exclude_flag().
> 
> If you're doing a respin anyway it'd be nice to fix the name, but
> obviously it's not high priority.

No problem - I'll go with event_has_any_exclude_flag.

Thanks,

Andrew Murray

> 
> cheers

From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Jul 2017 17:04:20 +0100
Subject: [PATCH V2 1/4] hw_breakpoint: Add step_needed event attribute
In-Reply-To: <20170725141423.ufucj2wl35bdxafh@hirez.programming.kicks-ass.net>
References: <cover.1499416107.git.panand@redhat.com>
 <9d4f76f3a0bffe93a6d5146c9b53ee7b985f22da.1499416107.git.panand@redhat.com>
 <20170725132737.GC28815@arm.com>
 <20170725141423.ufucj2wl35bdxafh@hirez.programming.kicks-ass.net>
Message-ID: <20170725160419.GC12749@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 04:14:23PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 25, 2017 at 02:27:38PM +0100, Will Deacon wrote:
> > On Fri, Jul 07, 2017 at 05:33:57PM +0530, Pratyush Anand wrote:
> > > Architecture like ARM64 currently allows to use default hw breakpoint
> > > single step handler only to perf. However, some other users like few
> > > systemtap tests or kernel test in
> > > samples/hw_breakpoint/data_breakpoint.c can also work with default step
> > > handler implementation. At the same time, some other like GDB/ptrace may
> > > implement their own step handler.
> > > 
> > > Therefore, this patch introduces a new perf_event_attr bit field, so
> > > that arch specific code(specially on arm64) can make a decision to
> > > enable single stepping.
> > > 
> > > Any architecture which is not using this field will not have any
> > > side effect.
> 
> > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > index b1c0b187acfe..00935808de0d 100644
> > > --- a/include/uapi/linux/perf_event.h
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -345,7 +345,8 @@ struct perf_event_attr {
> > >  				context_switch :  1, /* context switch data */
> > >  				write_backward :  1, /* Write ring buffer from end to beginning */
> > >  				namespaces     :  1, /* include namespaces data */
> > > -				__reserved_1   : 35;
> > > +				step_needed    :  1, /* Use arch step handler */
> > > +				__reserved_1   : 34;
> > 
> > This needs documenting properly, as I really have no idea how userspace is
> > going to use it sensibley, especially as you silently overwrite it in some
> > cases below.
> 
> This is not something userspace _can_ use sensibly afaict. Therefore it
> should probably not live here.

Indeed. When I suggested this, I meant that it would be a
kernel-internal flag, and not UAPI.

Thanks,
Mark.

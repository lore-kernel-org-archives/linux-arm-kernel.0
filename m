From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 21 Sep 2016 11:28:27 +0100
Subject: [RFC PATCH 2/8] thread_info: allow custom in-task thread_info
In-Reply-To: <CALCETrUDWiDmLbMqw9sQYEzvDuSVfmT_UscxQXfmf8YYyTOC=Q@mail.gmail.com>
References: <1473947349-14521-1-git-send-email-mark.rutland@arm.com>
 <1473947349-14521-3-git-send-email-mark.rutland@arm.com>
 <CALCETrWni0aZ71r-R6oYG98kZvZA8a184UR0YURk_=tXu8HXMw@mail.gmail.com>
 <20160916103101.GA21702@leverpostej>
 <CALCETrUDWiDmLbMqw9sQYEzvDuSVfmT_UscxQXfmf8YYyTOC=Q@mail.gmail.com>
Message-ID: <20160921102827.GC18176@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Fri, Sep 16, 2016 at 08:11:14AM -0700, Andy Lutomirski wrote:
> > On Thu, Sep 15, 2016 at 11:37:47AM -0700, Andy Lutomirski wrote:
> > Just to check, what do you mean to happen with the flags field? Should
> > that always be in the generic thread_info? e.g.
> >
> > struct thread_info {
> >         u32 flags;
> > #ifdef arch_thread_info
> >         struct arch_thread_info arch_ti;
> > #endif
> > };
> 
> Exactly.  Possibly with a comment that using thread_struct should be
> preferred and that arch_thread_info should be used only if some header
> file requires access via current_thread_info() or task_thread_info().

While fixing up these patches, I realised that I'm somewhat concerned by 
flags becoming a u32 (where it was previously an unsigned long for
arm64).

The generic {test,set,*}_ti_thread_flag() helpers use the usual bitops,
which perform accesses of sizeof(unsigned long) at a time, and for arm64
these need to be naturally-aligned.

We happen to get that alignment from subsequent fields in task_struct
and/or thread_info, and for arm64 we don't seem to have a problem with
tearing, but it feels somewhat fragile, and leaves me uneasy.

Looking at the git log, it seems that x86 also use unsigned long until
commit affa219b60a11b32 ("x86: change thread_info's flag field back to
32 bits"), where if I'm reading correctly, this was done to get rid of
unnecessary padding. With THREAD_INFO_IN_STACK, thread_info::flags is
immediately followed by a long on x86, so we save no padding.

Given all that, can we make the generic thread_info::flags an unsigned
long, matching what the thread flag helpers implicitly assume?

Thanks,
Mark.

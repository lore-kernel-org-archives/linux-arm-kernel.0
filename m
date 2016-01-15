From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Jan 2016 13:42:07 +0000
Subject: [PATCH v2] kernel: add kcov code coverage
In-Reply-To: <CAPAsAGzjX2OJ7SRt4gM1VqEEm5=xERUtfcEDi05o5bwOTdNhpQ@mail.gmail.com>
References: <1452689318-107172-1-git-send-email-dvyukov@google.com>
 <CAPAsAGx_0pVjtKA2RwwpStRG2-L+5X6W14QbrQaMYhdg30EeAQ@mail.gmail.com>
 <CACT4Y+bHjfkrZ4jWZf+j6FKnj2GQv1t94Y9LJm4=WFyb8C0J8w@mail.gmail.com>
 <CAPAsAGzjX2OJ7SRt4gM1VqEEm5=xERUtfcEDi05o5bwOTdNhpQ@mail.gmail.com>
Message-ID: <20160115134207.GH2131@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 04:05:55PM +0300, Andrey Ryabinin wrote:
> 2016-01-14 17:30 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
> > On Thu, Jan 14, 2016 at 11:50 AM, Andrey Ryabinin
> > <ryabinin.a.a@gmail.com> wrote:
> >> 2016-01-13 15:48 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
> >>> diff --git a/kernel/kcov/kcov.c b/kernel/kcov/kcov.c
> >>> +/* Entry point from instrumented code.
> >>> + * This is called once per basic-block/edge.
> >>> + */
> >>> +void __sanitizer_cov_trace_pc(void)
> >>> +{
> >>> +       struct task_struct *t;
> >>> +       enum kcov_mode mode;
> >>> +
> >>> +       t = current;
> >>> +       /* We are interested in code coverage as a function of a syscall inputs,
> >>> +        * so we ignore code executed in interrupts.
> >>> +        */
> >>> +       if (!t || in_interrupt())
> >>> +               return;
> >>> +       mode = READ_ONCE(t->kcov_mode);
> >>> +       if (mode == kcov_mode_trace) {
> >>> +               u32 *area;
> >>> +               u32 pos;
> >>> +
> >>> +               /* There is some code that runs in interrupts but for which
> >>> +                * in_interrupt() returns false (e.g. preempt_schedule_irq()).
> >>> +                * READ_ONCE()/barrier() effectively provides load-acquire wrt
> >>> +                * interrupts, there are paired barrier()/WRITE_ONCE() in
> >>> +                * kcov_ioctl_locked().
> >>> +                */
> >>> +               barrier();
> >>> +               area = t->kcov_area;
> >>> +               /* The first u32 is number of subsequent PCs. */
> >>> +               pos = READ_ONCE(area[0]) + 1;
> >>> +               if (likely(pos < t->kcov_size)) {
> >>> +                       area[pos] = (u32)_RET_IP_;
> >>> +                       WRITE_ONCE(area[0], pos);
> >>
> >> Note that this works only for cache-coherent architectures.
> >> For incoherent arches you'll need to flush_dcache_page() somewhere.
> >> Perhaps it could be done on exit to userspace, since flushing here is
> >> certainly an overkill.
> >
> > I can say that I understand the problem. Does it have to do with the
> > fact that the buffer is shared between kernel and user-space?
> > Current code is OK from the plain multi-threading side, as user must
> > not read buffer concurrently with writing (that would not yield
> > anything useful).
> 
> It's not about SMP.
> This problem is about virtually indexed aliasing D-caches and could be
> observed on uniprocessor system.
> You have 3 virtual addresses (user-space, linear mapping and vmalloc)
> mapped to the same physical page.
> With aliasing cache it's possible to have multiple cache-lines
> representing the same physical page.
> So the kernel might not see the update made by userspace and vise
> versa because kernel/userspace use different virtual addresses.
> 
> And btw, flush_dcache_page()  would be a wrong choice, since kcov_area
> is a vmalloc address, not a linear address.
> So we need something that flushes vmalloc addresses.
> 
> Alternatively we could simply mlock that memory and talk to user space
> via get/put_user(). No flush will be required.
> And we will avoid another potential problem - lack of vmalloc address
> space on 32-bits.
> 
> > We could add an ioctl that does the flush. But I would prefer if it is
> > done when we port kcov to such an arch. Does arm64 require the flush?
> >
> 
> I think, it doesn't. AFAIK arm64 has non-aliasing D-cache.
> 
> arm64/include/asm/cacheflush.h says:
>        Please note that the implementation assumes non-aliasing VIPT D-cache
> 
> However, I wonder why it implements flush_dcache_page(). Per my
> understanding it is not need for non-aliasing caches.
> And Documentation/cachetlb.txt agrees with me:
>        void flush_dcache_page(struct page *page)
>           If D-cache aliasing is not an issue, this routine may
>           simply be defined as a nop on that architecture.
> 
> Catalin, Will, could you please shed light on this?

It's only there to keep the I-cache and D-cache in sync for executable
pages. That is, flush_dcache_page sets a flah (PG_dcache_clean) in the
page flags, which is checked and cleared when we install an executable
user pte.

Will

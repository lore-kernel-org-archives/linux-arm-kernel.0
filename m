From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 2 Mar 2015 08:31:46 -0800
Subject: [RFC/RFT PATCH 0/3] arm64: KVM: work around incoherency with
 uncached guest mappings
In-Reply-To: <CAKv+Gu-Uk2wg1OkoWgQe4da_EiFoEz_u8VuD8Ees6qU1UYMDvQ@mail.gmail.com>
References: <1424343286-6792-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150219165731.GA26965@hawk.usersys.redhat.com>
 <CAKv+Gu8Je3RRrgEFCZ7JUWtOgk3WqA_qdBEOPAMc3OqnKr1bwg@mail.gmail.com>
 <20150219175518.GB26965@hawk.usersys.redhat.com>
 <54E62404.9040702@redhat.com>
 <20150220142905.GA10942@hawk.usersys.redhat.com>
 <CAKv+Gu-YUzmnACZQi98OPRgKKL+gAGqwWYq2-_dwCdNqcktNUg@mail.gmail.com>
 <20150220153626.GB10942@hawk.usersys.redhat.com>
 <20150224145529.GA5498@hawk.usersys.redhat.com>
 <CAKv+Gu-Uk2wg1OkoWgQe4da_EiFoEz_u8VuD8Ees6qU1UYMDvQ@mail.gmail.com>
Message-ID: <20150302163146.GB9686@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 05:47:19PM +0000, Ard Biesheuvel wrote:
> On 24 February 2015 at 14:55, Andrew Jones <drjones@redhat.com> wrote:
> > On Fri, Feb 20, 2015 at 04:36:26PM +0100, Andrew Jones wrote:
> >> On Fri, Feb 20, 2015 at 02:37:25PM +0000, Ard Biesheuvel wrote:
> >> > On 20 February 2015 at 14:29, Andrew Jones <drjones@redhat.com> wrote:
> >> > > So looks like the 3 orders of magnitude greater number of traps
> >> > > (only to el2) don't impact kernel compiles.
> >> > >
> >> >
> >> > OK, good! That was what I was hoping for, obviously.
> >> >
> >> > > Then I thought I'd be able to quick measure the number of cycles
> >> > > a trap to el2 takes with this kvm-unit-tests test
> >> > >
> >> > > int main(void)
> >> > > {
> >> > >         unsigned long start, end;
> >> > >         unsigned int sctlr;
> >> > >
> >> > >         asm volatile(
> >> > >         "       mrs %0, sctlr_el1\n"
> >> > >         "       msr pmcr_el0, %1\n"
> >> > >         : "=&r" (sctlr) : "r" (5));
> >> > >
> >> > >         asm volatile(
> >> > >         "       mrs %0, pmccntr_el0\n"
> >> > >         "       msr sctlr_el1, %2\n"
> >> > >         "       mrs %1, pmccntr_el0\n"
> >> > >         : "=&r" (start), "=&r" (end) : "r" (sctlr));
> >> > >
> >> > >         printf("%llx\n", end - start);
> >> > >         return 0;
> >> > > }
> >> > >
> >> > > after applying this patch to kvm
> >> > >
> >> > > diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> >> > > index bb91b6fc63861..5de39d740aa58 100644
> >> > > --- a/arch/arm64/kvm/hyp.S
> >> > > +++ b/arch/arm64/kvm/hyp.S
> >> > > @@ -770,7 +770,7 @@
> >> > >
> >> > >         mrs     x2, mdcr_el2
> >> > >         and     x2, x2, #MDCR_EL2_HPMN_MASK
> >> > > -       orr     x2, x2, #(MDCR_EL2_TPM | MDCR_EL2_TPMCR)
> >> > > +//     orr     x2, x2, #(MDCR_EL2_TPM | MDCR_EL2_TPMCR)
> >> > >         orr     x2, x2, #(MDCR_EL2_TDRA | MDCR_EL2_TDOSA)
> >> > >
> >> > >         // Check for KVM_ARM64_DEBUG_DIRTY, and set debug to trap
> >> > >
> >> > > But I get zero for the cycle count. Not sure what I'm missing.
> >> > >
> >> >
> >> > No clue tbh. Does the counter work as expected in the host?
> >> >
> >>
> >> Guess not. I dropped the test into a module_init and inserted
> >> it on the host. Always get zero for pmccntr_el0 reads. Or, if
> >> I set it to something non-zero with a write, then I always get
> >> that back - no increments. pmcr_el0 looks OK... I had forgotten
> >> to set bit 31 of pmcntenset_el0, but doing that still doesn't
> >> help. Anyway, I assume the problem is me. I'll keep looking to
> >> see what I'm missing.
> >>
> >
> > I returned to this and see that the problem was indeed me. I needed yet
> > another enable bit set (the filter register needed to be instructed to
> > count cycles while in el2). I've attached the code for the curious.
> > The numbers are mean=6999, std_dev=242. Run on the host, or in a guest
> > running on a host without this patch series (after TVM traps have been
> > disabled), I get a pretty consistent 40.
> >
> > I checked how many vm-sysreg traps we do during the kernel compile
> > benchmark. It's 124924. So it's a bit strange that we don't see the
> > benchmark taking 10 to 20 seconds longer on average. I should probably
> > double check my runs. In any case, while I like the approach of this
> > series, the overhead is looking non-negligible.
> >
> 
> Thanks a lot for producing these numbers. 125k x 7k == <1 billion
> cycles == <1 second on a >1 GHz machine, I think?
> Or am I missing something? How long does the actual compile take?
> 
I ran a sequence of benchmarks that I occasionally run (pbzip,
kernbench, and hackbench) and I also saw < 1% performance degradation,
so I think we can trust that somewhat.  (I can post the raw numbers when
I have ssh access to my Linux desktop - sending this from Somewhere Over
The Atlantic).

However, my concern with these patches are on two points:

1. It's not a fix-all.  We still have the case where the guest expects
the behavior of device memory (for strong ordering for example) on a RAM
region, which we now break.  Similiarly this doesn't support the
non-coherent DMA to RAM region case.

2. While the code is probably as nice as this kind of stuff gets, it
is non-trivial and extremely difficult to debug.  The counter-point here
is that we may end up handling other stuff@EL2 for performanc reasons
in the future.

Mainly because of point 1 above, I am leaning to thinking userspace
should do the invalidation when it knows it needs to, either through KVM
via a memslot flag or through some other syscall mechanism.

Thanks,
-Christoffer

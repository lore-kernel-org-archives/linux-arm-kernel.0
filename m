From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 21 May 2018 11:37:12 +0100
Subject: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
In-Reply-To: <CAKTKpr61zBW_D6v_Ck1Lcp0NJ4wPFOpgbiM5aU_EtuiFU-qp4Q@mail.gmail.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
 <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
 <20180426105938.y6unpt36lisb7kbr@lakrids.cambridge.arm.com>
 <CAKTKpr7Q7T9ZCTBi=LQR=XaAoihbBA3OKCO7yFobzNmR8EfyjQ@mail.gmail.com>
 <CAKTKpr61zBW_D6v_Ck1Lcp0NJ4wPFOpgbiM5aU_EtuiFU-qp4Q@mail.gmail.com>
Message-ID: <20180521103712.gofbrjdtghfwolmd@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ganapat,


Sorry for the delay in replying; I was away most of last week.

On Tue, May 15, 2018 at 04:03:19PM +0530, Ganapatrao Kulkarni wrote:
> On Sat, May 5, 2018 at 12:16 AM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
> > On Thu, Apr 26, 2018 at 4:29 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> On Wed, Apr 25, 2018 at 02:30:47PM +0530, Ganapatrao Kulkarni wrote:

> >>> +static int alloc_counter(struct thunderx2_pmu_uncore_channel *pmu_uncore)
> >>> +{
> >>> +     int counter;
> >>> +
> >>> +     raw_spin_lock(&pmu_uncore->lock);
> >>> +     counter = find_first_zero_bit(pmu_uncore->counter_mask,
> >>> +                             pmu_uncore->uncore_dev->max_counters);
> >>> +     if (counter == pmu_uncore->uncore_dev->max_counters) {
> >>> +             raw_spin_unlock(&pmu_uncore->lock);
> >>> +             return -ENOSPC;
> >>> +     }
> >>> +     set_bit(counter, pmu_uncore->counter_mask);
> >>> +     raw_spin_unlock(&pmu_uncore->lock);
> >>> +     return counter;
> >>> +}
> >>> +
> >>> +static void free_counter(struct thunderx2_pmu_uncore_channel *pmu_uncore,
> >>> +                                     int counter)
> >>> +{
> >>> +     raw_spin_lock(&pmu_uncore->lock);
> >>> +     clear_bit(counter, pmu_uncore->counter_mask);
> >>> +     raw_spin_unlock(&pmu_uncore->lock);
> >>> +}
> >>
> >> I don't believe that locking is required in either of these, as the perf
> >> core serializes pmu::add() and pmu::del(), where these get called.
> 
> without this locking, i am seeing "BUG: scheduling while atomic" when
> i run perf with more events together than the maximum counters
> supported

Did you manage to get to the bottom of this?

Do you have a backtrace?

It looks like in your latest posting you reserve counters through the
userspace ABI, which doesn't seem right to me, and I'd like to
understand the problem.

Thanks,
Mark.

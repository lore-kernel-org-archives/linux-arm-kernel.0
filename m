From: pasha.tatashin@soleen.com (Pavel Tatashin)
Date: Tue, 20 Nov 2018 09:40:10 -0500
Subject: [PATCH v1 1/1] arm64: Early boot time stamps
In-Reply-To: <d66a60d9-6772-a951-9da4-c07443b48aad@arm.com>
References: <20181119214443.25175-1-pasha.tatashin@soleen.com>
 <20181119214443.25175-2-pasha.tatashin@soleen.com>
 <d66a60d9-6772-a951-9da4-c07443b48aad@arm.com>
Message-ID: <CA+CK2bAKcdZRRMwhcQ0QnBJ3_6bg=zhaeM7v74f+QFwkw9h17A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +static __init void sched_clock_early_init(void)
> > +{
> > +     u64 freq = arch_timer_get_cntfrq();
> > +     u64 (*read_time)(void) = arch_counter_get_cntvct;
>
> We already have arch_timer_read_counter which is exposed from
> arm_arch_timer.h.

OK

>
> > +
> > +     /* Early clock is available only on platforms with known freqs */
>
> This comment is misleading. It should read something like:
>
>         /*
>          * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
>          * the timer frequency. To avoid breakage on misconfigured
>          * systems, do not register the early sched_clock if the
>          * programmed value if zero. Other random values will just
>          * result in random output.
>          */
>

OK

> > +     if (!freq)
> > +             return;
> > +
> > +     sched_clock_register(read_time, BITS_PER_LONG, freq);
>
> This doesn't seem right. The counter has an architected minimum of 56
> bits, and you can't assume that it is going to be more than that.

Yeah, I saw 56 is used in arm_arch_timer.c, but I could not find where
this minimum is defined in aarch64 specs. I will change it to 56.

I will send v2 soon.

Thank you,
Pasha

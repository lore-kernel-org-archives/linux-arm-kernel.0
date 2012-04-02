From: yad.naveen@gmail.com (naveen yadav)
Date: Mon, 2 Apr 2012 15:24:27 +0530
Subject: top command shows 100% irq
In-Reply-To: <CAH+eYFD-S+M9FN1VyDP+X4Qj7Tv_6x770cy7zDAkDy9nZ3NU=Q@mail.gmail.com>
References: <CAJ8eaTza9c7TTHtz97M1QFzsm5KHf0hyjtATa3a+9iQcE1Sgow@mail.gmail.com>
 <CAJ8eaTzw3TyPZnhEOqAfq3PtGWHAwSity8QhO9ENXqZ29CQ_jw@mail.gmail.com>
 <CAH+eYFD-S+M9FN1VyDP+X4Qj7Tv_6x770cy7zDAkDy9nZ3NU=Q@mail.gmail.com>
Message-ID: <CAJ8eaTzLPkw6cHR+2aE8fHMy35ya+AmkXCxBjR=CCqW+BMBQfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks a lot, it fix the problem,



On Mon, Apr 2, 2012 at 1:49 PM, Rabin Vincent <rabin@rab.in> wrote:
> On Mon, Apr 2, 2012 at 11:16, naveen yadav <yad.naveen@gmail.com> wrote:
>>> So it seams to me when struct clock_event_device *evt =
>>> &__get_cpu_var(percpu_clockevent); is in irq_enter() function, this
>>> leads ?100% irq.
>>> what may be issue.
>
> The problem is that ipi_timer() is also called from do_local_timer()
> on older kernels. ?So if you backport this patch to an older kernel,
> you need to additionally add the irq_enter() and irq_exit() calls
> around the call to ipi_timer() in do_local_timer(), since the patch
> moves them out of ipi_timer().
>
> do_local_timer() doesn't exist on the kernel the patch was made for,
> since the percpu irq rework removed it.

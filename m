From: wpdster@gmail.com (Patrick Doyle)
Date: Mon, 4 Jan 2016 10:46:31 -0500
Subject: How to get better precision out of getrusage on the ARM?
In-Reply-To: <5686C211.5040606@gmail.com>
References: <CAF_dkJBjs1b+73ggvJyXwab6YL94HGT2jrqbcfaLxoETtQsD9Q@mail.gmail.com>
 <20151222144907.GK8644@n2100.arm.linux.org.uk>
 <CAF_dkJDFXSEgH+kO=k=Yj0_VDnFYgPtkoYznLUWZnq4=QTNDDg@mail.gmail.com>
 <20151222151314.GM8644@n2100.arm.linux.org.uk>
 <CAF_dkJAUyD3GRAETZUQG2yJTmOR95XKVguohBpBjUaM9JMaQyg@mail.gmail.com>
 <CAF_dkJBrfd=YUnG=ja2KE_z2DM8NQTLGiWVyvW6mrPYP4i+sFA@mail.gmail.com>
 <CAF_dkJBM3qbs3GB8jdgonus7dgVSyn-7QtogtqmMQWzR2BK+OQ@mail.gmail.com>
 <CAF_dkJBOf87J__X9Gdpb_b0P9NzS44w-bhRaUi+z0EKXLkg_5g@mail.gmail.com>
 <5686C211.5040606@gmail.com>
Message-ID: <CAF_dkJAdbugFO4_C0A22hLT33mk4W6MzON4i0jhxK+vzrPraWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 1, 2016 at 1:14 PM, Corey Minyard <tcminyard@gmail.com> wrote:
> Those numbers are statistical, if a tick occurs while something is running,
> that something is assigned the entire timer tick.  So as you have found, you
> can get some pretty unusual numbers on this, especially with short
> intervals.
>
> I have some patches at https://sourceforge.net/projects/microstate that add
> the ability to do accurate accounting of time, if you really need that.
Thank you Corey,
That makes sense.  I have found that using
clock_gettime(CLOCK_THREAD_CPUTIME_ID, ...) provides the information I
require.  I was confused by the accounting of timer ticks, and
especially by the fact that the accounting changed from exactly 1000us
(or 10000us) to a range centered about 1000us as I fiddled with config
parameters.  I felt sure that one of those config options would result
in accounting only such time to a thread as the thread used.
clock_gettime() returns a thread specific timer that I can use.

At this point, I remain confused/disappointed by the 3us time interval
between calls to clock_gettime().  That feels like a long time for a
pair of context switches into the kernel to get the thread timer, but
I guess that's what it is (on my 500 MHz Cortex-A5).

--wpd

From: wpdster@gmail.com (Patrick Doyle)
Date: Tue, 19 Jan 2016 09:36:38 -0500
Subject: How to get better precision out of getrusage on the ARM?
In-Reply-To: <569DC0B3.6070804@atmel.com>
References: <CAF_dkJBjs1b+73ggvJyXwab6YL94HGT2jrqbcfaLxoETtQsD9Q@mail.gmail.com>
 <20151222144907.GK8644@n2100.arm.linux.org.uk>
 <CAF_dkJDFXSEgH+kO=k=Yj0_VDnFYgPtkoYznLUWZnq4=QTNDDg@mail.gmail.com>
 <20151222151314.GM8644@n2100.arm.linux.org.uk>
 <CAF_dkJAUyD3GRAETZUQG2yJTmOR95XKVguohBpBjUaM9JMaQyg@mail.gmail.com>
 <CAF_dkJBrfd=YUnG=ja2KE_z2DM8NQTLGiWVyvW6mrPYP4i+sFA@mail.gmail.com>
 <CAF_dkJBM3qbs3GB8jdgonus7dgVSyn-7QtogtqmMQWzR2BK+OQ@mail.gmail.com>
 <CAF_dkJBOf87J__X9Gdpb_b0P9NzS44w-bhRaUi+z0EKXLkg_5g@mail.gmail.com>
 <5686C211.5040606@gmail.com> <569DC0B3.6070804@atmel.com>
Message-ID: <CAF_dkJDfT9LkE+_jj0_0mr80MQhH3ktTtZ8XwC+J1eOYqYgenQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 11:50 PM, Yang, Wenyou <wenyou.yang@atmel.com> wrote:
> On 2016/1/2 2:14, Corey Minyard wrote:
>> I have some patches at https://sourceforge.net/projects/microstate that
>> add the ability to do accurate accounting of time, if you really need that.
>
>
> I want to run this similar tests on my side.
>
> It seems you don't use this project. What project do you use as your
> application?  Could you give some information?
>
> Did your questions resolve?  What is remaining?
Hello Wenyou,
For my project, I was porting an existing application that ran on a
custom embedded OS.  Part of that custom embedded OS provided
per-thread CPU runtime timers.  As I looked around for a mechanism to
implement that, I found clock_gettime(2) using the
CLOCK_THREAD_CPUTIME_ID clk_id should provide the same capability in a
Posix-ly correct manner.

The problem I ran into was the values returned by
CLOCK_THREAD_CPUTIME_ID were quantized to multiples of the system tick
frequency.  So I hacked up tcb_clksrc.c to register itself using
CLOCKSOURCE_OF_DECLARE() and set the appropriate kernel options
(CONFIG_HIGH_RES_TIMERS and CONFIG_NO_HZ_IDLE, I think, but I can't
seem to find my notes or config files from that work -- I hate Monday
mornings, even virtual ones!).  As I noted in my previous email, I am
not happy with my changes to tcb_clksrc.c and would like the
opportunity to discuss them with you and your colleagues at Atmel and
figure out the best way to approach that.  I'm happy to send the
patches to you, but I don't think they should go into the linux-at91
tree without a lot more thought applied.

--wpd

From: wpdster@gmail.com (Patrick Doyle)
Date: Wed, 23 Dec 2015 15:22:42 -0500
Subject: What happens if sched_clock_suspend() is never called?
In-Reply-To: <20151223194511.GU8644@n2100.arm.linux.org.uk>
References: <CAF_dkJAJ3g7S2i2zW81OD50Bwsg7NzuakbeeQaBhJvtVCyg86w@mail.gmail.com>
 <20151223194511.GU8644@n2100.arm.linux.org.uk>
Message-ID: <CAF_dkJArNbcn31s7Sj7c-3a2nSEdpLbP1Tr8=0Y6gXm_3_nQzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 2:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Dec 23, 2015 at 11:11:20AM -0500, Patrick Doyle wrote:
>> This feels like a bug to me.  It seems like sched_clock_register()
>> should update the sched_clock_timer whenever it changes cd.wrap_kt.
>
> sched_clock needs to be up and running early in the boot process
> so the scheduler has a stable time source.  sched_clock must be
> registered and configured by the time sched_clock_postinit() is
> called, and after that no further registrations should be made.
>
OK, that makes sense.  I guess that's why all of the drivers in
drivers/clocksource invoke sched_clock_register() from within
CLOCKSOURCE_OF_DECLARE(), and I guess that CLOCKSOURCE_OF_DECLARE()
must do the right thing to ensure that the init function is called at
the appropriate time in the boot process.

Now the dots are starting to get connected.  Thank you.  I'll go
investigate what needs to be done to change:

arch_initcall(tcb_clksrc_init);

to be some appropriate form of call to CLOCKSOURCE_OF_DECLARE() (which
will be complicated by Atmel's usage of atmel_tclib.c)

Thanks again for the help.

--wpd

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jan 2012 16:26:50 +0000
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <4F05CC0D.6090101@arm.com>
References: <4F048EC4.40900@arm.com>
 <20120104214748.GH11810@n2100.arm.linux.org.uk>
 <CACRpkdZPEYc3xNNb1w4st86bLGMW0ePbEA6+V4opHXe6Sk=u2g@mail.gmail.com>
 <4F0584B5.60908@arm.com>
 <CAMQu2gxuBNRWYKyKRdzvv_m49DyLoODVbC=rKDHDAMTnxe+6+A@mail.gmail.com>
 <4F058744.4030503@arm.com> <20120105112602.GQ11810@n2100.arm.linux.org.uk>
 <4F058B1C.2070109@arm.com> <20120105121026.GS11810@n2100.arm.linux.org.uk>
 <4F05CC0D.6090101@arm.com>
Message-ID: <20120105162650.GY11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 04:13:01PM +0000, Marc Zyngier wrote:
> On 05/01/12 12:10, Russell King - ARM Linux wrote:
> > On Thu, Jan 05, 2012 at 11:35:56AM +0000, Marc Zyngier wrote:
> >> On 05/01/12 11:26, Russell King - ARM Linux wrote:
> >>> Look, local timers *are* special.  They're not the same as global timers.
> >>> They're treated differently.  Ripping out the local timer setup stuff
> >>> from the SMP code is not the right solution, especially when we've
> >>> already got a separation of the local timer core from the hardware
> >>> implementation.
> >>
> >> OK. I'll try to work out something different.
> > 
> > Why?  What's wrong with the existing structure?
> 
> My main goal here is not to use a local timer as a global timer, but
> rather to be able to support multiple local timer implementations in the
> same kernel (TWD, MCT...). The "local timer on UP" is merely a consequence.
> 
> I could come up with another registration interface that fits into the
> existing structure, but I thought something could be done with what we
> currently have.

That's easy - but the solution depends on exactly how you're trying to
solve it.

In local_timer.h:

struct local_timer {
	int (*setup)(struct clock_event_device *);
	void (*stop)(struct clock_event_device *);
};

int local_timer_register(struct local_timer *);

In arch/arm/kernel/smp.c:

static struct local_timer *local_timer;

int local_timer_register(struct local_timer *lt)
{
	if (local_timer)
		return -EBUSY;
	local_timer = lt;
	return 0;
}

static int local_timer_setup(struct clock_event_device *ce)
{
	return local_timer ? local_timer->setup(ce) : -ENXIO;
}

static void local_timer_stop(struct clock_event_device *ce)
{
	if (local_timer)
		local_timer->stop(ce);
}

And, for twd:

struct local_timer twd_local_timer = {
	.setup = twd_timer_setup,
	.stop = twd_timer_stop,
};

But... it's not quite that simple because platforms need to intercept the
local_timer_setup() call to do platform specific things - such as finding
the twd base, and setting the twd IRQ.  That can be solved by moving
that out of platform code (why is it there in the first place?) into
smp_twd.c, and providing twd_local_timer_dt.

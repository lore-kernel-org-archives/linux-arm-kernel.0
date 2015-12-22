From: wpdster@gmail.com (Patrick Doyle)
Date: Tue, 22 Dec 2015 11:28:38 -0500
Subject: How to get better precision out of getrusage on the ARM?
In-Reply-To: <20151222151314.GM8644@n2100.arm.linux.org.uk>
References: <CAF_dkJBjs1b+73ggvJyXwab6YL94HGT2jrqbcfaLxoETtQsD9Q@mail.gmail.com>
 <20151222144907.GK8644@n2100.arm.linux.org.uk>
 <CAF_dkJDFXSEgH+kO=k=Yj0_VDnFYgPtkoYznLUWZnq4=QTNDDg@mail.gmail.com>
 <20151222151314.GM8644@n2100.arm.linux.org.uk>
Message-ID: <CAF_dkJAUyD3GRAETZUQG2yJTmOR95XKVguohBpBjUaM9JMaQyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 10:13 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 22, 2015 at 09:57:57AM -0500, Patrick Doyle wrote:
>> On Tue, Dec 22, 2015 at 9:49 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Tue, Dec 22, 2015 at 09:30:30AM -0500, Patrick Doyle wrote:
>> >> Short version:
>> >> My application running on a Cortex-A5 processor (the SAMA5D2 from
>> >> Atmel) calls getrusage(RUSAGE_THREAD, ...), which returns cpu time
>> >> quantized to the kernel tick frequency (100Hz or 1Khz, depending on
>> >> CONFIG_HZ_100 vs CONFIG_HZ_1000).
>> >>
>> >> How can I get better precision for sched_clock on the (Cortex-A5) ARM?
>> >>  The x86 uses the TSC.
>> >
>> > You need to provide a sched_clock() implementation using
>> > sched_clock_register().
>> >
>> Thank you, I tried that by modifying the (Atmel specific) tcb_clcksrc,
>> and got a sched_clock that never incremented.  I have a question out
>> at the Atmel forum asking about this, and will continue to investigate
>> on my own, but I figured it was about time to ask the experts :-)
Thank you for your help.

Now my sched_clock is incrementing, (I have no idea why it wasn't
yesterday -- it must have been 5:00-itis).  I have passed a readback
function to sched_clock_register(), but I'm still seeing 1ms
resolution for the values returned by getrusage().  Are there other
configuration items I should be setting to get better resolution?  I
have tried setting CONFIG_HIGH_RES_TIMERS and
CONFIG_IRQ_TIME_ACCOUNTING.  It seems like I should choose
VIRT_CPU_ACCOUNTING_NATIVE, but that choice is not enabled because
HAVE_VIRT_CPU_ACCOUNTING is not defined.  HAVE_VIRT_SPU_ACCOUNTING
doesn't seem to be defined for the ARM architecture.

Any more thoughts or ideas?

--wpd

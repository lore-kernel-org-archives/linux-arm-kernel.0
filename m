From: dianders@chromium.org (Doug Anderson)
Date: Thu, 11 Sep 2014 10:29:25 -0700
Subject: [PATCH v2] clocksource: arch_timer: Allow the device tree to
 specify the physical timer
In-Reply-To: <5411DA67.2040402@arm.com>
References: <1410452204-7277-1-git-send-email-dianders@chromium.org>
 <20140911164710.GW6158@arm.com> <5411D528.4050605@arm.com>
 <CAD=FV=XMmizxJFPj0FEhJ7Gk4ZcQaUJDxf_Qq5kGKSvxDFVmzg@mail.gmail.com>
 <5411DA67.2040402@arm.com>
Message-ID: <CAD=FV=UQfo4J3P4wGjOhQZQ5KXKgYAdjPsi1ykKZxQw-FwJz8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Thu, Sep 11, 2014 at 10:22 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> We would need to run this code potentially at processor bringup and
>> after suspend/resume, but that seems possible too.
>
> Note that this would be an ARMv7 only thing (you can't do that on ARMv8,
> at all).

Yes, of course.


>> Is the transition to monitor mode and back simple?  Where would you
>> suggest putting this code?  It would definitely need to be pretty
>> early.  We'd also need to be able to detect that we're in Secure SVC
>> and not mess up anyone else who happened to boot in Non Secure SVC.
>
> This would have to live in some very early platform-specific code. The
> ugly part is that you cannot find out what world you're in (accessing
> SCR is going to send you to UNDEF-land if accessed from NS).

Yup, so the question is: would such code be accepted upstream, or are
we going to embark on a big job for someone to figure out how to do
this only to get NAKed?

If there was some indication that folks would take this, I think we
might be able to get it coded up.  If someone else wanted to volunteer
to code it that would make me even happier, but maybe that's pushing
my luck.  ;)


> If I was suicidal, I'd suggest you could pass a parameter to the command
> line, interpreted by the timer code... But I since I'm not, let's
> pretend I haven't said anything... ;-)

I did this in the past (again, see Sonny's thread), but didn't
consider myself knowledgeable to know if that was truly a good test:

       asm volatile("mrc p15, 0, %0, c1, c1, 0" : "=r" (val));
       pr_info("DOUG: val is %#010x", val);
       val |= (1 << 2);
       asm volatile("mcr p15, 0, %0, c1, c1, 0" : : "r" (val));
       val = 0xffffffff;
       asm volatile("mrc p15, 0, %0, c1, c1, 0" : "=r" (val));
       pr_info("DOUG: val is %#010x", val);

The idea being that if you can make modifications to the SCR register
(and see your changes take effect) then you must be in secure mode.
In my case the first printout was 0x0 and the second was 0x4.

-Doug

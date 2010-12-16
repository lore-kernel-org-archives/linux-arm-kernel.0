From: rabin@rab.in (Rabin Vincent)
Date: Thu, 16 Dec 2010 21:52:56 +0530
Subject: [PATCH] ARM: ensure all sched_clock() implementations are notrace
	marked
In-Reply-To: <20101216155750.GA28126@n2100.arm.linux.org.uk>
References: <E1PT92Y-0004Ba-64@rmk-PC.arm.linux.org.uk>
	<AANLkTimGHSqO=QwESp98UBK28yawdiq+kURU=nwau27G@mail.gmail.com>
	<20101216155750.GA28126@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikLoU-L4YF_FtG4Q8Qh+66zToun5p2LhgYyiyrv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 9:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 16, 2010 at 08:42:23PM +0530, Rabin Vincent wrote:
>> On Thu, Dec 16, 2010 at 1:48 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > ftrace requires sched_clock() to be notrace. ?Ensure that all
>> > implementations are so marked.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>> It does seem better to have all of them explicity annotated anyway, even
>> if it not required in most of the cases because they include
>> <linux/sched.h> and the annotation in the declaration takes effect.
>
> Firstly, we shouldn't be relying upon that, and secondly, everywhere which
> defines sched_clock() should already be including linux/sched.h to avoid
> the sparse error. ?It sounds like there's also an exercise to make sure
> that is the case.

Yes.  I believe I identified all the ones which weren't including the
header in the last notrace series I sent out (versatile, plat-iop, omap,
and u300 IIRC), but there's been some changes in various platforms'
sched_clocks() and of course new platforms since then.

>
>> Note that in order for this to be fully effective, all functions called
>> from sched_clock() need to be notrace too. ?OMAP and u300 miss this.
>
> Yes, OMAP still suffers from this.
>
> However, I assume you haven't looked at the u300 sched_clock conversion
> patch which is part of a follow-on series on lakml? ?It sorts u300 out
> in that regard.

Yes, I now see U300 no longer needs the notrace addition.  It still
could do with the #include <linux/sched.h> addition though, which was
also being done as part of that patch.

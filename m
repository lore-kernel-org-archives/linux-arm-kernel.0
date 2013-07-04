From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 5 Jul 2013 01:25:18 +0900
Subject: [PATCH v3] ARM: shmobile: lager: Add DT reference
In-Reply-To: <1438555.HIWtKGAp3v@avalon>
References: <1372838251-6314-1-git-send-email-horms+renesas@verge.net.au>
 <1438555.HIWtKGAp3v@avalon>
Message-ID: <CANqRtoRzBAxeirMyKRqb-PrufFPGDQOqCnkKDEkx1pNsJqXPJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

[CC Kuribayashi-san]

On Fri, Jul 5, 2013 at 12:02 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Simon,
>
> On Wednesday 03 July 2013 16:57:31 Simon Horman wrote:
>> This is sufficient to allow boot of the Lager board with a console without
>> boards-lager.c compiled into the kernel. This is an example of a minimal but
>> still useful initialisation of the board using DT as much as possible.
>>
>> As such it is the same as the boot of Lager that can be achieved without a
>> board file. The intention of adding this file is to facilitate further work
>> to allow board specific devices to be initialised via DT.
>
> At some (hopefully not too distant) point we should stop adding both
> traditional and DT board files. DT is supposed to lower the number of board
> files, not multiply it by two.

Well, mr-multiply-by-two: While I dislike code duplication I can't
recall when the number of files actually decreased with DT.

I realize that when we can use DT fully to describe a board then a
single DTS file is enough to describe board specific hardware together
with per-SoC C code. I can't however see how that would reduce the
number of files, but whatever. I always thought the goal was to reduce
the memory footprint of the kernel and that the source would not come
with that many limitations, but it seems that I got that all wrong...

Anyway, the current split on mach-shmobile is intentional:

1) The C version of board support (board-xxx.c)

This is where platform devices are used (with power domains in some
cases) and where out-of-tree people can experiment with things. This
code is using legacy SH clock code and is not targeted for
multiplatform. These should go away, the sooner the better.

2) The DT reference support (board-xxx-reference.c)

This file contains whatever bits of C code needed to get the DT
support going. All the board specific devices should be described via
DT. The DT reference board support is where we build incremental
support to catch up with 1) board-xxx.c. Ideally we wouldn't need the
board-xxx-reference.c file and instead only go with .dts, but in some
cases we need some extra glue and until pinctrl DT is done we also
need those written in C. The DT reference support will use common
clocks as soon as they are available.

3) SoC DT support (setup-xxx.c)

This is what will be used when 2) is caught up with 1). Common clocks
and multiplatform, one SoC at a time.

> Work is still needed in order to achieve this, as we lack DT bindings for core
> (and non core) devices. That's something we need to work on. As a first step,
> do we have a roadmap with a list of devices that lack DT support ? At the very
> least I see more work needed on
>
> - Common clock framework

Yes, I agree. Please see below for more about that.

> - SCI

Indeed, someone needs to continue earlier efforts for the SCIF driver.
Fortunately, with EMEV2 our UART driver already supports DT, so we can
implement DT-only multiplatform support on EMEV2 regardless of the
state of SCIF.

> - Timers

We can use DT-only with Arch timer, but unfortunately another clock
evenit is needed unconditionally for high resolution timer support,
search for clock event and the C3STOP flag if you want to see me moan
about that.

Regardless I believe someone took a couple of first steps towards DT
support for our timers some time ago. But as we discussed face to face
about a month ago, it makes sense to describe the hardware via DT but
in case of timers and clock event / clock sources it does not make
sense to associate 87 timer channels for operating system time
keeping. So we need some user space configuration interface to
associate different kind of timer applications (operating system
timer, PWM, clock generation, etc) to different channels.

Since you mention it: =)
- PINCTRL DT and GPIO DT

I'd like to start picking up the remaining PINCTRL and GPIO bits for
v3.12 merge. Can you please rebase and resend on top of the latest
renesas-next tag?

> We shouldn't delay CCF much longer, v3.12 seems an achievable target to me.
> Who will work on that ?

So I am currently preparing EMEV2 for multiplatform, will most likely
have patches posted for that next week. And yes, I intend to send a
new DT reference board support file.

In parallel Kuribayashi-san is taking a stab at moving to common
clocks for EMEV2 as a first step.

I expect the above to be in order for v3.12, but not much more that that.

Cheers,

/ magnus

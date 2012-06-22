From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jun 2012 23:26:47 +0100
Subject: [PATCH 0/2] Use architected timers for delay loop
In-Reply-To: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
Message-ID: <20120622222647.GE30087@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 04:09:32PM +0100, Will Deacon wrote:
> Hello,
> 
> This patch series reworks our delay loop implementation to allow the
> busy-loop to be replaced with the physical counter included as part of
> the architected timer on recent CPUs. The polling implementation is
> still maintained to support cores without the timers and we use the same
> maths and upper delay bound of 2ms.
> 
> Russell - I think my maths is correct, but why can't we increase the
>           precision by using a magic constant of 4398046U and a right
> 	  shift of 31?

It's been soo long since I looked at that code that I've forgotten the
maths behind it.

What I can say is that the maths in the assembly code version is
carefully chosen to avoid overflows during the various stages of
computation without loosing too much precision along the way.

The assembly is also designed to round up any lost precision, so we
try to produce a longer delay by way of the lost precision in the
maths.

I forget what kind of precision we do get, but precision is not really
a major concern here.  We are only after a "rough" estimate of the
delay (hell, we don't even guarantee according to Linus that you will
get a minimum of the delay you asked for - you might get a shorter
delay!)  You _will_ get shorter delays because of the way the loop is
calibrated (think: the jiffy code tries to find how many loops fit in
a single jiffy, but a jiffy _also_ includes the overhead of running
the timer interrupt, which artificially reduces loops_per_jiffy.)

Provided we get a delay "in the ballpark" of what was requested, that's
good enough.

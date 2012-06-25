From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Jun 2012 11:03:03 +0100
Subject: [PATCH 0/2] Use architected timers for delay loop
In-Reply-To: <20120622222647.GE30087@n2100.arm.linux.org.uk>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
 <20120622222647.GE30087@n2100.arm.linux.org.uk>
Message-ID: <20120625100303.GE22128@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for the clarification.

On Fri, Jun 22, 2012 at 11:26:47PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 22, 2012 at 04:09:32PM +0100, Will Deacon wrote:
> > Russell - I think my maths is correct, but why can't we increase the
> >           precision by using a magic constant of 4398046U and a right
> > 	  shift of 31?
> 
> It's been soo long since I looked at that code that I've forgotten the
> maths behind it.

No problem. I managed to convince myself of the maths but I don't want to
touch the assembly code in delay.S if I don't have to!

> What I can say is that the maths in the assembly code version is
> carefully chosen to avoid overflows during the various stages of
> computation without loosing too much precision along the way.
> 
> The assembly is also designed to round up any lost precision, so we
> try to produce a longer delay by way of the lost precision in the
> maths.

Right, that probably explains why I was having difficulty following it.

> I forget what kind of precision we do get, but precision is not really
> a major concern here.  We are only after a "rough" estimate of the
> delay (hell, we don't even guarantee according to Linus that you will
> get a minimum of the delay you asked for - you might get a shorter
> delay!)  You _will_ get shorter delays because of the way the loop is
> calibrated (think: the jiffy code tries to find how many loops fit in
> a single jiffy, but a jiffy _also_ includes the overhead of running
> the timer interrupt, which artificially reduces loops_per_jiffy.)

We avoid the calibration step for the timer-based loop and use the counter
frequency directly so I think we probably always delay for slightly longer
in that case. But yes, I see that precision isn't the be-all and end-all
here!

> Provided we get a delay "in the ballpark" of what was requested, that's
> good enough.

In which case, let's leave the maths like it is. The current values work
fine with both the polling loop and the timer loop up to 2ms.

Cheers,

Will

From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 23 Apr 2010 11:00:51 +0200
Subject: udelay() broken for SMP cores?
In-Reply-To: <20100421095036.GA13971@n2100.arm.linux.org.uk>
References: <4BCE60C4.8020505@codeaurora.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C4FEED81@dbde02.ent.ti.com>
	<4BCE9E8B.2070103@codeaurora.org>
	<20100421072243.GA913@n2100.arm.linux.org.uk>
	<ea62885d30e4bbfb84db59758fa9e946.squirrel@www.codeaurora.org>
	<20100421095036.GA13971@n2100.arm.linux.org.uk>
Message-ID: <20100423090050.GA2213@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Is this an ARM specific decision? Cpufreq certainly supports per cpu scaling
> > and x86 udelay uses per-CPU data. So your concern should apply for x86
> > too. I had the same concern and was planning on bring it up in the cpufreq
> > mailing list after I made sure I didn't misunderstand anything.
> 
> Well, x86 looks buggy in this regard as well - the loops_per_jiffy
> value used is for a CPU which may not run the delay loop.

x86 assumes all cores to be essentially same.

> > Btw, your concern should apply for single core scaling too, right? Context
> > switch can complete within max udelay (general - 5ms, ARM - 2ms) time and
> > CPU could have jumped
> > from lowest to highest speed in that time and mess up udelay. I didn't see
> > any code in cpufreq that deferred scaling during udelay. So, that's something
> > I plan to ask cpufreq folks too.
> 
> Well, the assumption is that the CPUs will be running at their fastest
> speed at boot time, and therefore loops_per_jiffy will be calibrated
> such that we guarantee _at least_ the asked-for delay - which is the
> only guarantee udelay has.

Well, some machines can't reach max cpu speed on battery power, so
there may be a problem there.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

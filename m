From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Dec 2011 00:25:03 +0000
Subject: [PATCH 5/5 v2] ARM: OMAP1: recalculate loops per jiffy after
 dpll1 reprogram
In-Reply-To: <201112091100.01690.jkrzyszt@tis.icnet.pl>
References: <1322364751-29980-6-git-send-email-jkrzyszt@tis.icnet.pl>
 <1322526332-14088-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <20111209084245.GB14547@n2100.arm.linux.org.uk>
 <201112091100.01690.jkrzyszt@tis.icnet.pl>
Message-ID: <20111210002503.GA6018@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 11:00:01AM +0100, Janusz Krzysztofik wrote:
> On Friday 09 of December 2011 at 09:42:45, Russell King - ARM Linux wrote:
> > On Tue, Nov 29, 2011 at 01:25:32AM +0100, Janusz Krzysztofik wrote:
> > > However, the result of cpufreq_scale() differs from that of
> > > (re)calibrate_delay() by ca. 6%, i.e., 70.40 vs. 74.54. Please advise if
> > > this approximation is acceptable.
> > 
> > You don't say which figure is what.
> 
> Hi,
> Those were BogoMIPS, which you were talking about in your comment 
> (http://www.spinics.net/lists/linux-omap/msg60811.html).

I realise that.  But which is which - is 70.40 from recalibrate_delay
or is it 74.54?  Your message is too vague to be able to interpret your
results because it's impossible to work out what figure refers to which
method.

> > Note that calibrate_delay() is itself inaccurate - the loops_per_jiffy
> > is the number of loops which can be executed between two timer ticks
> > _minus_ the time to process the timer interrupt itself.  So, it's
> > actually always a little less than the theoretical number of loops
> > within that time period.
> 
> I see. Then, in case of a machine always booting at, let's say, 12 and
> then reprogrammed to 150 MHz, we actually scale up that less then the
> theoretical number, with a side effect of scaling up its error as well.
> Perhaps in this case, when the machine is going to run at that target
> rate until rebooted, we should rather decide to recalibrate to keep
> that error proportionally small compared to the target loops per
> jiffy value, like it worked in my initial proposal? I think that
> your argument about unnecessarily wasting 10s of milliseconds has
> marginal importance here because we will be redoing that calibration
> only once, at boot time, and never later until next reboot.

It really doesn't matter - udelay() etc is not designed to be mega
accurate but good enough.  The fact is that it has always produced a
delay of approximately the value requested of it (and normally it
would produce a slightly shorter delay) and that's a fact of life
that driver authors should already be dealing with.

So, your patch is fine.

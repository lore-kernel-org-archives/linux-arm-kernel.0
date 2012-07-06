From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 6 Jul 2012 09:32:21 +0200
Subject: MX28 poweroff issue
In-Reply-To: <20120705201002.GB31508@n2100.arm.linux.org.uk>
References: <201207040030.36713.marex@denx.de>
 <CAOMZO5Ab-Zibnn-tVfTz5BNJsqJer88jZLVa5Een9DDZ3tdssg@mail.gmail.com>
 <20120704093823.8e74d48bc8d9918a9c80fbcf@kinali.ch>
 <201207041631.30107.marex@denx.de>
 <20120704151944.GB18739@n2100.arm.linux.org.uk>
 <20120705160855.GA20175@S2101-09.ap.freescale.net>
 <20120705201002.GB31508@n2100.arm.linux.org.uk>
Message-ID: <20470.38021.796461.625280@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Russell King - ARM Linux writes:
> On Fri, Jul 06, 2012 at 12:08:58AM +0800, Shawn Guo wrote:
> > On Wed, Jul 04, 2012 at 04:19:44PM +0100, Russell King - ARM Linux wrote:
> > > If it's specific to mx28 and mx23 and nothing else, the cause needs to
> > > be found.  Maybe we need it tested on other (non-MX) platforms too?
> > 
> > Though people reported that imx27 does not have the problem, I'm not
> > so sure about it's a mach-mxs (mx23 and mx28) specific issue.  I have
> > not figured it out why imx27 does not run into it, but I got some
> > finding here.
> > 
> > Let's look at the dump again.
> > 
> > [   59.840000] System halted.
> > [   84.100000] BUG: soft lockup - CPU#0 stuck for 23s! [halt:584]
> > ...
> > [   84.100000] [<c0070cd4>] (watchdog_timer_fn+0x114/0x14c) from [<c004052c>]
> > (__run_hrtimer+0x7c/0x1ec)
> > 
> > It reports the issue eventually in function watchdog_timer_fn
> > (kernel/watchdog.c):
> 
> Yes, the general idea is that if the timer is running, and the watchdog
> is running, and it detects that it's event thread doesn't occasionally
> run, it will report a lockup.
> 
> As other platforms seem to not exhibit the problem when we halt, and
> endlessly spin with IRQs enabled, the question needs to be asked: what
> is different with MX23/MX28 and why is it different.
> 
I could reproduce this on an i.MX53 (TX53) platform too. Maybe the
softlockup watchdog was not enabled on those platforms which didn't
show this behaviour.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

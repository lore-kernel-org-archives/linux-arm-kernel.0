From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 12 Jun 2016 12:27:02 +0200 (CEST)
Subject: ARM: mxs: warnings on PM resume
In-Reply-To: <2607020.0FcLMf1DX6@vostro.rjw.lan>
References: <1713040590.199779.36789782-c361-4fe4-bc0d-b581fbce8069.open-xchange@email.1und1.de>
 <1955365225.76161.cd9a3eda-edc7-4bae-96f3-bdddccbb0478.open-xchange@email.1und1.de>
 <2607020.0FcLMf1DX6@vostro.rjw.lan>
Message-ID: <908847370.85504.d47d66b7-356b-4e07-9e1d-807a299ea337.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

> "Rafael J. Wysocki" <rjw@rjwysocki.net> hat am 11. Juni 2016 um 03:42
> geschrieben:
> 
> 
> On Saturday, June 11, 2016 03:01:31 AM Stefan Wahren wrote:
> > Hi,
> > 
> > [add Rafael, J?rg and J?rgen to CC]
> > 
> > > Stefan Wahren <stefan.wahren@i2se.com> hat am 1. Juni 2016 um 22:51
> > > geschrieben:
> > > 
> > > 
> > > Hi,
> > > 
> > > i'm currently working on standby support for MXS platform. If i trigger
> > > the
> > > standby per sysfs everything works fine, but mostly on resume i get a
> > > bunch of
> > > warnings (see below for full output):
> > > 
> > > [   67.040000] Interrupts enabled before system core resume.
> > > 
> > > My current working branch [1] based on Linux 4.5 ( cmdline has
> > > no_console_suspend=1 ). The test hardware is a i.MX23 board (
> > > iMX233-OLinuXino-MAXI ).
> > > 
> > > How can i narrow down this issue to the relevant driver / interrupt ?
> > > 
> > > What is the right way to fix this issue?
> > > 
> > 
> > any hints or ideas to narrow down this issue are very welcome.
> 
> Interrupts should not be enabled before syscore_resume() is called, but they
> are, apparently by the platform code.

sure, but it isn't that simple. I can't reproduce the warning everytime. At
least i need 5 tries and more to reproduce it.

I place the following code in the suspend code, before the low level suspend
code in SRAM gets executed:

if (!irqs_disabled())
	pr_info("IRQs not disabled before suspend\n");

The info message above only get printed if the warning "Interrupts enabled
before system core resume." appears.

After that i dumped all enabled IRQs (at the same code place) from the interrupt
collector (irqchip) and compared them with cat /proc/interrupts. I noticed that
the dump contains all interrupt from /proc/interrupts plus the IRQs from the 3
GPIO banks, which were not listed under PROC FS.

So i take a look at the GPIO driver gpio-mxs.c and noticed that it seems to miss
the flag IRQCHIP_MASK_ON_SUSPEND compared to a driver gpio-mxc.c for very
similiar hardware. Unfortunately adding the flag in the GPIO driver doesn't fix
the issue.

So any hints about narrowing down the issue would be helpful.

Stefan

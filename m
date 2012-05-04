From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2012 10:24:18 -0700
Subject: [PATCH 1/2] OMAP2+: UART: Fix incorrect population of default
 uart pads
In-Reply-To: <CAMrsUdKnDaO7qV2NpNvTb3QdO-XeM_PF645Mc43RozFVex71hQ@mail.gmail.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
 <1334065246-21294-2-git-send-email-govindraj.raja@ti.com>
 <87397uhv0q.fsf@ti.com>
 <CAMrsUdKnDaO7qV2NpNvTb3QdO-XeM_PF645Mc43RozFVex71hQ@mail.gmail.com>
Message-ID: <20120504172417.GE5613@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Raja, Govindraj <govindraj.raja@ti.com> [120424 01:41]:
> On Tue, Apr 24, 2012 at 5:15 AM, Kevin Hilman <khilman@ti.com> wrote:
> > "Govindraj.R" <govindraj.raja@ti.com> writes:
> >
> >> From: "Govindraj.R" <govindraj.raja@ti.com>
> >>
> >> The following commit:
> >> (7496ba3 ?ARM: OMAP2+: UART: Add default mux for all uarts)
> >> added default pads for all uarts. But not all boards tend to
> >> use all uarts and most of unused uart pins are muxed for
> >> other purpose. This commit breaks the modules which where trying
> >> to use unused uart pins on their boards.
> >>
> >> So remove the default pads adding.
> >
> > I just noticed that this patch breaks runtime PM & wakeups for UART
> > console (at least on 3530/Overo with ttyO2 console.)
> >
> > By removing the pads, the initial device_init_wakeup() is not called on
> > port init. ?Without this call serial_omap_pm() disables runtime PM
> > because it checks device_may_wakeup().
> >
> > Since runtime PM was disabled, I manually re-enabled it and then enabled
> > wakeups:
> >
> > ?echo auto > /sys/devices/platform/omap_uart.2/power/control
> > ?echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup
> >
> > Then, after enabling auto-suspend timeouts, it seems wakeups are still
> > not working since the console hangs.
> >
> > Reverting $SUBJECT patch gets things working again.
> 
> This was decided as part of discussion [1]
> 
> If we are _reconsidering_ taking this patch [2]
> to dynamically probe uart pins and enable rx wakeup.
> 
> I can re-work on the patch[2] as per tony's comments[1]
> and re-post it.
 
Just to follow up on this.. Let's first get things working reliably,
and only then add more PM support.

We absolutely can't revert $SUBJECT because it's known to mess up
at least smsc911x and ehci on zoom3, hsi on n900 and probably
many other things.

For the -rc cycle, it seems that [2] is out of question at this point
as too intrusive. If the PM & wakeups are broken in the default cases,
then I suggest we just take few steps back and disable any deeper PM
states in the -rc series.

Regards,

Tony

 
> [1]:
> http://www.spinics.net/lists/linux-omap/msg68226.html
> 
> [2]:
> http://www.spinics.net/lists/linux-omap/msg67822.html

From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Feb 2012 10:00:45 -0800
Subject: [PATCH] gpio/omap: fix wakeups on level-triggered GPIOs
In-Reply-To: <CAC83ZvKXSwSsU_hu7hrPV6DmVYv=G3iF7Wb5hF_qhSiL+BpfaQ@mail.gmail.com>
References: <1329850878-22189-1-git-send-email-khilman@ti.com>
 <CAC83ZvKXSwSsU_hu7hrPV6DmVYv=G3iF7Wb5hF_qhSiL+BpfaQ@mail.gmail.com>
Message-ID: <20120222180045.GW18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [120222 08:46]:
> On Wed, Feb 22, 2012 at 12:31 AM, Kevin Hilman <khilman@ti.com> wrote:
> > While both level- and edge-triggered GPIOs are capable of generating
> > interrupts, only edge-triggered GPIOs are capable of generating a
> > module-level wakeup to the PRCM (c.f. 34xx NDA TRM section 25.5.3.2.)
> >
> > In order to ensure that devices using level-triggered GPIOs as
> > interrupts can also cause wakeups (e.g. from idle), this patch enables
> > edge-triggering for wakeup-enabled, level-triggered GPIOs when a GPIO
> > bank is runtime-suspended (which also happens during idle.)
> >
> > This fixes a problem found in GPMC-connected network cards with GPIO
> > interrupts (e.g. smsc911x on Zoom3, Overo, ...) where network booting
> > with NFSroot was very slow since the GPIO IRQs used by the NIC were
> > not generating PRCM wakeups, and thus not waking the system from idle.
> > NOTE: until v3.3, this boot-time problem was somewhat masked because
> > the UART init prevented WFI during boot until the full serial driver
> > was available. ?Preventing WFI allowed regular GPIO interrupts to fire
> > and this problem was not seen. ?After the UART runtime PM cleanups, we
> > no longer avoid WFI during boot, so GPIO IRQs that were not causing
> > wakeups resulted in very slow IRQ response times.
> >
> > Tested on platforms using level-triggered GPIOs for network IRQs using
> > the SMSC911x NIC: 3530/Overo and 3630/Zoom3.
> >
> > Reported-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> 
> I have tested on OMAP3430 by making modification to touchscreen GPIO.
> (I had similar change in my next planned cleanup/fix series.)
> If needed you can add my Tested-by:

Work for me too:

Tested-by: Tony Lindgren <tony@atomide.com>

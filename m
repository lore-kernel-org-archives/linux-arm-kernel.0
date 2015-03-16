From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 16 Mar 2015 21:32:52 +0100
Subject: PM: knowing the system state in the device callback
In-Reply-To: <20150316205245.1b66bbea@bbrezillon>
References: <20150316191742.GI4560@piout.net>
 <20150316205245.1b66bbea@bbrezillon>
Message-ID: <20150316203252.GA3821@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Mon, Mar 16, 2015 at 08:52:45PM +0100, Boris Brezillon wrote:
> Hi Alexandre,
> 
> On Mon, 16 Mar 2015 20:17:42 +0100
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> > Hi,
> > 
> > I'm trying to get rid of at91_suspend_entering_slow_clock() which is
> > exposing the platform suspend_state_t to the devices. From what I
> > understand, whenever suspend_state_t is PM_SUSPEND_MEM or
> > PM_SUSPEND_STANDBY, the pm_message_t passed to the device driver is
> > always PM_EVENT_SUSPEND.
> > 
> > The requirement is to know whether we are going to cut the master clock
> > and in that case, avoid calling enable_irq_wake() because we will not be
> > able to wakeup from the device.
> 
> Actually the master clock is never switched off, we're only changing
> its source (from PLLA to slow clk) which in turn changes its rate.

That's more or less the same, the master clock set to 32k is unusable 
for almost all devices. I guess all except some very simple devices like 
GPIO, AIC and PM controller.


> > Is there a better way to do that? Or should I implement a similar
> > function in the pm core (which I guess would already be there if
> > really needed)?
> 
> IMHO we should let devices (RTC/RTT, debug UART, GPIOC, ...) mark their
> interrupt line as a wakeup interrupt, and adapt the device
> configuration (UART baudrate, ...) according to the new master clock
> rate instead of testing the suspend mode to check whether we can mark
> irq lines as wakeup sources or not.

We are using a 32k clock, 115.2 bits/s which is very common is 3.5x 
faster than tje 32k clock. And, to reduce a bit more the memory 
consumption we can switch of to the 32k RC and not OSC (I do!), which is 
?10% off, that's way too much for UART.

Also, if standby target is chosen, we are able to wake up on USB Host 
wake-up events, which needs the USB PLL to be running. If mem target is 
chosen we are going to switch off the USB PLL because we are going to 
switch off the PLL source, the master clock, in this case we most ensure 
all USB drivers switches off their controller (this is what my USBA and 
EHCI/OHCI PM series did).


> The fact that we're disabling PLLA is not really related to
> suspend-to-ram mode (we could leave the master clock unchanged and
> still put the SDRAM chip in self-refresh mode).

This is what we do in standby target.


> The problem here is that we need some kind of notifier infrastructure
> that would be called before the master clock source is switched to slow
> clock. This notifier must be written in asm so that it can be called
> from the asm code executed from SRAM (the SDRAM chip is placed in self
> refresh before switching to slow clock).

I don't think that's possible, some drivers needs to know the master 
clock is going to be switched off (USB).


Sylvain

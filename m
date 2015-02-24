From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 24 Feb 2015 09:42:15 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <5209097.N5537nGsQV@vostro.rjw.lan>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <5225828.OI8hbGqrC4@vostro.rjw.lan>
 <20150220103144.GI13659@leverpostej>
 <5209097.N5537nGsQV@vostro.rjw.lan>
Message-ID: <20150224094215.13416570@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Tue, 24 Feb 2015 02:02:59 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Friday, February 20, 2015 10:31:44 AM Mark Rutland wrote:
> > [...]
> 
> [cut]
>  
> > Given all of the above I'll go back to the IRQF_SHARED_TIMER_OK approach
> > you proposed, along with documentation updates and comments at usage
> > sites to make it clear when it is valid to use.
> > 
> > Thank you for bearing with me so far.
> 
> No prob. :-)
> 
> Actually, there's one more approach possible.  Thomas might not like it, but
> here it goes anyway for consideration.
> 
> What about making it possible to provide a special irqaction to be called
> while suspended for the shared IRQF_NO_SUSPEND interrupts.
> 
> Say we have a "suspended_action" pointer in struct irq_desc in addition to
> "action" and we swap them in suspend_device_irq() if desc->no_suspend_depth is
> nonzero and "suspended_action" is not NULL (and then back in resume_irq()).
> Then, the platform might supply "suspended_action" that will do the right
> thing for the IRQ.
> 
> So the requirement would be to have "suspended_action" set to start with
> and then the WARN_ON() in irq_pm_install_action() may check if that is present
> and only trigger the warning if it isn't.
> 
> Thoughs?

That should work for my case.
Note that I also proposed a version that does not touch the irq_desc
struct, but I had to add an irq_is_wakeup_armed helper function to
test in which state the irq handler is called. Your solution would make
this easier.

Could you remind me what was Thomas concern regarding this suspended
action list approach ?

Boris



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

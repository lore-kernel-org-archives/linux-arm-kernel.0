From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 24 Feb 2015 02:02:59 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150220103144.GI13659@leverpostej>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <5225828.OI8hbGqrC4@vostro.rjw.lan> <20150220103144.GI13659@leverpostej>
Message-ID: <5209097.N5537nGsQV@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 20, 2015 10:31:44 AM Mark Rutland wrote:
> [...]

[cut]
 
> Given all of the above I'll go back to the IRQF_SHARED_TIMER_OK approach
> you proposed, along with documentation updates and comments at usage
> sites to make it clear when it is valid to use.
> 
> Thank you for bearing with me so far.

No prob. :-)

Actually, there's one more approach possible.  Thomas might not like it, but
here it goes anyway for consideration.

What about making it possible to provide a special irqaction to be called
while suspended for the shared IRQF_NO_SUSPEND interrupts.

Say we have a "suspended_action" pointer in struct irq_desc in addition to
"action" and we swap them in suspend_device_irq() if desc->no_suspend_depth is
nonzero and "suspended_action" is not NULL (and then back in resume_irq()).
Then, the platform might supply "suspended_action" that will do the right
thing for the IRQ.

So the requirement would be to have "suspended_action" set to start with
and then the WARN_ON() in irq_pm_install_action() may check if that is present
and only trigger the warning if it isn't.

Thoughs?

Rafael

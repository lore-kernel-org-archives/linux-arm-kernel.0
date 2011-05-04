From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 May 2011 11:09:14 +0100
Subject: [PATCH v2 05/12] OMAP: Serial: Hold console lock for console
	usage.
In-Reply-To: <20110504100232.GA2092@atomide.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-6-git-send-email-govindraj.raja@ti.com>
	<20110504100232.GA2092@atomide.com>
Message-ID: <20110504100914.GA25495@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 04, 2011 at 03:02:33AM -0700, Tony Lindgren wrote:
> * Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
> >
> > Also during bootup console_lock is not available.
> >        --> uart_add_one_port
> > 	   --> console_register
> > 	       --> console_lock
> > 	        --> console_unlock
> > 	             --> call_console_drivers (here yet console_lock is not released)
> > 		          --> uart_console_write
> > 
> > Hence convert prints from omap_device_enable/disable to pr_debug.
> 
> This sounds like a hack considering we have things working with
> pr_debug currently.

It also highlights a different problem: stuffing subsystems full of
debug, and keeping it way after the subsystem has been brought to a
working state not only adds code bloat but also can cause additional
bugs.

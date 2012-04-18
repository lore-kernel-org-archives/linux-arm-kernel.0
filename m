From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Apr 2012 16:02:09 +0100
Subject: [PATCH] tty: omap-serial: Keep the wakeup mechanism enabled by
 default
In-Reply-To: <87mx69nms2.fsf@ti.com>
References: <1334579407-16970-1-git-send-email-govindraj.raja@ti.com>
 <87vckyq6ti.fsf@ti.com>
 <CAMrsUdL1S5GiyG0egS=CHg2fdNkyZVF-wuCNGDg547kfTUODng@mail.gmail.com>
 <87mx69nms2.fsf@ti.com>
Message-ID: <20120418150209.GO25053@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 07:21:33AM -0700, Kevin Hilman wrote:
> "Raja, Govindraj" <govindraj.raja@ti.com> writes:
> 
> > On Wed, Apr 18, 2012 at 4:55 AM, Kevin Hilman <khilman@ti.com> wrote:
> >> "Govindraj.R" <govindraj.raja@ti.com> writes:
> >>
> >>> From: "Govindraj.R" <govindraj.raja@ti.com>
> >>>
> >>> The wakeups can be left enabled by default and should be disabled
> >>> only when disabled from sysfs and while entering suspend.
> >>
> >> Left enabled? ?That assumes something else has initizlied them, but we
> >> can't make that assumption.
> >>
> >> First, wakeups should be disabled when ->probe has finished. ?Then,
> >> they should be enabled whenever driver is in use, and disabled when
> >> the driver is not in use.
> >>
> >> I'm not familiar enough with uart_ops, but it looks like they should
> >> probably be enabled in uart_ops->startup and disabled in
> >> uart_ops->shutdown.
> >
> > uart_ops->shutdown gets called in suspend path also
> > serial_omap_suspend => uart_suspend_port = > ops->shutdown(uport);
> >
> > This will leave uart wakeup disabled in suspend path.
> 
> As I said, I'm not familiar enough with uart_ops to know which are the
> right ones.
> 
> Maybe ->request_port and ->release_port are the right ones?

No, the clue's there in the name - these are supposed to be for resource
management.  They only get called when the port is first acquired by the
driver, and released when the port is no longer required (iow, they
cover the span in time where the driver is capable of using the device.)
They don't tell you about the lifetime that the user has the port open.

> The point is that wakeups should be enabled whenever driver is in use,
> and disabled when the driver is not in use.

Well, we don't actually tell low level drivers that kind of detail (we
assume they're rather dumb - which maybe we shouldn't.)

It looks to me like there is the possibility of checking the TTY port
flags to see whether ASYNC_INITIALIZED is set - this will be clear in
->shutdown() method if the user is closing the port, otherwise it will
be set.  Same goes for the ->startup() method.

I'm not sure whether Alan would allow that kind of knowledge in low
level serial drivers though...

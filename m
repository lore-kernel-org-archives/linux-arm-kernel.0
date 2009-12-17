From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Dec 2009 18:17:18 +0000
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
In-Reply-To: <84fc9c000912170917y4b2772d0n47bb4dabc74b91ef@mail.gmail.com>
References: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091217150120.GD24967@shareable.org>
	<4B2A65C6.7080009@caviumnetworks.com>
	<84fc9c000912170917y4b2772d0n47bb4dabc74b91ef@mail.gmail.com>
Message-ID: <20091217181718.GA4440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 06:17:11PM +0100, Richard Guenther wrote:
> On Thu, Dec 17, 2009 at 6:09 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> > Jamie Lokier wrote:
> >>
> >> Uwe Kleine-K?nig wrote:
> >>>
> >>> Use the new unreachable() macro instead of for(;;);
> >>> ? ? ? ?*(int *)0 = 0;
> >>> ? ? ? ? ?/* Avoid "noreturn function does return" */
> >>> - ? ? ? for (;;);
> >>> + ? ? ? unreachable();
> >>
> >> Will GCC-4.5 remove ("optimise away") the *(int *)0 = 0 because it
> >> knows the branch of the code leading to unreachable can never be reached?
> >>
> >
> > I don't know the definitive answer, so I am sending to gcc at ...
> >
> > FYI: #define unreachable() __builtin_unreachable()
> 
> It shouldn't as *(int *)0 = 0; might trap.  But if you want to be sure
> use
>    __builtin_trap ();
> instead for the whole sequence (the unreachable is implied then).
> GCC choses a size-optimal trap representation for your target then.

How is "size-optimal trap" defined?  The point of "*(int *)0 = 0;" is
to cause a NULL pointer dereference which is trapped by the kernel to
produce a full post mortem and backtrace which is easily recognised
as a result of this code.

Having gcc decide on, maybe, an undefined instruction instead would be
confusing.

Let me put it another way: I want this function to terminate with an
explicit NULL pointer dereference in every case.

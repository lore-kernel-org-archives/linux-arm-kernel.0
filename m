From: jonas@orbital-systems.com (Jonas Danielsson)
Date: Fri, 19 Oct 2018 12:30:05 +0200
Subject: [PATCH] power: reset: at91-reset: enable I-cache for
 at91sam9260_reset
In-Reply-To: <11b4bcb4-8882-bdd2-c7f7-6a74d0758cbc@microchip.com>
References: <20181007125815.8392-1-jonas@threetimestwo.org>
 <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com>
 <2351196.3BzoFE0xYq@ws-140106>
 <CALDOjzhZg3X1y22KE1yw_0ZFjuvaa=3GhEF2iU=KUk6-eRZN2g@mail.gmail.com>
 <11b4bcb4-8882-bdd2-c7f7-6a74d0758cbc@microchip.com>
Message-ID: <CALDOjzhgqcx5XEWon9EQXEGxt9J280Z6AvuFQcBa=nh-9VA6PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 3:10 PM <Claudiu.Beznea@microchip.com> wrote:
>
> >
> > We take the normal path of sys_reboot => kernel_restart => machine_restart ...
> >
> > I added code to print the c1 register in different paths. And I-cache
> > is enabled.
> > So now I am really confused about why the patch worked.
>
> Just saying... maybe your instructions add some delay on the execution path
> and this is why it helps... try to access cp15 co-processor for read and
> write back the value you read without actually to modify it, to see if this
> could be the reason: e.g.:
>
> mrc     p15, 0, r0, c1, c0, 0
> orr     r1, r1, #4096           // whatever is in r1, doesn't matter
> mcr     p15, 0, r0, c1, c0, 0
>

Yes, this also seems to work. I have over 100 reboots completed with this code.
So what could be the issue here? It seem related to the powering down
of the sdram at least.

This thread on the AT91SAM community deals with the same issue:
http://www.at91.com/viewtopic.php?t=25830
There the solution people chose was removing the SDRAM powering down.
But that leaves one open to the cause of the errata.

Do you have any thought on how to approach this?

> Thank you,
> Claudiu Beznea
>

Regards
Jonas


> >
> >> Best regards,
> >> Alexander
> >
> > Jonas
> >
> >>
> >>
> >>
> >
> >



-- 






JONAS DANIELSSON
Software Developer

+46 72 361 5022
Malm? - Sweden

ORBITAL SYSTEMS
orbital-systems.com




The information contained in this message is intended for the personal
and confidential use of the designated recipients named above and may
contain confidential and/or privileged material. If the reader of this
message is not the intended recipient or an agent responsible for
delivering it to the intended recipient, you are hereby notified that
you have received this document in error, and that any review,
dissemination, distribution, or copying of this message is strictly
prohibited. If you have received this communication in error, please
notify the sender immediately and delete this e-mail from your system.

Although this transmission and any attachments are believed to be free
of any virus or other defect that might affect any computer system
into which it is received and opened, it is the responsibility of the
recipient to ensure that it is virus free and no responsibility is
accepted by ORBITAL SYSTEMS AB, its subsidiaries and affiliates, as
applicable, for any loss or damage arising in any way.

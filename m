From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Apr 2014 13:52:14 -0700
Subject: [PATCH v3 2/2] dt: platform driver: Fill the resources before
 probe and defer if needed
In-Reply-To: <CAL_Jsq+aU+rs28gV=Gesb_-Dy6Ht7zuKrRA6_hmqp94Uun23Yg@mail.gmail.com>
References: <20140320161118.B7075C4067A@trevor.secretlab.ca>
 <1395413185-29763-1-git-send-email-jjhiblot@traphandler.com>
 <1395413185-29763-3-git-send-email-jjhiblot@traphandler.com>
 <CAL_Jsq+aU+rs28gV=Gesb_-Dy6Ht7zuKrRA6_hmqp94Uun23Yg@mail.gmail.com>
Message-ID: <20140418205213.GA21823@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [140411 10:33]:
> On Fri, Mar 21, 2014 at 9:46 AM, Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
> > The goal of this patch is to allow drivers to be probed even if at the time of
> > the DT parsing some of their IRQ ressources are not available yet.
> >
> > In the current situation, the IRQ resources of a platform device are filled from
> > the DT at the time the device is created (of_device_alloc()). The drawback of
> > this is that a device sitting close to the top of the DT (ahb for example) but
> > depending on ressources that are initialized later (IRQ domain dynamically
> > created for example) will fail to probe because the ressources don't exist
> > at this time.
> 
> s/ressources/resources/

While I've tested these two patches and they fix the issue for me. I have
some serious doubts again about this whole ------ up string parsing
pile of ---- called device tree.

Do we really need to sprinkle more of_* hacks to the irq subsystem?

There's nothing wrong with with the irq subsystem. Platform bus is just
calling the irq subsystem at the wrong time with uninitialized data.

It seems that we're again papering over the fact that there's nothing
coordinating the setting up of various resources with device tree.
That seems to be the repeating never ending pattern as we've already
seen with GPIOs, pinctrl, and IRQchips. We end up adding all kinds of
cross subsystem calls that were never needed earlier.

Regards,

Tony

From: w@1wt.eu (Willy Tarreau)
Date: Wed, 24 Feb 2016 23:56:41 +0100
Subject: [PATCH 1/2] ARM: mvebu: change order of ethernet DT nodes on
 Armada 38x
In-Reply-To: <20160224223350.GP19428@n2100.arm.linux.org.uk>
References: <1453907300-28283-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453907300-28283-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160127193143.GF10826@n2100.arm.linux.org.uk>
 <20160127194512.GA16638@1wt.eu>
 <20160129114853.GQ10826@n2100.arm.linux.org.uk>
 <20160224184114.GB2292@1wt.eu>
 <20160224223350.GP19428@n2100.arm.linux.org.uk>
Message-ID: <20160224225641.GC2333@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 10:33:50PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 24, 2016 at 07:41:14PM +0100, Willy Tarreau wrote:
> > Hi Russell,
> > Well, now I'm one of these and I confirm that it's really painful to
> > have a different ordering between the DTB provided in mainline and the
> > DTB provided with the board. The worst thing is that using mainline,
> > eth0 corresponds to the switch and appears up, so you don't immediately
> > realize that it's not where your cable is connected :-/
> > 
> > Thus could we please get Thomas' patch to ensure that the board boots
> > with similar interface naming with both the original and mainline kernel ?
> 
> I didn't say no to it, I merely asked a few pertinent questions and
> made some pertinent points.

Yes I'm well aware, which is why I was bringing some feedback.

> Let me restate:
> 
> * Today, people who switch between mainline and vendor kernels
>   experience some pain due to the NIC order changing.
> 
> * Mainline has had support for Armada 38x for 2 years now, which is
>   long enough for it to have gained users.

I didn't realize it had been *that* long, I thought early support was
very limited, but I can indeed see that the first dtsi was already
fairly complete (though lots of patches came up recently, including
one to disable IP checksumming on jumbo frames that's only 3 months
old).

>   AFAICS, there haven't been
>   any complaints about the different NIC ordering.  Changing the NIC
>   ordering is going to cause breakage to these users when they migrate
>   across the change.

Yes, and the problem is that there are two expected breakages : going from
LSP to "old mainline" and going from "old mainline" to "new mainline".
Since boards ship with LSP by default, I think that not doing the change
will lead to causing breakage at least once for each user going to
mainline, while doing it will only cause breakage to users who have
already experienced breakage.

> By making the change, we're effectively telling these mainline-only
> users "we don't care about your setups, we're going to break them"
> because that's exactly what we're going to do.

Not exactly, we're telling "if you moved away from the original kernel,
you have already experienced breakage so apparently you know how to fix
it, and if it's the first time you move away from it you won't notice
anything" :-)

> Of course, if no one complains about the change, you've got away
> with it.
> 
> I think the folk who want to make this change should be prepared for
> userspace breakage reports: Linus feels very strongly about zero
> userspace regressions, as we all should know.

Oh yes and I've always agreed with him regarding this!

> What I'm saying, therefore, is make the change, but if you have one
> report that someone's userspace setup has broken as a result of the
> change, the change must be reverted.

Makes sense. If any breakage is reported, it would be interested to
know if it's on a multi-port board or single-port one.

Thanks,
Willy

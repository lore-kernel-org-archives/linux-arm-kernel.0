From: ijc@hellion.org.uk (Ian Campbell)
Date: Fri, 08 Nov 2013 10:25:55 +0000
Subject: [linux-sunxi] [PATCH 2/2] ARM: sun6i: Add SMP support for the
 Allwinner A31
In-Reply-To: <20131108084056.GB26440@lukather>
References: <1383471013-21695-1-git-send-email-maxime.ripard@free-electrons.com>
 <1383471013-21695-3-git-send-email-maxime.ripard@free-electrons.com>
 <1383583997.8826.123.camel@kazak.uk.xensource.com>
 <20131108084056.GB26440@lukather>
Message-ID: <1383906355.3189.77.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-11-08 at 09:40 +0100, Maxime Ripard wrote:
> > I'm trying to work out if we can make this work with the requirement
> > which both Xen and KVM have to enter the kernel in NS-HYP mode.
> > 
> > The way this works on e.g. vexpress is (roughly) that u-boot wakes up
> > the secondary CPUs from the lowlevel firmware and places them into its
> > own holding pen, which has the same wake up protocol as the firmware so
> > the kernel can just use the same code. If u-boot never gets to run on
> > secondary CPUs that isn't going to help much. 
> > 
> > My concern is that the sequence here appears to involve resetting the
> > secondary CPU, which I figure will probably defeat that strategy by
> > kicking the CPU back into the lowlevel firmware in the reset state,
> > meaning it can't be done by a u-boot only change.
> 
> I think this is where we're headed for the A20, Marc was interested in
> doing that,

Marc Zyngier is that?

>  since we already have pretty much this in u-boot already,
> however, this is not the case for the A31.

> As far as I know, the Allwinner's bootloader that we currently use
> isn't bringing up the secondary CPUs, and we don't have any port of
> some sort of u-boot yet that we could work on.

Ah, OK. I'd assumed that A20 and A31 (indeed, most sunxi platforms) were
mostly equivalent as far as u-boot support went.

> So, I guess we don't really have much choice in that case, even though
> eventually I'd like to have this for the A31 too.

Right, I suppose it makes sense to consider what we want to do on the
A20 now and keep in mind that A31 may want to follow in the future.

> > Hrm, what to do ... perhaps a DT driven selection between this mechanism
> > and sev to kick a wfe loop reading the private register?
> 
> We can discuss this whenever we will actually have that choice to
> make, but maybe a kernel parameter would be better?

I don't think so -- u-boot would then have to munge the command line to
say that it had/had not brought up secondaries. DTB seems more natural
to me. e.g. on ARMv8 there is already a requirement to provide a per-CPU
property describing the bringup protocol ("PSCI" and "spintable" are the
options there).

Anyway, once I get to the point of being able to do something I'll
coordinate with Marc etc and figure out what to do. In the meantime I
think having the kernel do the bringup (like this patch does) is
sensible. It's very likely to be what we want to do in the absence of
any instruction to the contrary (DTB or otherwise) in the future anyway.

Thanks,

Ian.

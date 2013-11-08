From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 8 Nov 2013 09:40:56 +0100
Subject: [linux-sunxi] [PATCH 2/2] ARM: sun6i: Add SMP support for the
 Allwinner A31
In-Reply-To: <1383583997.8826.123.camel@kazak.uk.xensource.com>
References: <1383471013-21695-1-git-send-email-maxime.ripard@free-electrons.com>
 <1383471013-21695-3-git-send-email-maxime.ripard@free-electrons.com>
 <1383583997.8826.123.camel@kazak.uk.xensource.com>
Message-ID: <20131108084056.GB26440@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On Mon, Nov 04, 2013 at 04:53:17PM +0000, Ian Campbell wrote:
> Not a comment on the patch, or even A31, but a question about how the
> SMP boot process works on sunxi generally...
> 
> On Sun, 2013-11-03 at 10:30 +0100, Maxime Ripard wrote:
> > The A31 is a quad Cortex-A7. Add the logic to use the IPs used to
> > control the CPU configuration and the CPU power so that we can bring up
> > secondary CPUs at boot.
> > [...]
> > +	/* Set CPU boot address */
> > +	writel(virt_to_phys(sun6i_secondary_startup),
> > +	       cpucfg_membase + CPUCFG_PRIVATE0_REG);
> 
> Does the secondary CPU jump straight here from the lowlevel firmware or
> does it go through the bootloader which reads the reg and does the jump?
> I can't see any reference to this reg in u-boot so I guess the former?

There's no reference of this either in the A31 datasheet (or at least,
none I could find), so I assume the former too.

> I'm trying to work out if we can make this work with the requirement
> which both Xen and KVM have to enter the kernel in NS-HYP mode.
> 
> The way this works on e.g. vexpress is (roughly) that u-boot wakes up
> the secondary CPUs from the lowlevel firmware and places them into its
> own holding pen, which has the same wake up protocol as the firmware so
> the kernel can just use the same code. If u-boot never gets to run on
> secondary CPUs that isn't going to help much. 
> 
> My concern is that the sequence here appears to involve resetting the
> secondary CPU, which I figure will probably defeat that strategy by
> kicking the CPU back into the lowlevel firmware in the reset state,
> meaning it can't be done by a u-boot only change.

I think this is where we're headed for the A20, Marc was interested in
doing that, since we already have pretty much this in u-boot already,
however, this is not the case for the A31.

As far as I know, the Allwinner's bootloader that we currently use
isn't bringing up the secondary CPUs, and we don't have any port of
some sort of u-boot yet that we could work on.

So, I guess we don't really have much choice in that case, even though
eventually I'd like to have this for the A31 too.

> Hrm, what to do ... perhaps a DT driven selection between this mechanism
> and sev to kick a wfe loop reading the private register?

We can discuss this whenever we will actually have that choice to
make, but maybe a kernel parameter would be better?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131108/cdb8410f/attachment.sig>

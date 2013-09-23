From: ijc@hellion.org.uk (Ian Campbell)
Date: Mon, 23 Sep 2013 08:18:56 +0100
Subject: [PATCH 1/3] Add smp support for Allwinner A20(sunxi 7i).
In-Reply-To: <CAK3cCBzMXdeeSPC-OpWcHAuef=ocpy5n0=Fc2yBECPnU=2OTXw@mail.gmail.com>
References: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
 <1379852488-32147-2-git-send-email-cinifr@gmail.com>
 <1379861045.30708.22.camel@dagon.hellion.org.uk>
 <CAK3cCBzMXdeeSPC-OpWcHAuef=ocpy5n0=Fc2yBECPnU=2OTXw@mail.gmail.com>
Message-ID: <1379920736.30708.26.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-09-22 at 23:31 +0800, cinifr wrote:
> 
> 
> On Sunday, 22 September 2013, Ian Campbell <ijc@hellion.org.uk> wrote:
> > On Sun, 2013-09-22 at 20:21 +0800, Fan Rong wrote:
> >
> >> +     /* Set boot addr */
> >> +     paddr = virt_to_phys(sun7i_secondary_startup);
> >> +     writel(paddr, sunxi7i_cc_base + SUN7I_CPUCFG_BOOTADDR);
> >
> > This means that the secondary cores will miss out on any setup which
> the
> > bootloader might have done for the primary CPU, e.g. switching to NS
> HYP
> > mode, setting the CNTFRQ etc.
> Yes, I think that is what bootloader should do.

In which case this kernel patch needs instead to speak the bootloader
wakeup protocol instead of speaking to the h/w directly like you've done
here, right?

Or is it possible for the bootloader to set these things up and then put
the CPU back to sleep such that it both retains any settings and is
wakable by this patch? This code contains core resets and power control,
which makes me suspect not.

> > Wouldn't it be better to do all this stuff in the bootloader and
> either
> > implement PSCI or have the bootloader do the traditional holding pen
> and
> > mbox address thing?
> >
> I have modified uboot to set cntfrq and cntvoff in all smp cpus,and it
> works well. I guess kernel should believe all cpu should be all same
> when kernel boot. Bootloader should do it to ensure that.

Yes, I think all CPUs must be in the same state at boot.

But if you've done all that then what is this patch for?

Do you have links to your u-boot patches?

Ian.

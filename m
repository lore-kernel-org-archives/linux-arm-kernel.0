From: csd@broadcom.com (Christian Daudt)
Date: Fri, 26 Jul 2013 12:09:03 -0700
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <20130726184702.GW24642@n2100.arm.linux.org.uk>
References: <20130726145639.116237136@gmail.com>
 <20130726151223.045835540@gmail.com>
 <20130726152918.GL29916@titan.lakedaemon.net>
 <51F29BFE.8000202@broadcom.com>
 <20130726171153.GN29916@titan.lakedaemon.net>
 <51F2AF2D.1000300@broadcom.com>
 <20130726184702.GW24642@n2100.arm.linux.org.uk>
Message-ID: <51F2C94F.6020405@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-07-26 11:47 AM, Russell King - ARM Linux wrote:
> On Fri, Jul 26, 2013 at 10:17:33AM -0700, Christian Daudt wrote:
>> Because ARCH_BCM is meant to be used for a number of SoC families. We've
>> started upstreaming one (the BCM281XX) but have 2 more internally that
>> we're working towards upstreaming. And in the future our plan is to keep
>> the Broadcom Mobile SoCs all building under this single ARCH_BCM
>> configuration as multiplatform code building a single zImage for them.
> 1. We're moving to a single zImage for everything.  Not just Broadcom.
> There's no need for Broadcom stuff to be treated any differently.
> Participate in the single zImage project and you will get that benefit
> without these games.
I don't follow what is the game being played. The Broadcom mobile team 
is planning on building all future chips out of a single ARCH_ config 
(which we called ARCH_BCM), and others need a separate ARCH_ to build 
(other) specific SoCs for different families. Our ARCH_BCM chip was one 
of the first upstreamed with multiplatform enabled (multi_v7_defconfig 
already selects ARCH_BCM). So right now there are the following 3:
ARCH_BCM -> BCM281XX now + a few others to follow
ARCH_BCM5301X -> BCM530X family
ARCH_BCM4760 -> BCM4760 family.

and these would all reside in mach-bcm. The only problem I see with the 
above is that ARCH_BCM would probably have been more aptly named 
ARCH_MOBILE_BCM as the SoCs showing up under that ARCH are all from the 
mobile team @ Broadcom. And if that is what is confusing people, I'm ok 
with changing that.

>
> 2. "library" mach-* support code doesn't go into another mach-* directory.
> That's why we have the plat-* stuff.  Please follow this well established
> model.  plat-* directories are selected by CONFIG_PLAT_* symbols, so
> you would need CONFIG_PLAT_BCM.
>
> Please don't persue your own solutions to problems which were solved years
> ago and have established solutions already in place.
Maybe I missed something but with the migration to multiplatform (and 
the minimalist size of the ensuing arch-specific files) my understanding 
was that there is no need for PLAT going forward, that all socs from a 
single company can just co-exist under the same mach- directory. If you 
look at mach-bcm at present there are 2 .c files + 1 .S file. With the 
cleanups we are doing to support > 1 family under ARCH_BCM, that number 
is going to grow by 2-4 source files. Adding the 2 other ARCHes above 
will add another handful to a grand total of < 10 source files. None of 
these are 'library' files in the current sense (i.e. each subset of 
these files will only be used for a single ARCH_ config option), so 
there is nothing to move to a plat- directory.
  As an alternative to what is currently being done, I guess could go 
back to the 1-mach-directory-per-arch style so we'd have:
mach-bcm -> ARCH_BCM
mach-bcm5301x -> ARCH_BCM530X
mach-bcm4760 -> ARCH_BCM4760
but each of these dirs will have 2-3 source files. Which is what I heard 
a while back we wanted to start avoiding (the explosition of mach- dirs 
with next-to-nothing in each). Are you proposing we revert to this model ?

  thanks,
    csd

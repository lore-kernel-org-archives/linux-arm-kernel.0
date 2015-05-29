From: tony@atomide.com (Tony Lindgren)
Date: Thu, 28 May 2015 17:15:13 -0700
Subject: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
In-Reply-To: <201505290027.21231@pali>
References: <20131206213613.GA19648@earth.universe>
 <CAALWOA8Pfc_zbN9MoHwR=njPBpFU56WObYMbGv9N7ktzy+RSeQ@mail.gmail.com>
 <20150528222412.GM30984@atomide.com> <201505290027.21231@pali>
Message-ID: <20150529001513.GN30984@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [150528 15:29]:
> On Friday 29 May 2015 00:24:13 Tony Lindgren wrote:
> > * Matthijs van Duin <matthijsvanduin@gmail.com> [150528 13:28]:
> > > On 28 May 2015 at 18:01, Tony Lindgren <tony@atomide.com> wrote:
> > > > For failed device access you get an interrupt
> > > 
> > > Well for failed reads you get a bus error, and "catching" those
> > > (e.g. using the existing exception mechanism used to catch MMU
> > > faults) is the whole issue.
> > > 
> > > Though now that you mention it, it is true that for writes you
> > > won't get any fault (at least on the DM814x and AM335x the posting
> > > point appears to be the async bridge from MPUSS to the L3
> > > interconnect) but an interconnect error irq instead. It may be
> > > easier to make some kind of harmless write (e.g. to the version
> > > register), wait a bit, and check if the write triggered an
> > > interconnect error.
> > > 
> > > Feels hackish though: you'd need to be sure you waited long enough
> > > (though using a read from another device on the same L4
> > > interconnect should be a reliable barrier in this case), and
> > > drivers for receiving/interpreting interconnect errors are not
> > > implemented yet on all SoCs (for some, like the AM335x, TI didn't
> > > even bother publishing the relevant data in its TRM). Interconnect
> > > errors can also be lost in some cases (multiple errors involving
> > > the same target in a short time window) though that problem
> > > shouldn't arise in this particular case.
> > 
> > Hmm I believe the interrupt happens immediately trying to access an
> > invalid device. But maybe I'm thinking about just errors if a device
> > is not powered or clocked. So obviously some experiments need to be
> > done :)
> > 
> > The advantage here would be that the l3 driver actually already knows
> > quite a bit about the devices on the bus.
> > 
> > > Also, presumably interconnect error reporting is unavailable on HS
> > > devices given the fact that all interconnect registers seemed to be
> > > inaccessible?
> > 
> > Oh OK yeah then that would not work for Pali's case. I guess it just
> > needs to be tested.
> > 
> > Regards,
> > 
> > Tony
> 
> Ok, thanks for info. Do you have some quick small patches for testing? 
> Or some pointers what is needed to modify and how?

Well I guess the initial test would be to make sure you have
CONFIG_OMAP_INTERCONNECT=y, comment out status = "disabled" in
omap3-n900.dts for aes, patch in the aes hwmod data, check that
you have CONFIG_CRYPTO_DEV_OMAP_AES=y, boot the kernel.

Do you get just the l3_smx interrupt instead of the "Unhandled fault"?

If so then we can use the interrupt handle to make the probe fail.
Not sure yet what would be the best way to do that though :)

Regards,

Tony

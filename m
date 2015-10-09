From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 09 Oct 2015 11:59:05 +0200
Subject: [PATCHv3 1/2] ARM: exynos_defconfig: Enable rtl8152 ethernet
 driver for Odroid-XU4
In-Reply-To: <5551783.9EQ5GEjhxX@wuerfel>
References: <1444276117-3657-1-git-send-email-linux.amoon@gmail.com>
 <26439960.pU0jZ9hpjg@wuerfel> <1444296433.9895.234.camel@collabora.co.uk>
 <5551783.9EQ5GEjhxX@wuerfel>
Message-ID: <1444384745.9895.265.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-10-08 at 16:41 +0200, Arnd Bergmann wrote:
> On Thursday 08 October 2015 11:27:13 Sjoerd Simons wrote:
> > On Thu, 2015-10-08 at 10:37 +0200, Arnd Bergmann wrote:
> > > On Thursday 08 October 2015 16:46:27 Krzysztof Kozlowski wrote:
> > > > On 08.10.2015 16:41, Arnd Bergmann wrote:
> > > > > On Thursday 08 October 2015 03:48:36 Anand Moon wrote:
> > > > > > diff --git a/arch/arm/configs/exynos_defconfig
> > > > > > b/arch/arm/configs/exynos_defconfig
> > > > > > index 1ff2bfa..5d1937b 100644
> > > > > > --- a/arch/arm/configs/exynos_defconfig
> > > > > > +++ b/arch/arm/configs/exynos_defconfig
> > > > > > @@ -61,6 +61,7 @@ CONFIG_BLK_DEV_DM=y
> > > > > >  CONFIG_DM_CRYPT=m
> > > > > >  CONFIG_NETDEVICES=y
> > > > > >  CONFIG_SMSC911X=y
> > > > > > +CONFIG_USB_RTL8152=y
> > > > > >  CONFIG_USB_USBNET=y
> > > > > >  CONFIG_USB_NET_SMSC75XX=y
> > > > > >  CONFIG_USB_NET_SMSC95XX=y
> > > > > 
> > > > > Can we make that a loadable module for multi_v7_defconfig?
> > > > 
> > > > What about nfsroot boots? We were discussing this also here:
> > > > http://linux-arm-kernel.infradead.narkive.com/lG5g4hrB/patch-ar
> > > > m-mu
> > > > lti-v7-defconfig-enable-usb3503
> > > > 
> > > > and actually I would be happy to see a confirmed policy about
> > > > that.
> > > > Everything should be a module for multi_v7?
> > > 
> > > We try to make as much as possible modular here, and NFS root is
> > > a
> > > corner
> > > case: it's possible to do NFS root with an initramfs, but it's
> > > easier
> > > not
> > > to. Is it something you do a lot on this hardware?
> > 
> > It's a workflow thing though, not a hardware specific thing. I
> > personally tend to use NFS root quite often and so do various
> > colleagues irrespective of the hardware (and an XU4 is bound to
> > appear
> > on my desk someday). 
> > 
> > Now I personally really don't mind whether NFS root requires a
> > ramdisk
> > or not (though some consistency would be nice). However deciding it
> > on
> > a per device basis just makes everything quite fuzzy (e.g. my
> > recent
> > rockchip multi_v7 patchset first ended up in a similar discussion,
> > though v2 was merged without further comments when I indicated in
> > the
> > cover letter that i used the NFS root use-case as one of the
> > deciding
> > factors for y vs. m).
> > 
> > It would be really good to see someone put their foot down on the
> > general policy (e.g. the arm-soc maintainers?), such that this
> > discussion doesn't need to happen every time 
> 
> Yes, agreed, that what I'm trying to do here ;-)

I see, sorry I misunderstood what you were after.

> I realize that building things as modules is a hassle, it is so for
> some things more than for others, so I keep asking the question
> to everyone to find out what a good balance is to make as much as
> possible modules without hurting too much.

Fwiw, I don't find building modules overly cumbersome. Getting an
initramfs capable of moving on to an NFS root is mostly a one-time
thing (not unlike setting up the nfs root itself) and injecting modules
into it is relatively simple (doubly so if taking advantage of the
multiple cpio archive feature linux has). 

Interestingly, for me not building things as modules in multi_v7 tends
to cause more work as it hides a few categories of bugs that tend to
crop up once building distro kernels (e.g. missing module aliases,
missing module device table entries, implicitly relying on clocks being
active during probe as unused clocks only get turned of late in the
init sequence etc).

> Once we have a firm policy in place, we should probably change all
> the existing symbols.

++

-- 
Sjoerd Simons
Collabora Ltd.

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Feb 2016 23:44:09 +0100
Subject: [PATCH 0/8] drm: msm: module rework
In-Reply-To: <CAF6AEGuYQqsH9TEoc-_cgMRNRvB99SveTqW3gSwJJvsvhaqNmw@mail.gmail.com>
References: <1456175331-714117-1-git-send-email-arnd@arndb.de>
 <CAF6AEGuYQqsH9TEoc-_cgMRNRvB99SveTqW3gSwJJvsvhaqNmw@mail.gmail.com>
Message-ID: <2809632.WiXCV6JuAB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 February 2016 17:36:36 Rob Clark wrote:
> On Mon, Feb 22, 2016 at 4:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > I saw some regressions on today's Linux-next kernel after
> > the Makefiles got reworked and tried to come up with a quick
> > fix. This ended up taking much longer, but the new version should
> > be cleaner and I no longer get any build errors in this
> > driver.
> 
> fyi, for the time being, I've already kicked out the kconfig/makefile
> splitup patches..
> 
> I'll go ahead and pull in the hdmi symbol rename patch, since that is
> a sane thing to do.

Ok, thanks

>  I'm less sure about splitting things up into separate .ko's.

I think it's generally a good idea to split it up like that, though
it could be taken a little further. Having one .ko file per
platform_driver seems to be a very sensible split here, the
main advantage being that you enforce a strict layering between
the subdrivers.

>  And I think having the .ko name not match the drm
> driver name (ie. what is passed in to drmOpen() in userspace) would
> cause issues since libdrm could try to modprobe $drivername.ko.  (I
> *think* that only matters in the non-udev case?  Which is at least not
> a common case, but breaking userspace is breaking userspace...)

Ah, I see. Yes, that is unfortunate, but patch 2 then definitely has
to be dropped even if you decide to take the others.

With udev, the autoloading purely depends on the MODULE_DEVICE_TABLE
in the top module, which should work fine, and without patch 2, all
the other drivers get loaded automatically when the main driver
gets probed.

	Arnd

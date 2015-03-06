From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Mar 2015 16:41:57 -0800
Subject: [PATCH 1/4] ARM: OMAP2+: omap_hwmod: Introduce ti,no-init dt
 property
In-Reply-To: <20150305201713.GH13520@atomide.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
 <1425561211-31003-2-git-send-email-d-gerlach@ti.com>
 <alpine.DEB.2.02.1503051815590.5613@utopia.booyaka.com>
 <20150305184952.GF13520@atomide.com> <54F8B2C7.7060202@ti.com>
 <20150305201713.GH13520@atomide.com>
Message-ID: <20150306004157.GI13520@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150305 12:24]:
> * Dave Gerlach <d-gerlach@ti.com> [150305 11:53]:
> > On 03/05/2015 12:49 PM, Tony Lindgren wrote:
> > > * Paul Walmsley <paul@pwsan.com> [150305 10:16]:
> > >> On Thu, 5 Mar 2015, Dave Gerlach wrote:
> > >>
> > >>> Introduce a dt property, ti,no-init, that prevents hwmod initialization.
> > >>> Even if a dt node is marked as disabled, hwmod still at least enables
> > >>> the hwmod and programs the sysconfig before attempting to idle it at
> > >>> boot. If an IP has been disabled by the hardware configuration on a
> > >>> platform, this will cause a hang due to writing to inactive registers.
> > >>> This property prevents that from happening by marking the hwmod as
> > >>> _HWMOD_STATE_DISABLED during init.
> > >>
> > >> I'm kind of wondering if hwmod should even touch a device if it's marked 
> > >> as disabled in the DT.  Tony, what do you think?
> > > 
> > > Well nothing happens if a device is status = "disabled". No dev entry
> > > gets created for it at all and hwmod won't have any data for the device
> > > populated. The only way hwmod code could see that device if the device
> > > gets it's data from the legacy omap_hwmod_*_data.c instead of DT.
> > > 
> > 
> > We still need this for the sysconfig programming, correct? hwmod programs that
> > regardless of dt status and then idles the IP,
> 
> Well hwmod does not even know about the IP IO addresses if it's marked
> with status = "disabled".. Which IP are you having problems with?
> 
> > which is why I needed the ti,no-init for the epos evm. It isn't just a
> > matter of we shouldnt write to it because we don't want to use it; we
> > can't write to it because the module is held off so it causes an
> > external abort if we do.
> 
> Well hard to say not knowing which module this is.. Pretty much all
> the modules have drivers and the driver just does pm_runtime_get()
> on it?

Heh OK this thread is about the RTC driver, so I assume that's the
problem :) So if you set the rtc to status = "disabled" how can the
hwmod code do anything as AFAIK it won't even get the rtc IO address?

Or am I missing something here?

Regards,

Tony

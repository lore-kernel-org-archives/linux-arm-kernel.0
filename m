From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Dec 2013 09:30:34 -0800
Subject: [PATCH] ARM: OMAP2+: omap_device: add fail hook for runtime_pm
 when bad data is detected
In-Reply-To: <87mwka80vu.fsf@linaro.org>
References: <1386121153-32351-1-git-send-email-nm@ti.com>
 <20131205190343.GI26766@atomide.com> <87mwka80vu.fsf@linaro.org>
Message-ID: <20131210173033.GJ13171@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@linaro.org> [131209 08:07]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Nishanth Menon <nm@ti.com> [131203 17:40]:
> >> Due to the cross dependencies between hwmod for automanaged device
> >> information for OMAP and dts node definitions, we can run into scenarios
> >> where the dts node is defined, however it's hwmod entry is yet to be
> >> added. In these cases:
> >> a) omap_device does not register a pm_domain (since it cannot find
> >>    hwmod entry).
> >> b) driver does not know about (a), does a pm_runtime_get_sync which
> >>    never fails
> >> c) It then tries to do some operation on the device (such as read the
> >>   revision register (as part of probe) without clock or adequate OMAP
> >>   generic PM operation performed for enabling the module.
> >> 
> >> This causes a crash such as that reported in:
> >> https://bugzilla.kernel.org/show_bug.cgi?id=66441
> >> 
> >> When 'ti,hwmod' is provided in dt node, it is expected that the device
> >> will not function without the OMAP's power automanagement. Hence, when
> >> we hit a fail condition (due to hwmod entries not present or other
> >> similar scenario), fail at pm_domain level due to lack of data, provide
> >> enough information for it to be fixed, however, it allows for the driver
> >> to take appropriate measures to prevent crash.
> >
> > Kevin, any comments on this one?
> 
> Looks like a good approach to catch these corner cases.
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

Kevin, care to apply this directly?

Acked-by: Tony Lindgren <tony@atomide.com> 

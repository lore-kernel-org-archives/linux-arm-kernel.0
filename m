From: treding@nvidia.com (Thierry Reding)
Date: Mon, 7 Sep 2015 11:01:53 +0200
Subject: [PATCH v4 14/16] drm: bridge: analogix/dp: try force hpd after
 plug in lookup failed
In-Reply-To: <20150904102003.GE21084@n2100.arm.linux.org.uk>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441088079-25809-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqJDALnjVaVoEqGGsSLeE31m3MKOfbSoZ3M+g+zPZR2MFg@mail.gmail.com>
 <55E7CC43.7040608@rock-chips.com>
 <20150903090421.GC3784@ulmo.nvidia.com>
 <20150904102003.GE21084@n2100.arm.linux.org.uk>
Message-ID: <20150907090151.GD19961@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 11:20:03AM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 03, 2015 at 11:04:40AM +0200, Thierry Reding wrote:
> > Conversely, if the panel isn't capable of generating an HPD signal, then
> > I don't think it would be appropriate to make it a DT property. It would
> > be better to hard-code it in the driver, lest someone forget to set the
> > property in DT and get stuck with a device that isn't operational.
> 
> There is another way to deal with this: DRM supports the idea of connector
> forcing - where you can force the connector to think that it's connected
> or disconnected.

Yes, this could work well for RGB/LVDS or DSI connectors perhaps. For
eDP there is added complexity because the HPD interrupt function is also
used to signal loss of link integrity. That is, after receiving an HPD
interrupt you are supposed to retrain the link (or at least check the
link status to see if the interrupt cause is loss of integrity). While
the eDP specification makes HPD optional, it also says that if HPD isn't
available, then the source must use polling to monitor link integrity
instead.

DRM does provide a mechanism for that as well. You can set the
connector's ->polled field to DRM_CONNECTOR_POLL_CONNECT |
DRM_CONNECTOR_POLL_DISCONNECT and have the core actively poll for the
connector status (i.e. call ->detect() every 100 ms).

I think use of polling would be more appropriate in case of eDP.

> One of the problems is that not many ARM DRM drivers implement it - maybe
> it should be a requirement for code to be accepted? :)

I suspect that many drivers may roll their own. In fact I'm guilty of
that myself. On Tegra we have a default implementation for outputs which
will default to the state of an HPD GPIO where available and fall back
to "always connected" for outputs that have a panel connected. Outputs
that have a separate mechanism to signal hotplug detection (such as DP)
simply use a custom ->detect() implementation.

The overhead of rolling one's own is almost zero and connector forcing
has the disadvantage of being available via sysfs and debugfs, so the
default set by drivers could be overwritten by users at runtime with no
easy way back.

Given the above I'm not sure enforcing connector forcing would be
beneficial.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150907/30abe69e/attachment-0001.sig>

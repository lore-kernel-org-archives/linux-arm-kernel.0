From: treding@nvidia.com (Thierry Reding)
Date: Mon, 7 Sep 2015 10:20:18 +0200
Subject: [PATCH v4 14/16] drm: bridge: analogix/dp: try force hpd after
 plug in lookup failed
In-Reply-To: <55EBBA0C.1030100@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441088079-25809-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqJDALnjVaVoEqGGsSLeE31m3MKOfbSoZ3M+g+zPZR2MFg@mail.gmail.com>
 <55E7CC43.7040608@rock-chips.com>
 <20150903090421.GC3784@ulmo.nvidia.com>
 <55EBBA0C.1030100@rock-chips.com>
Message-ID: <20150907082017.GB19961@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 06, 2015 at 11:59:08AM +0800, Yakir Yang wrote:
> Hi Thierry,
> 
> ? 09/03/2015 05:04 PM, Thierry Reding ??:
> >On Thu, Sep 03, 2015 at 12:27:47PM +0800, Yakir Yang wrote:
> >>Hi Rob,
> >>
> >>? 09/03/2015 04:17 AM, Rob Herring ??:
> >>>On Tue, Sep 1, 2015 at 1:14 AM, Yakir Yang <ykk@rock-chips.com> wrote:
> >>>>Some edp screen do not have hpd signal, so we can't just return
> >>>>failed when hpd plug in detect failed.
> >>>This is a property of the panel (or connector perhaps), so this
> >>>property should be located there. At least, it is a common issue and
> >>>not specific to this chip. We could have an HDMI connector and failed
> >>>to hook up HPD for example. A connector node is also where hpd-gpios
> >>>should be located instead (and are already defined by
> >>>../bindings/video/hdmi-connector.txt). Perhaps we need a eDP connector
> >>>binding, too.
> >>Yep, I agree with your front point, it is a property of panel, not specific
> >>to eDP controller, so this code should handle in connector logic.
> > From your description it sounds more like this is in fact a property of
> >the panel. Or maybe I should say "quirk". If the panel doesn't generate
> >the HPD signal, then that should be a property of the panel, not the
> >connector. The eDP specification mandates that connectors have a HPD
> >signal, though it allows the "HPD conductor in the connector cable" to
> >be omitted if not used by the source. I'd consider the cable to belong
> >to the panel rather than the connector, so absence of HPD, either
> >because the cable doesn't have the conductor or because the panel does
> >not generate the signal, should be a quirk of the panel.
> >
> >That said you could have a panel that supports HPD connected via a cable
> >that doesn't transmit it, so this would be a per-board variant and hence
> >should be a device tree property rather than hard-coded in some panel
> >driver.
> >
> >Conversely, if the panel isn't capable of generating an HPD signal, then
> >I don't think it would be appropriate to make it a DT property. It would
> >be better to hard-code it in the driver, lest someone forget to set the
> >property in DT and get stuck with a device that isn't operational.
> 
> Oh, you're right, if it's a cable quirk, then DT property would be okay, if
> it
> is a problem of panel, then maybe hard-code in driver would be better.
> 
> After look up for the document of panel "innolux,n116bge", I haven't see
> any description of hot plug signal, and even not found in PIN ASSIGNMENT.
> So I believe it's a panel problem, that's to say it should handle in panel
> driver.

The datasheet that I have for that panel lists HPD as pin 17. Also I
used to have a setup with that panel and I distinctly remember hotplug
working just fine. Perhaps this is an issue with a specific variant of
the panel? Or perhaps this is indeed a problem with the cable that's
connecting the panel to the board. It could be one of those cases where
they left out the HPD conductor to save money.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150907/b3e2ffa1/attachment.sig>

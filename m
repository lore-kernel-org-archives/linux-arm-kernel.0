From: treding@nvidia.com (Thierry Reding)
Date: Thu, 3 Sep 2015 11:04:40 +0200
Subject: [PATCH v4 14/16] drm: bridge: analogix/dp: try force hpd after
 plug in lookup failed
In-Reply-To: <55E7CC43.7040608@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441088079-25809-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqJDALnjVaVoEqGGsSLeE31m3MKOfbSoZ3M+g+zPZR2MFg@mail.gmail.com>
 <55E7CC43.7040608@rock-chips.com>
Message-ID: <20150903090421.GC3784@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2015 at 12:27:47PM +0800, Yakir Yang wrote:
> Hi Rob,
> 
> ? 09/03/2015 04:17 AM, Rob Herring ??:
> >On Tue, Sep 1, 2015 at 1:14 AM, Yakir Yang <ykk@rock-chips.com> wrote:
> >>Some edp screen do not have hpd signal, so we can't just return
> >>failed when hpd plug in detect failed.
> >This is a property of the panel (or connector perhaps), so this
> >property should be located there. At least, it is a common issue and
> >not specific to this chip. We could have an HDMI connector and failed
> >to hook up HPD for example. A connector node is also where hpd-gpios
> >should be located instead (and are already defined by
> >../bindings/video/hdmi-connector.txt). Perhaps we need a eDP connector
> >binding, too.
> 
> Yep, I agree with your front point, it is a property of panel, not specific
> to eDP controller, so this code should handle in connector logic.

>From your description it sounds more like this is in fact a property of
the panel. Or maybe I should say "quirk". If the panel doesn't generate
the HPD signal, then that should be a property of the panel, not the
connector. The eDP specification mandates that connectors have a HPD
signal, though it allows the "HPD conductor in the connector cable" to
be omitted if not used by the source. I'd consider the cable to belong
to the panel rather than the connector, so absence of HPD, either
because the cable doesn't have the conductor or because the panel does
not generate the signal, should be a quirk of the panel.

That said you could have a panel that supports HPD connected via a cable
that doesn't transmit it, so this would be a per-board variant and hence
should be a device tree property rather than hard-coded in some panel
driver.

Conversely, if the panel isn't capable of generating an HPD signal, then
I don't think it would be appropriate to make it a DT property. It would
be better to hard-code it in the driver, lest someone forget to set the
property in DT and get stuck with a device that isn't operational.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150903/10766dab/attachment.sig>

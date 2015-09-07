From: treding@nvidia.com (Thierry Reding)
Date: Mon, 7 Sep 2015 10:39:18 +0200
Subject: [PATCH v4 14/16] drm: bridge: analogix/dp: try force hpd after
 plug in lookup failed
In-Reply-To: <55EBF757.20108@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441088079-25809-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqJDALnjVaVoEqGGsSLeE31m3MKOfbSoZ3M+g+zPZR2MFg@mail.gmail.com>
 <55E7CC43.7040608@rock-chips.com>
 <CAL_JsqKoyZOAA7yzSATA-Ys8N1q9Edi-3ctPU09UVeV=7sTWTg@mail.gmail.com>
 <55EBF757.20108@rock-chips.com>
Message-ID: <20150907083916.GC19961@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 06, 2015 at 04:20:39PM +0800, Yakir Yang wrote:
> Hi Rob,
> 
> ? 09/05/2015 05:46 AM, Rob Herring ??:
> >On Wed, Sep 2, 2015 at 11:27 PM, Yakir Yang <ykk@rock-chips.com> wrote:
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
> >>
> >>Yep, I agree with your front point, it is a property of panel, not specific
> >>to eDP controller, so this code should handle in connector logic.
> >>
> >>But another question, if we just leave this property to connector,
> >>then we would need to parse this property in analogix_dp-rockchip.c,
> >>and then make an hook in analogix_dp_core.c driver. This is not nice,
> >>and if there are some coming platform which alse want to use analogix_dp
> >>code and meet this "no-hpd" situation,  then they would need duplicate
> >>to parse this property and fill the hook in analogix_dp_core.c driver.
> >>So it's little bit conflict  :-)
> >Ideally, you would be able to just retrieve this quirk from the
> >connector or panel. Getting this property from your node vs. the port
> >you are attached to should not be much harder. Either the connector
> >struct can have this info or there can be a DT function that can walk
> >the graph and get it. Just don't open code the graph traversal in your
> >driver.
> >
> >>Beside I can not understand your example very well. Do you mean
> >>that there are some HDMI monitor which also do not have HPD
> >>signal (just like some eDP panel do not have hpd too), and then
> >>the "hpd-gpios" ? Hmm... I don't know how the "hpd-gpios" want
> >>to help in this case, would you mind show some sample code  :-D
> >I don't know that there is h/w, but it is always possible HPD is not
> >hooked up or hooked up incorrectly some how.
> >
> >If there is no HPD support, then hpd-gpios is not going to help you.
> >
> >I think there are 3 cases to handle:
> >- HPD handled by bridge chip - The bridge driver knows it has this
> >capability. No DT properties are needed and no HPD properties on the
> >connector node imply the bridge chip should handle HPD functions.
> >- HPD handled by GPIO line (or some other block) - Indicated by
> >hpd-gpios present
> >- No or broken HPD - Indicated by "hpd-force" property.
> 
> Oh, I think the first/second case isn't suitable in this case, my panel
> "cnm,n116bgeea2" haven't included HPD signal.

Note that if your panel doesn't signal HPD you're supposed to poll the
sink to make sure you catch loss of link integrity. I've always found it
odd that people would want to save a couple of bucks on the HPD signal
conductor when that means that you will consume more power because you
need to periodically poll the link for integrity.

> >>>Are there any eDP panels which don't have EDID and need panel details in
> >>>DT?
> >>
> >>Oh, I think you want to collect some info that belong to panel
> >>property but no indicate in panel EDID message, so those can
> >>be collect in eDP connector binding, is it right ?
> >Yes, and as Thierry pointed out we may need to know the exact panel even.
> 
> Yeah, just like I reply to Thierry, this is a panel quirk. And he suggest we
> should
> handle this in panel driver, but I have no idea how to handle this in common
> panel
> driver.   :)

Like I said in another subthread, this panel does have an HPD line in a
variant that I've used in the past. So if your variant doesn't have the
HPD line, we're dealing with quirks within the same family of panels.
That would make this some sort of quirk, and I'm not sure if there is a
standard way for defining quirks in DT. Rob, do you know of any
precedent for this?

I suppose we could always add a variant-specific compatible string that
would allow this quirk to be encoded in the driver, though I'm not sure
if the model string in datasheets has enough detail to tell them apart.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150907/c2a060c9/attachment-0001.sig>

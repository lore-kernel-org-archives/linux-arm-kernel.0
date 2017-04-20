From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 20 Apr 2017 13:42:23 +0300
Subject: [PATCH/RFC v2 1/2] arm64: dts: r8a7795: Add support for R-Car H3
 ES2.0
In-Reply-To: <CAMuHMdXOzyo+kzaGAXp+jZTtUejYyXCQzezo+SmvNVQuEC9=_Q@mail.gmail.com>
References: <1490362665-4422-1-git-send-email-geert+renesas@glider.be>
 <1612430.SNEha5n02K@avalon>
 <CAMuHMdXOzyo+kzaGAXp+jZTtUejYyXCQzezo+SmvNVQuEC9=_Q@mail.gmail.com>
Message-ID: <1714563.qChlbIjNcO@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Thursday 20 Apr 2017 11:36:59 Geert Uytterhoeven wrote:
> On Mon, Mar 27, 2017 at 10:48 AM, Laurent Pinchart wrote:
> > On Friday 24 Mar 2017 14:37:44 Geert Uytterhoeven wrote:
> >> Update r8a7795.dtsi so it corresponds to R-Car H3 ES2.0 or later:
> >>   - The following devices no longer exist on ES2.0, and are thus removed:
> >>     fcpf2, fcpvd3, fcpvi2, fdp1-2, usb3-if1, vspd3, vspi2.
> >>   
> >>   - The DU <-> VSPD topology is different on ES2.0, hence remove the
> >>     "vsps" property from the DU node until the driver can handle this.
> > 
> > I think I'll need a different compatible string between ES1.x and ES2 for
> > the DU. It could make sense to move the whole DU node to *-es1.dtsi. We
> > can decide about that later when I'll have a DU driver prototype ready.
> 
> Why would you need a different compatible string?
> Can't you use soc_device_match() to handle ES1.x SoCs?
> 
> The different DU <-> VSPD topology is handled through the vsps property in
> DTS. Are the ports different, too? That can be handled in DTS.

My point (not expressed clearly) was that, as I'll need a different vsps 
property, I can as well go for a different compatible string.

> The main reason why I kept the DU node in r8a7795.dtsi is that the board DTS
> refers to it.  Sharing board DTS means there needs to be at least a
> placeholder node for the DU in r8a7795.dtsi, unless you want to keep on
> shuffling board overrides around.

As the ports are identical it makes sense to share the same board DTS, I agree 
with you. We could override the compatible string in r8a7795-es1.dtsi and 
leave it blank in r8a7795.dtsi for now, as there's no driver support for 
ES2.0. That's a bit of a workaround as it shouldn't matter to DT whether 
driver support is available or not. On the other hand, leaving the vsps 
property out is a workaround too.

The current driver will fail probing if the number of VSPs is different than 
the number of CRTCs, so I believe you can keep the vsps property in 
r8a7795.dtsi with 3 VSPS without causing any problem. However, there's no DT 
bindings for the H3 ES2.0 DU yet, so we would end up merging DT without 
bindings, which is not good. I think that regardless of how we proceed, 
keeping the DU node in the ES2.0 .dtsi will be a violation of that policy.

-- 
Regards,

Laurent Pinchart

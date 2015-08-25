From: treding@nvidia.com (Thierry Reding)
Date: Tue, 25 Aug 2015 16:16:43 +0200
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <55DC7211.9080601@rock-chips.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
 <20150825091534.GB14034@ulmo.nvidia.com>
 <CAL_Jsq++RLZo4gvEUTKO8MfEPwSqT2R+bqG22Jsgb2qLgDQFpw@mail.gmail.com>
 <55DC7211.9080601@rock-chips.com>
Message-ID: <20150825141642.GA3820@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 09:48:01PM +0800, Yakir Yang wrote:
> Hi Thierry & Rob,
> 
> ? 2015/8/25 21:27, Rob Herring ??:
> >On Tue, Aug 25, 2015 at 4:15 AM, Thierry Reding <treding@nvidia.com> wrote:
> >>On Sun, Aug 23, 2015 at 06:23:14PM -0500, Rob Herring wrote:
> >>>On Wed, Aug 19, 2015 at 9:50 AM, Yakir Yang <ykk@rock-chips.com> wrote:
> >>[...]
> >>>>+       -analogix,link-rate:
> >>>>+               max link rate supported by the eDP controller.
> >>>>+                       LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A,
> >>>>+                       LINK_RATE_5_40GBPS = 0x14
> >>>Same here. I'd rather see something like "link-rate-mbps" and use the
> >>>actual rate.
> >>There is no need whatsoever to hard-code this in DT. (e)DP provides the
> >>means to detect what rate the link supports and the specification
> >>provides guidance on how to select an appropriate one.
> >Good, even better.
> 
> I do think we still need keep this DT prop yet.
> 
> I think drm_dp_help.c could get the "panel" max link-rate and lane-count,
> but it's not enough, we still need knew the "eDP controller" max link-rate
> and lane-count.
> 
> Let me show the exact example that happened in my side. When I connect
> my board to my 2K DP-1.2 TV. Analogix dp driver would get the max link-rate
> from dpcd, and the max link-rate is 5.4Gbps. So if I just set eDP controller
> link-rate
> to 5.4Gbps, the DP TV just broken, do not light up normally.
> 
> This reason why TV broken is the max link-rate which support by RK3288 eDP
> controller is 2.7Gbps. Here are the exact words that RK3288 eDP TRM said:
> 
> *??Compliant with DisplayPortTM Specification, Version 1.2.
> ??Compliant with eDPTM Specification, Version 1.3.
> ??HDCP v1.3 amendment for DisplayPortTM Revision 1.0.
> ??Main link containing 4 physical lanes of 2.7/1.62 Gbps/lane
> *
> **
> 
> 
> Beside I haven't found there are some registers would indicate the eDP
> controller
> max link-rate and lane-count, so this is why I still instance that we need
> this DT
> prop to indicata "Max rate controller support".
> 
> So, I wish you could agree with me on this point.

Your driver should know what link rates it supports and restrict itself
to use those. This is implied by the compatible string and doesn't need
to be duplicated into device tree.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150825/5f331b4b/attachment-0001.sig>

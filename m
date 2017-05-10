From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 10 May 2017 12:26:30 +0200
Subject: [PATCH v5 0/5] Add ARM Mali Midgard device tree bindings and gpu
 node for rk3288
In-Reply-To: <425541fd-e648-1db7-9c31-13d2d4f094b4@collabora.com>
References: <cover.1493804968.git.guillaume.tucker@collabora.com>
 <ddec5773-43ef-a4c3-2280-8f0c5b1f1c4d@rock-chips.com>
 <425541fd-e648-1db7-9c31-13d2d4f094b4@collabora.com>
Message-ID: <1903408.yP8VoejG5e@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 10. Mai 2017, 11:10:55 CEST schrieb Guillaume Tucker:
> Hi Randi,
> 
> On 09/05/17 08:45, Randy Li wrote:
> > On 05/09/2017 03:40 PM, Guillaume Tucker wrote:
> >> On 09/05/17 02:16, Randy Li wrote:
> >>> On 05/09/2017 12:27 AM, Heiko St?bner wrote:
> >>>> Am Mittwoch, 3. Mai 2017, 10:56:24 CEST schrieb Guillaume Tucker:
> >>>>> The ARM Mali Midgard GPU kernel driver is only available
> >>>>> out-of-tree and is not going to be merged in its current form.
> >>>>> However, it would be useful to have its device tree bindings
> >>>>> merged.  In particular, this would enable distributions to create
> >>>>> working driver packages (dkms...) without having to patch the
> >>>>> kernel.
> >>>>> 
> >>>>> The bindings for the earlier Mali Utgard GPU family have already
> >>>>> been merged, so this is essentially the same scenario but for
> >>>>> newer GPUs (Mali-T604 ~ Mali-T880).
> >>>>> 
> >>>>> This series of patches first imports the bindings from the latest
> >>>>> driver release with some clean-up then adds a gpu node for the
> >>>>> rk3288 SoC.  This was successfully tested on Radxa Rock2 Square,
> >>>>> Firefly, Veyron Minnie and Jerry boards using Mali kernel driver
> >>>>> r16p0 and r12p0 user-space binary.
> >>> 
> >>> I won't suggest such combine. We meet some problems at mali 400 serial.
> >>> I would suggest the kernel version would match the user library.
> >> 
> >> Well, I can test it again with r12p0 kernel driver (out-of-tree)
> >> if you want.  The user-space driver checks the version of the
> >> kernel driver and gives up if it's not compatible.  With Midgard,
> >> there's a range of versions that maintain kernel/userspace
> >> compatibility unlike Utgard and older Midgard releases where they
> >> had to exactly match.  Again, if there was a mismatch then the
> >> user-space would fail to initialise and report an error.
> > 
> > Anyway, could you verify the mali userspace library r13p0?
> 
> The latest user-space binary available from developer.arm.com for
> rk3288 is 12p0.  Maybe Rockchip could make some new binaries
> available to the public?
> 
> > Rockchip would use this version to offer the support of X11, wayland and
> > gbm.
> Sounds great, although windowing systems are quite far away from
> GPU device tree bindings so I don't think this is too relevant
> for this current patch series.
> 
> On a side note, it would be fantastic to get all this available
> in Debian packages :)
> 
> >>> Also please notice there is rk3288w, the hardware version becomes r1p0.
> >> 
> >> Sounds like a new SoC?  Does rk3288w affect rk3288 in any way?
> > 
> > It is not a new SoC, just a new version of rk3288. It fixes a various of
> > the chip bug of the rk3288.
> I see.  I don't have access to any rk3288w platform but if you do
> then I guess it would be nice if you could test these patches on
> it :)  Also I'm not sure if all rk3288 device trees changes must
> be tested on rk3288w, and this SoC is not mentioned anywhere in
> the kernel (as far as I can tell).
> 
> Is there anything you think should block these current patches
> which only claim to support rk3288 from being merged?

>From what I've read on #linux-rockchip:

<wzyy2> rk3288w have some differences:  USB HOST : add ohci, fix ehci bug  GPU : update rev
<wzyy2> VOP, video codec, rga : some bug fix
<wzyy2> hdmi :  HDCP2.2

So from, yes a new gpu-revision, but that shouldn't affect this series.
>From the above I guess the hooks into the rest of the soc haven't changed
so rk3288-mali should still be enough and the driver normally can detect
and handle revision differences.

And if there are really severe changes appearing later on _and_ we actually
get special support for the rk3288w in the kernel (googling for rk3288w
mentions it in conjunction with windows 10) there is nothing speaking
against having a rk3288w-mali compatible at that time.


Heiko

> 
> >> Unless it's a special case, it seems to me that any new SoC with
> >> a Midgard GPU would need an extra vendor compatible string in the
> >> binding documentation and maybe a separate gpu dt node.
> >> 
> >>>> The actual devicetree parts are all Rockchip-specific, so I guess I'll
> >>>> just
> >>>> pick up the whole series, including the binding doc, after the merge
> >>>> window if nobody complains before that :-)
> >> 
> >> Thanks!
> 
> Guillaume
> 
> 
> P.S. kernel branch with a Mali driver I used for testing:
> https://git.collabora.com/cgit/user/gtucker/linux.git/log/?h=linux-4.11-mali
> -dt-rk3288

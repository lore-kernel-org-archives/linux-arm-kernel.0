From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 2 Aug 2016 15:13:35 +0200
Subject: [PATCH V3 2/5] dts/imx6q-b850v3: Configure IPU assignment order
In-Reply-To: <70b6-579f4100-9-6ce4f380@208251793>
References: <1470041647.6640.3.camel@pengutronix.de>
 <70b6-579f4100-9-6ce4f380@208251793>
Message-ID: <20160802131335.GH6232@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2016 at 01:30:57PM +0100, Peter Senna Tschudin wrote:
> Hi Lucas,
> 
> Thank you for the prompt review.
>  
> On Monday, August 1, 2016 10:54 CEST, Lucas Stach <l.stach@pengutronix.de> wrote: 
>  
> > Am Sonntag, den 31.07.2016, 21:55 +0200 schrieb Peter Senna Tschudin:
> > > As the IPU has combined limitations across multiple crtcs, and as that
> > > can't be communicated to userspace at the moment, reorder the crtcs to
> > > allow support to two Full-HD monitors by avoiding assigning two
> > > monitors to a single IPU.
> > > 
> > > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> > 
> > NACK. This is a userspace issue. Changing the assignment order of the
> > CRTCs just shifts the failure to a userspace that want to use CRTC 0 and
> > 2 now.
> 
> Err, yeah user space issue... But how the kernel is currently telling
> user space about what exactly went wrong and how user space might fix
> it? How Weston(our user space) is going to know  that reshuffling crtcs
> is going to lead to success; how could it? I guess some
> platform-specific code in user space is needed for this to work...

atomic with the TEST_ONLY flag. This is what userspace should do:
1. submit atomic TEST_ONLY request with 1 screen on first crtc
2. If reject, move to another crtc or if those are all tried, reduce mode
(this should never happen for the 1st screen, kernel /should/ filter out
should impossible modes. But for 2nd/3rd screen combined modes might not
all work).
3. Once you have a successfuly config for the 1st screen, add 2nd screen.
4. goto 2 with that 2nd screen.
5. Once all the screens have a mode/crtc they can be used on, do the real
atomic request without TEST_ONLY.

Like Lucas said, no need to fumble around with ordering of CRTCs. The only
thing we do in the driver is move the preferred output (if there is any)
to the front of the _connector_ list, e.g. for built-in panels.

No need at all for platform specific code.

Cheers, Daniel
> 
> > 
> > imx-drm just got atomic support and with the atomic check it should be
> > possible to inform userspace in a reasonable way about such issues.
> 
> Should be possible, but I guess it isn't, and wont be until a considerable effort is put on both kernel and user space. Or am I missing something? What do you propose?
> 
> I got inspiration from: arch/arm/boot/dts/imx6q.dtsi
> ...
>         display-subsystem {
>                 compatible = "fsl,imx-display-subsystem";
>                 ports = <&ipu1_di0>, <&ipu1_di1>, <&ipu2_di0>, <&ipu2_di1>;
>         };
> ...
> 
> This is there for more than 2 years now, and I get that the idea here is not ordering, but just declaring.
> 
> However even if this patch is not the perfect solution, it allows us to stay close to upstream now without creating problems(does it create any issue?).
> 
> Can you reconsider or propose a concrete solution that is not more complex than our entire driver?
> 
> Thanks a lot!
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

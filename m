From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 10 Mar 2017 22:57:32 +0100
Subject: [PATCH v5 07/39] ARM: dts: imx6qdl-sabrelite: remove erratum
 ERR006687 workaround
In-Reply-To: <CAOMZO5BNrSEyrbWbCBCbsy4yTrh4AHfk2Too0qHuffxqUCgADg@mail.gmail.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-8-git-send-email-steve_longerbeam@mentor.com>
 <9f5d0ac4-0602-c729-5c00-1d9ef49247c1@boundarydevices.com>
 <CAOMZO5BNrSEyrbWbCBCbsy4yTrh4AHfk2Too0qHuffxqUCgADg@mail.gmail.com>
Message-ID: <20170310215731.GB6540@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2017-03-10 16:17:28, Fabio Estevam wrote:
> On Fri, Mar 10, 2017 at 3:59 PM, Troy Kisky
> <troy.kisky@boundarydevices.com> wrote:
> > On 3/9/2017 8:52 PM, Steve Longerbeam wrote:
> >> There is a pin conflict with GPIO_6. This pin functions as a power
> >> input pin to the OV5642 camera sensor, but ENET uses it as the h/w
> >> workaround for erratum ERR006687, to wake-up the ARM cores on normal
> >> RX and TX packet done events. So we need to remove the h/w workaround
> >> to support the OV5642. The result is that the CPUidle driver will no
> >> longer allow entering the deep idle states on the sabrelite.
> >>
> >> This is a partial revert of
> >>
> >> commit 6261c4c8f13e ("ARM: dts: imx6qdl-sabrelite: use GPIO_6 for FEC
> >>                       interrupt.")
> >> commit a28eeb43ee57 ("ARM: dts: imx6: tag boards that have the HW workaround
> >>                       for ERR006687")
> >>
> >> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> >> ---
> >>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 4 ----
> >>  1 file changed, 4 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> >> index 8413179..89dce27 100644
> >> --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> >> +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> >> @@ -270,9 +270,6 @@
> >>       txd1-skew-ps = <0>;
> >>       txd2-skew-ps = <0>;
> >>       txd3-skew-ps = <0>;
> >
> > How about
> >
> > +#if !IS_ENABLED(CONFIG_VIDEO_OV5642)

dts is supposed to be hardware description.

> Or maybe just create a new device tree for using the camera, like
> imx6q-sabrelite-camera.dts.

And it should not depend on configuration. Hardware vendor should be
able to ship board with working device tree...

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170310/f0ee59e9/attachment.sig>

From: wpdster@gmail.com (Patrick Doyle)
Date: Thu, 30 Mar 2017 13:16:34 -0400
Subject: Device driver for Toshiba MIPI<->parallel device
Message-ID: <CAF_dkJC2MHK7Jv6ih1H0aOe=d6do0Cydx_c-e7soEEB_SWPeUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I am writing a device driver for a custom (evaluation) MIPI imager
that I will connect to a parallel imager interface via a Toshiba "MIPI
CSI-2 to Parallel port" bridge device (TC35874x).

I am wondering if anybody has done anything like this and if I might
be able emulate what has been done before.  There are 3 entities
involved, the MIPI imager, the Toshiba bridge, and the Image Sensor
Controller (ISC) built into the SAMA5 SoC.  The imager and the bridge
both sit on the I2C bus, and must be configured via that bus.  There
is support in the 4.4 (linux-at91) kernel for the ISC.

If you have continued reading this far and don't have any experience
with this, then perhaps you might be able to answer a few questions
that will help me get going in the right direction...

In the device tree, I must enable the ISC, and as part of that node, I
have to include a "port" node specifying the device to which the ISC
is connected (see
Documentation/devicetree/bindings/media/video-interfaces.txt).  Should
I specify the node for the Toshiba device (which is connected to the
ISC) or the imager device (which is connected to the Toshiba device).
It seems like I should specify the Toshiba device.

Should I write separate drivers for the Toshiba and imager devices?
Or should I combine them into one driver?  This is likely to be used
only for a little while in a one-off experiment, but hopefully not.
If I were to consider the imager+bridge as a single device, then a
single device driver makes sense, and it makes configuring the two
devices compatibly much easier.  But if I do that, how do I specify
both devices in my device tree?  Or, do I even need to specify both
devices in the tree?  If I probe the Toshiba device, then that must
mean that the imager is present as well (even though it's at a
separate I2C address).

Should I follow the port/endpoint model described in the
video-interfaces.txt document and string the imager to the Toshiba
part to the SoC?

Can you think of any way I could start working on this without having
to fiddle with (and debug) the device tree in parallel with the device
driver?  I found a fabulous answer to this question on SO that would
work fine for me if I didn't have to couple the Tosiba device, the
imager, and the ISC together.  (See
http://stackoverflow.com/questions/18512421/device-tree-and-manual-registration).

Please feel free to direct me at a linux-media mailing list if that
would be a better place to ask these questions, but the combination of
ARM, device tree, and device driver, made me think of this list first.

Thank you.

--wpd

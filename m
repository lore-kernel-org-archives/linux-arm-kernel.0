From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 4 Mar 2016 10:02:42 +0800
Subject: [PATCH 1/3] usb: core: add power sequence for USB devices
In-Reply-To: <CAL_JsqLYHzb0ABYN_P9ZOEorT6otvn_BPNzuCFhoqwa5M4y-hw@mail.gmail.com>
References: <1456999276-6315-1-git-send-email-peter.chen@nxp.com>
 <1456999276-6315-2-git-send-email-peter.chen@nxp.com>
 <CAL_JsqLYHzb0ABYN_P9ZOEorT6otvn_BPNzuCFhoqwa5M4y-hw@mail.gmail.com>
Message-ID: <20160304020242.GB30272@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 02:54:55PM -0600, Rob Herring wrote:
> On Thu, Mar 3, 2016 at 4:01 AM, Peter Chen <peter.chen@nxp.com> wrote:
> > Some hard-wired USB devices need to do power sequence to let the
> > device work normally, the typical power sequence like: enable USB
> > PHY clock, toggle reset pin, etc. But current Linux USB driver
> > lacks of such code to do it, it may cause some hard-wired USB devices
> > works abnormal or can't be recognized by controller at all.
> >
> > In this patch, it will do power on sequence at hub's probe for all
> > devices under this hub (includes root hub) if this device is described
> > at dts and there is a phandle "usb-pwrseq" for it. At hub_disconnect,
> > it will do power off sequence.
> >
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > ---
> >  .../devicetree/bindings/usb/usb-device.txt         |  41 +++++-
> >  drivers/usb/core/Makefile                          |   2 +-
> >  drivers/usb/core/hub.c                             |  32 +++++
> >  drivers/usb/core/pwrseq.c                          | 149 +++++++++++++++++++++
> >  include/linux/usb/of.h                             |  10 ++
> >  5 files changed, 232 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/usb/core/pwrseq.c
> >
> > diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
> > index 1c35e7b..c7a298c 100644
> > --- a/Documentation/devicetree/bindings/usb/usb-device.txt
> > +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
> > @@ -13,8 +13,37 @@ Required properties:
> >  - reg: the port number which this device is connecting to, the range
> >    is 1-31.
> >
> > +Optional properties:
> > +- usb-pwrseq: the power sequence handler which need to do before this USB
> > +  device can work.
> > +- clocks: the input clock for USB device.
> > +- clock-frequency: the frequency for device's clock.
> > +- reset-gpios: Should specify the GPIO for reset.
> > +- reset-duration-us: the duration in microsecond for assert reset signal.
> 
> So we sorted out how to describe USB devices in DT, but now we don't
> use it?

We only know USB device after USB bus finds it, but without power
on sequence, the USB bus can't find it.

> I know this is similar to what was done for MMC, but I really
> don't like it.
> 
> Just put all these properties into the device nodes. The parent can
> then scan for children and handle the power sequencing with generic
> code. I think it is safe to assume that if these properties are
> present, they need to be handled for device detection. We may still
> need something device specific to handle some devices at some point,
> but that is true either way.
> 

It is two different things, one is power sequence which needs to be done
before the device can be detected. Another is the features for this USB
devices, it can be handled after this device has been recognized.

-- 

Best Regards,
Peter Chen

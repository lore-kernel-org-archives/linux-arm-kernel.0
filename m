From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 29 Jun 2016 18:35:32 -0700
Subject: [PATCH 15/21] usb: chipidea: msm: Mux over secondary phy at the
 right time
In-Reply-To: <20160629080852.GJ25236@shlinux2>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-16-stephen.boyd@linaro.org>
 <20160629080852.GJ25236@shlinux2>
Message-ID: <146725053250.32568.8634774845930918926@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-06-29 01:08:52)
> On Sun, Jun 26, 2016 at 12:28:32AM -0700, Stephen Boyd wrote:
> > We need to pick the correct phy at runtime based on how the SoC
> > has been wired onto the board. If the secondary phy is used, take
> > it out of reset and mux over to it by writing into the TCSR
> > register. Make sure to do this on reset too, because this
> > register is reset to the default value (primary phy) after the
> > RESET bit is set in USBCMD.
> > 
> 
> I am curious when you need the secondary phy?

The msm8974 SoC has two phys that sit behind a mux. The primary phy is
typically used by the dwc3 instance for usb3, but it can also be used by
the chipidea controller if this mux is set to zero instead of one. It's
a board designer decision to use either the primary phy or the secondary
phy for the chipidea controller, but dwc3 can only use the primary phy
as it's the only HS phy it's connected to. I suppose if there's a board
out there that doesn't want to use the dwc3 instance because they don't
want USB3 they can use the primary phy for the chipidea instance and
keep the secondary phy powered off.

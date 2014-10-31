From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 31 Oct 2014 12:22:00 +0100
Subject: [PATCH RESEND V4 4/9] pinctrl: tegra-xusb: Add USB PHY support
In-Reply-To: <CAL1qeaEgyROk2dHbAOCUBJwCFegXH3_Yhr3reWdOrUXHvJ2cdg@mail.gmail.com>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
 <1414535277-15645-5-git-send-email-abrestic@chromium.org>
 <20141029122738.GE28356@ulmo.nvidia.com>
 <CAL1qeaF53VUEcn6OruxjufEXnPxyoqp4=sLUuhvJcrpGH=707A@mail.gmail.com>
 <20141030134517.GB19802@ulmo.nvidia.com>
 <CAL1qeaEgyROk2dHbAOCUBJwCFegXH3_Yhr3reWdOrUXHvJ2cdg@mail.gmail.com>
Message-ID: <20141031112158.GC10778@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 10:10:06AM -0700, Andrew Bresticker wrote:
> On Thu, Oct 30, 2014 at 6:45 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Wed, Oct 29, 2014 at 12:43:36PM -0700, Andrew Bresticker wrote:
> >> >> diff --git a/drivers/pinctrl/pinctrl-tegra-xusb.c b/drivers/pinctrl/pinctrl-tegra-xusb.c
[...]
> >> >> diff --git a/include/soc/tegra/xusb.h b/include/soc/tegra/xusb.h
> >> >> index cfe211d..149434f 100644
> >> >> --- a/include/soc/tegra/xusb.h
> >> >> +++ b/include/soc/tegra/xusb.h
> >> >> @@ -10,6 +10,13 @@
> >> >>  #ifndef __SOC_TEGRA_XUSB_H__
> >> >>  #define __SOC_TEGRA_XUSB_H__
> >> >>
> >> >> +#define TEGRA_XUSB_USB3_PHYS 2
> >> >> +#define TEGRA_XUSB_UTMI_PHYS 3
> >> >> +#define TEGRA_XUSB_HSIC_PHYS 2
> >> >> +#define TEGRA_XUSB_NUM_USB_PHYS (TEGRA_XUSB_USB3_PHYS + TEGRA_XUSB_UTMI_PHYS + \
> >> >> +                              TEGRA_XUSB_HSIC_PHYS)
> >> >> +#define TEGRA_XUSB_NUM_PHYS (TEGRA_XUSB_NUM_USB_PHYS + 2) /* + SATA & PCIe */
> >> >
> >> > These are really XUSB pad controller specific defines, why does anyone
> >> > else need to know this?
> >>
> >> They're not pad controller specific.  They're also used in the xHCI host driver.
> >
> > I keep thinking that there should be a way around this. Of course if
> > both the XHCI and mailbox drivers were merged, then there'd be no need
> > to expose this publicly at all.
> 
> I'm not sure what you mean.  They're SoC-specific constants that need
> to be shared amongst multiple drivers.  It would make sense to place
> them in a shared header, does it not?

The problem with this is that if those numbers ever change on a future
generation of Tegra then we're going to have to suffix them in some way
to support more than one generation. And the code to handle that is
going to be ugly because we'd need to differentiate on the compatible
string to match which suffixed version to use.

So I'd rather see this parameterized some way. Of course that's a lot
more difficult to do because these things are shared across XHCI and pad
controller drivers.

That said, I think it'd be fine to merge this as-is for now and rewrite
this in a better way if it ever becomes a problem.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/82db5602/attachment-0001.sig>

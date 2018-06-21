From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 21 Jun 2018 05:47:25 -0700
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
In-Reply-To: <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
Message-ID: <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 3:22 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Jun 20, 2018 at 7:07 PM, Fabio Estevam <festevam@gmail.com> wrote:
>
> > This patches causes a regression on a imx51-babbage running 4.18-rc1:
> > I get a kernel hang.
> >
> > If I revert it on top of 4.18-rc1, then it boots fine and USB host is
> > functional.
> >
> > I understand this patch fixes a kernel hang for you, so which commit
> > is responsible for the hang you observe?
> >

I never assumed it was a regression and that USB worked on RDU1 board
before, so I never tried to see if this was a regression. I can only
tell you that it hangs as soon as any PORTSC registers are accessed.

> > It seems this commit fixes a hang for you and causes another hang for me :-)
> >
> > Any ideas?
>

RDU1 design is based heavily on Babbage board, moreso USB1/ULPI
portion of it is an exact copy (it does use different GPIO for PHY
reset, but that's irrelevant), so I am surprised that it breaks in
your case.

However looking at imx51-babbage.dts, I am suspicious of it's USB1
setup. There we have usbh1phy node that references <&gpio2 5
GPIO_ACTIVE_LOW> as reset, but corresponding pinmux, pinctrl_usbh1reg,
is not being used anywhere. Cold that be that the problem you are
seeing is due to USB PHY not being properly reset?

> I am able to boot again if I skip passing the CI_HDRC_OVERRIDE_PHY_CONTROL flag:
>

Yeah, IMHO if you are dropping that flag, you may as well revert the
whole patch :-). The path that make the kernel hang in my case would
be taken if that flag is dropped.

Thanks,
Andrey Smirnov

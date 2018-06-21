From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 21 Jun 2018 11:08:07 -0300
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
In-Reply-To: <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
Message-ID: <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Thu, Jun 21, 2018 at 9:47 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> I never assumed it was a regression and that USB worked on RDU1 board
> before, so I never tried to see if this was a regression. I can only
> tell you that it hangs as soon as any PORTSC registers are accessed.

I think we need to investigate this portsc register hang further.

> RDU1 design is based heavily on Babbage board, moreso USB1/ULPI
> portion of it is an exact copy (it does use different GPIO for PHY
> reset, but that's irrelevant), so I am surprised that it breaks in
> your case.
>
> However looking at imx51-babbage.dts, I am suspicious of it's USB1
> setup. There we have usbh1phy node that references <&gpio2 5
> GPIO_ACTIVE_LOW> as reset, but corresponding pinmux, pinctrl_usbh1reg,
> is not being used anywhere. Cold that be that the problem you are
> seeing is due to USB PHY not being properly reset?

Yes, this can be improved, but this is not the cause of the issue .

gpio2 5 is passed as the USB PHY reset:

reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;

The default IOMUX setting after power on reset  is GPIO, so not an issue.

> Yeah, IMHO if you are dropping that flag, you may as well revert the
> whole patch :-). The path that make the kernel hang in my case would
> be taken if that flag is dropped.

Yes, it seems we need to revert the full patch and have a proper fix
in place that works for imx51 RDU, imx53-ppd and imx51 babbage.

The USB host 1 on imx51-babbage has been working since kernel 3.19 :-)

Thanks

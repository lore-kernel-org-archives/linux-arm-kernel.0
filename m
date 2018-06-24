From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sun, 24 Jun 2018 15:40:11 -0700
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
In-Reply-To: <CAOMZO5CumdNSP6iTfgXPdmpcZwh7YmBstUpAmb3A1QAf1UWJdw@mail.gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
 <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com>
 <CAOMZO5CumdNSP6iTfgXPdmpcZwh7YmBstUpAmb3A1QAf1UWJdw@mail.gmail.com>
Message-ID: <CAHQ1cqHpNvZGAfFKrp-OiZevsha5CBwJsw8GT+uhgNSfEUejkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 9:27 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Thu, Jun 21, 2018 at 6:44 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>
> > I just finished experimenting with it on RDU1 and Babbage boards and I
> > can't reproduce the hang that you describe against 4.18-rc1. At this
> > point I wonder if it's the bootloader that is a variable that plays
> > into this. I was booting both boards with 2018.06.0 version of barebox
> > + the custom patches that can be found here
> > https://github.com/ndreys/barebox/commits/rdu1-netboot. Note that the
> > last patch in that branch/stack was added as a part of this
> > investigation, but even before it, I was able to boot Linux just fine,
> > albeit without working USB.
>
> Thanks for investigating this issue.
>
> Yes, t is possible that the difference in behaviour that we see could
> be related to the fact we use different bootloaders.
>
> In order to make things easier, I am sharing a Buildroot image for
> imx51-babbage that contains U-Boot 2018.05 + kernel 4.17.2:
> https://www.dropbox.com/s/yevnu4y1zdchnbt/sdcard.img?dl=0
>
> Please flash it directly to the SD card via dd and boot it.
>
> You will notice that it will boot normally. Then please copy a
> 4.18-rc1 zImage into the first SD card partition and you will notice
> the hang.
>

It's definitely the bootloader, or more specifically whether or not it
initialized/used USB before booting the kernel. Some interesting
highlights:

 - On your "good" 4.17.2 based image, if you interrupt U-Boot, do "usb
start" (optionally "usb stop") and then "boot", you'll get the hang
that I was trying to fix with my patch.

 - Things are exact opposite with 4.18-rc1 and doing the above would
_prevent_ the hang and the image would boot fine.

 - Disabling USB in Barebox based boot "stack" gets it to behave the
same way as U-boot from your image (hanging when booting 4.18-rc1)

Digging more into code it seems that the reason for 4.18-rc1's
behavior is the fact that it's missing a call hw_phymode_configure()
after usb_phy_init() and, AFAICT, the only reason it is not happening
is because default image is being built without
CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS. Enabling those two
options on 4.18-rc1, seem to fix the problem on both your U-Boot based
image and my "special" Barebox setup.

So AFAICT, this patch still fixes a valid issue (my use-case was net
booting via USB-Ethernet dongle), but an additional patch enabling
those two configuration options might be needed. Thoughts?

Also, I don't have any i.MX53 HW, so I wasn't able to test the effects
of enabling those two options there.

Thanks,
Andrey Smirnov

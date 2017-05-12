From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 12 May 2017 11:16:41 +0200
Subject: [linux-sunxi] [PATCH] musb: sunxi: Ignore VBus errors in
 host-only mode
In-Reply-To: <0106707e-21f3-4aec-92ca-8b951af8a34e@googlegroups.com>
References: <55C47041.3000603@schinagl.nl> <55E93D8C.9020804@schinagl.nl>
 <55F1CA9B.3070204@redhat.com> <20150910183017.GN9885@lukather>
 <55F1CE2E.7010409@redhat.com> <20150914202533.GF4684@lukather>
 <CAOMqctTa7Q-_dSf_4HaGt34=+YF4Sct=WvHjzp-n67J72zyLrA@mail.gmail.com>
 <706aa130-3ace-4059-a7c9-44147cd56c28@googlegroups.com>
 <af013a0a-9257-4936-9e66-cb38f2e46369@googlegroups.com>
 <0106707e-21f3-4aec-92ca-8b951af8a34e@googlegroups.com>
Message-ID: <20170512091641.iqsee4bxlwizl5ok@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 11, 2017 at 02:45:11PM -0700, Bim Overbohm wrote:
> Hi All,
> 
> I had a similar problem running a mainline 4.11 kernel on an A33 tablet 
> (marked "Q8-2.4G 20140918". It came from a company called Trimeo and is 
> simply called 7". It contains an APX223 power controller, RTL8189ETV WiFi 
> controller, 2x Nanya NT5CB128M15FP-DY DRAM chips (2x256MB), a Hynix 
> H27UCG8T2BTR-BC NAND-flash chip and a Goodix GT818 touch controller. 
> Display resolution is 1024x600). The self-compiled u-boot dtb would 
> initialize the USB, but the kernel dtb would not work.

U-Boot doesn't use the DT for this USB setup.

> The kernel messages were something along the lines of "[ 9.366994]
> sun4i-usb-phy 1c19400.phy: could not find pctldev for node
> /soc at 01c00000/pinctrl at 01c20800/usb0_id_detect_pin at 0, deferring
> probe".

That's not likely to be your issue. The probe should be deferred, and
reattempted later.

> I found no way to activate the pinctrl devices, so I fixed this by
> decompiling the dts, removing all the USB id detect pin and vbus
> settings and recompiling the dts (diff at end of message). The
> device boots into LXDE now and I can use an USB keyboard and
> mouse. I still have no WiFi though...
> 
> Pastebin of unpatched dts file: https://pastebin.com/kL6WELuC
> 
> A couple of questions:
>
> - Is there a proper way to make the pinctrls and OTG dual mode work
>   on the device?! I suspect they are needed to activate WiFi too...

As I said, that's probably not your issue. Are you sure of your
micro-USB cable? Is it setting the ID pin to the ground as it's
supposed to?

> - Is this a bug I should report for sunxi-next?

sunxi-next is just a merge of various upstream branches. It doesn't
make sense to report bugs there. You've found the right place already.

> - Is there a driver for the GT818 in the mainline kernel or a way to
>   make that device work?

It doesn't look like there is.

> - Is there a driver for the RTL8189ETV in the mainline kernel or a way to 
> make that device work?

https://linux-sunxi.org/Wifi#RTL8189ES_.2F_RTL8189ETV

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170512/774c113d/attachment.sig>

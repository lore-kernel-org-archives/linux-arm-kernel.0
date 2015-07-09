From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 9 Jul 2015 15:30:36 +0200
Subject: [PATCH] pinctrl: imx1-core: Fix debug output pin array index
In-Reply-To: <559E3098.9070609@gtsys.com.hk>
References: <1436364966-19778-1-git-send-email-mpa@pengutronix.de>
 <20150709071252.GF1426@pengutronix.de>
 <559E3098.9070609@gtsys.com.hk>
Message-ID: <20150709133036.GK7573@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 09, 2015 at 04:28:08PM +0800, Chris Ruehl wrote:
> Uwe,
> 
> On Thursday, July 09, 2015 03:12 PM, Uwe Kleine-K?nig wrote:
> >Hello Markus,
> >
> >Cc += Chris Ruehl
> >
> >On Wed, Jul 08, 2015 at 04:16:06PM +0200, Markus Pargmann wrote:
> >>The pins do not have a 1:1 mapping from index to pin_id. Unfortunately
> >>the debug output assumes exactly that.
> >>
> >>The first driver using imx1-core was imx27, which had exactly this 1:1
> >>mapping. It was accidently removed when removing all unused pads which
> >>were listed:
> >>	607af165c047 (pinctrl: i.MX27: Remove nonexistent pad definitions)
> >>
> >>The patch fixes this issue by printing the pin_id directly and not the
> >>pin name.
> >Knowing a bit about the imx pinctrl drivers I failed to understand what
> >you wrote here. Probably because I first though that "1:1 mapping" is a
> >hardware property. What about:
> >
> >	Subject: pinctrl: imx1-core: Fix debug output in .pin_config_set callback
> >
> >	imx1_pinconf_set assumes that the array of pins in struct
> >	imx1_pinctrl_soc_info can be indexed by pin id to get the
> >	pinctrl_pin_desc for a pin. This used to be correct up to commit
> >	607af165c047 ("pinctrl: i.MX27: Remove nonexistent pad definitions")
> >	which removed some entries from the array and so made it wrong to access
> >	the array by pin id.
> >
> >	Implement the easiest fix by not resolving the pin id to a name but
> >	printing the id instead.
> >
> >	Fixes: 607af165c047 ("pinctrl: i.MX27: Remove nonexistent pad definitions")
> >	Cc: stable at vger.kernel.org
> >	Reported-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> >	Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >
> >Having the pad name in the output is nice, is it worth to search for the
> >right pinctrl_pin_desc in the array? The array is still sorted, so a
> >binary search would do, maybe a function for this already exists?
> >
> >How did Chris notice the error? Just a bogus output, or did it crash the
> >kernel? That would be worth to note in the commit log, too.
> >
> >Otherwise the change looks fine.
> >
> >Best regards
> >Uwe
> 
> I had a crash on a array overrun.
> 
> I'd applied a patch to the linux-usb (which was spit out by the maintainer
> perl script)

Yes, as there is already a patch from Chris my patch can be dropped. We
should continue the discussion on your patch instead.

> chris at wheezyvm:~/kernel.d/linux-next$ cat
> 0001-Pinctrl-imx1-fix-wrong-pin-name-resolving.patch
> From 50d56e5f626b2ea86211818cf487514c96f60487 Mon Sep 17 00:00:00 2001
> From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> Date: Sat, 23 May 2015 15:02:44 +0800
> Subject: [PATCH] Pinctrl: imx1: fix wrong pin-name resolving
> 
> Bug in function imx1_pinconf_set() cause crash when
> princtrl debug is enabled and the pin_id becomes larger
> then the info->pins[] contains.
> 
> imx27-pinctrl 10015000.iomuxc: request pin 134 (MX27_PAD_UART2_TXD) for
> 1000b000.serial
> imx27-pinctrl 10015000.iomuxc: request pin 135 (MX27_PAD_UART2_RXD) for
> 1000b000.serial
> imx27-pinctrl 10015000.iomuxc: request pin 131 (MX27_PAD_UART2_CTS) for
> 1000b000.serial
> imx27-pinctrl 10015000.iomuxc: request pin 132 (MX27_PAD_UART2_RTS) for
> 1000b000.serial
> imx27-pinctrl 10015000.iomuxc: enable function uart group uart2-1
> imx27-pinctrl 10015000.iomuxc: imx1_pmx_set, pin 0x86, function 0, gpio 0,
> direction 1, oconf 0, iconfa 0, iconfb 0
> imx27-pinctrl 10015000.iomuxc: imx1_pmx_set, pin 0x87, function 0, gpio 0,
> direction 0, oconf 0, iconfa 0, iconfb 0
> imx27-pinctrl 10015000.iomuxc: imx1_pmx_set, pin 0x83, function 0, gpio 0,
> direction 1, oconf 0, iconfa 0, iconfb 0
> imx27-pinctrl 10015000.iomuxc: imx1_pmx_set, pin 0x84, function 0, gpio 0,
> direction 0, oconf 0, iconfa 0, iconfb 0
> imx27-pinctrl 10015000.iomuxc: num_configs=1 PinID=134
> imx27-pinctrl 10015000.iomuxc: pinconf set pullup pin MX27_PAD_UART1_RTS
> imx27-pinctrl 10015000.iomuxc: num_configs=1 PinID=135
> imx27-pinctrl 10015000.iomuxc: pinconf set pullup pin MX27_PAD_RTCK
> imx27-pinctrl 10015000.iomuxc: num_configs=1 PinID=131
> imx27-pinctrl 10015000.iomuxc: pinconf set pullup pin MX27_PAD_UART1_TXD
> imx27-pinctrl 10015000.iomuxc: num_configs=1 PinID=132
> imx27-pinctrl 10015000.iomuxc: pinconf set pullup pin MX27_PAD_UART1_RXD
> ...
> imx27-pinctrl 10015000.iomuxc: write: register 0xf4415508 offset 4 value 0x3
> imx27-pinctrl 10015000.iomuxc: write: register 0xf4415510 offset 4 value 0x0
> imx27-pinctrl 10015000.iomuxc: write: register 0xf4415518 offset 4 value 0x0
> imx27-pinctrl 10015000.iomuxc: imx1_pmx_set, pin 0xb5, function 0, gpio 0,
> direction 1, oconf 0, iconfa 0, iconfb 0
> imx27-pinctrl 10015000.iomuxc: num_configs=1 PinID=171
> Unable to handle kernel paging request at virtual address 6c61765f
> pgd = c0004000
> 6c61765f] *pgd=00000000
> Internal error: Oops: 5 [#1] ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.1.0-rc4-next-20150522-dirty #8
> Hardware name: GTSYS i.MX27GTSIR (Device Tree Support)
> task: ce832000 ti: ce848000 task.ti: ce848000
> PC is at strnlen+0x28/0x3c
> LR is at string.isra.4+0x34/0xcc
> pc : [<c01ae188>]    lr : [<c01af9a4>]    psr: 20000093
> sp : ce849a88  ip : ce849a98  fp : ce849a94
> r10: c05d7e3a  r9 : c05d81e4  r8 : 00000000
> r7 : 6c61765f  r6 : c05d81e4  r5 : ffffffff  r4 : c05d7e3a
> r3 : 6c61765f  r2 : 6c61765f  r1 : 6c61765e  r0 : 6c61765f
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> 
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/pinctrl/freescale/pinctrl-imx1-core.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
> b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
> index 5ac59fb..8408bd8 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
> @@ -403,14 +403,16 @@ static int imx1_pinconf_set(struct pinctrl_dev *pctldev,
>  			     unsigned num_configs)
>  {
>  	struct imx1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> -	const struct imx1_pinctrl_soc_info *info = ipctl->info;
> +	struct pin_desc *desc;
>  	int i;
> 
> +	desc = pin_desc_get(pctldev, pin_id);

For the rest of this function pin_desc_get() is not necessary. This is
not a simple function call but a radix tree lookup as far as I can see.
I am not sure how important this debugging information is and how
expensive this function call is?!

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150709/509ef35f/attachment.sig>

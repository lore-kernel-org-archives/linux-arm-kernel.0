From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Dec 2012 08:20:45 -0200
Subject: 3.7 kernel hangs when doing scp
In-Reply-To: <20121220043943.GA992@nchen-desktop>
References: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
 <20121218024353.GA17118@kroah.com>
 <CAOMZO5DTB79e3W1_i2NLin7RWXVzraoysEGVLxv9_aoRS39D4Q@mail.gmail.com>
 <20121220043943.GA992@nchen-desktop>
Message-ID: <CAOMZO5B1DyktHa0Vfb4+-H9bdxaoacas6ZCHEH0bDLuKiCB6hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Thu, Dec 20, 2012 at 2:39 AM, Peter Chen <peter.chen@freescale.com> wrote:

> Please to see if the Stream mode disable (bit4, usbmode) is set or not?
> If it is not, please try below patch
>
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index c97503b..258bc02 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -227,6 +227,7 @@ static void tdi_reset (struct ehci_hcd *ehci)
>
>         tmp = ehci_readl(ehci, &ehci->regs->usbmode);
>         tmp |= USBMODE_CM_HC;
> +       tmp |= (1 << 4); /* disable stream mode */
>         /* The default byte access to MMR space is LE after
>          * controller reset. Set the required endian mode
>          * for transfer buffers to match the host microprocessor

Excellent! Your suggestion made scp work with mx6 on 3.7.

I assume that this "fix" or workaround would need a better place, right?

Should this fix go into the chipidea host driver instead?

Also, I wonder on how "standard" this USBMODE register is. i.e. there
is a deviation from the FSL EHCI USBMODE register.
I found it in include/linux/usb/ehci_def.h:

#define USBMODE_SDIS            (1<<3)          /* Stream disable */

, which is at a different bit position from the i.MX6 Reference Manual:

4 SDIS Stream Disable Mode. (0 - Inactive [default]; 1 - Active)

Also interested to know more details@to why disabling stream mode
make things work.

Thanks a lot!

Fabio Estevam

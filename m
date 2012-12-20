From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 20 Dec 2012 12:39:44 +0800
Subject: 3.7 kernel hangs when doing scp
In-Reply-To: <CAOMZO5DTB79e3W1_i2NLin7RWXVzraoysEGVLxv9_aoRS39D4Q@mail.gmail.com>
References: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
 <20121218024353.GA17118@kroah.com>
 <CAOMZO5DTB79e3W1_i2NLin7RWXVzraoysEGVLxv9_aoRS39D4Q@mail.gmail.com>
Message-ID: <20121220043943.GA992@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 12:56:12PM -0200, Fabio Estevam wrote:
> Hi Greg,
> 
> On Tue, Dec 18, 2012 at 12:43 AM, Greg KH <greg@kroah.com> wrote:
> > On Tue, Dec 18, 2012 at 12:01:35AM -0200, Fabio Estevam wrote:
> >> Hi,
> >>
> >> Booting a 3.7 kernel on a mx6qsabrelite board via NFS and using an
> >> asix USB/Ethernet adapter and then I try to transfer a 10MB file from
> >> the target to the host:
> >
> > Has this ever worked before on any older kernel?
> 
> We did more experiments on this and we noticed that:
> 
> - mx51 running kernel 3.7 does not show this problem (tested a non-dt
> mx51 kernel, which uses drivers/usb/host/ehci-mxc.c instead of the
> chipidea driver.)
> - x86 running 3.2 kernel does not show this problem
> - usb support on mx6 has appeared on 3.6, but running an out-of-tree
> 3.0.35 kernel also shows the same issue.
> - Doing long file transfers via mass storage on mx6 running 3.7 works fine.
> 
> Shawn/Sascha/Peter,
> 
> Any suggestions as to how debug this? By looking at the kernel dumps
> it seems to point to 'gic_handle_irq' area.
Hi Fabio,

Please to see if the Stream mode disable (bit4, usbmode) is set or not?
If it is not, please try below patch

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index c97503b..258bc02 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -227,6 +227,7 @@ static void tdi_reset (struct ehci_hcd *ehci)
 
 	tmp = ehci_readl(ehci, &ehci->regs->usbmode);
 	tmp |= USBMODE_CM_HC;
+	tmp |= (1 << 4); /* disable stream mode */
 	/* The default byte access to MMR space is LE after
 	 * controller reset. Set the required endian mode
 	 * for transfer buffers to match the host microprocessor

> 
> Thanks,
> 
> Fabio Estevam
> 

-- 

Best Regards,
Peter Chen

From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 15 Jun 2018 13:39:19 +0200
Subject: v4.18-rc0: ohci-platform on n900 oops-es on reboot
In-Reply-To: <20180614194449.GB17808@amd>
References: <20180614194449.GB17808@amd>
Message-ID: <20180615113919.GA28328@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> When I enable
> 
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_OMAP3=y
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> 
> on n900 (I need it on droid4 and want common config), I get oops when
> attempting to reboot the system. I believe problem is there in v4.17,
> too.
> 
> I'll try to build it as a module and debug, but if you have better
> idea, let me know...

It oopses in the ohci_shutdown, see the "oopses here" below.

Any ideas?
								Pavel

+       printk(KERN_CRIT "ohci_shutdown... have pointers %lx, %lx\n", hcd, ohci);
        ohci_writel(ohci, (u32) ~0, &ohci->regs->intrdisable);
+       printk(KERN_CRIT "ohci_shutdown... disable done\n");
+       udelay(1000);
+       printk(KERN_CRIT "ohci_shutdown... disable done\n");
 
        /* Software reset, after which the controller goes into SUSPEND */
        ohci_writel(ohci, OHCI_HCR, &ohci->regs->cmdstatus);
+       printk(KERN_CRIT "ohci_shutdown... writel done\n");
        ohci_readl(ohci, &ohci->regs->cmdstatus);       /* flush the writes */
+       /* It oopses here */
+       printk(KERN_CRIT "ohci_shutdown... readl done\n");
        udelay(10);
 
+       printk(KERN_CRIT "ohci_shutdown... reset done\n");      
        ohci_writel(ohci, ohci->fminterval, &ohci->regs->fminterval);
        ohci->rh_state = OHCI_RH_HALTED;
+
+       printk(KERN_CRIT "ohci_shutdown... all ok?\n"); 

	
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180615/1cb8b88e/attachment.sig>

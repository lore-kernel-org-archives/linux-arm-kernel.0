From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 2 Mar 2012 07:31:16 +0530
Subject: [PATCH v2 1/2] ARM: EXYNOS: Add USB HOST register definitions
In-Reply-To: <CADPsn1ZfXqmOVtw5OdfbXv=xZ3EREbPqCRnpnsYHbhkvx=nb5Q@mail.gmail.com>
References: <000701ccf76d$8316b0a0$894411e0$%han@samsung.com>
 <201203011624.04551.heiko@sntech.de>
 <CADPsn1ZfXqmOVtw5OdfbXv=xZ3EREbPqCRnpnsYHbhkvx=nb5Q@mail.gmail.com>
Message-ID: <CAJuYYwSiKAbMz68GQWCnD9po-cf6=xpWj-wQRcvj4kwneG0sMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 March 2012 21:40, Sangwook Lee <sangwook.lee@linaro.org> wrote:
[...]

> ?I found out some code related to this burst function.
>
> ?the snip from ehci-s5pv210.c, 2.6.35 kernel
>
> ??????? /* Mark hardware accessible again as we are out of D3 state by now
> */
> ??????? set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> #if defined(CONFIG_ARCH_S5PV210) || defined(CONFIG_ARCH_S5P6450)
> ??????? ehci_writel(ehci, 0x000F0000, (void __iomem *)ehci->caps + 0x90);
> #endif
>
> #if defined(CONFIG_ARCH_S5PV310)
> ??????? ehci_writel(ehci, 0x03C00000, (void __iomem *)ehci->caps + 0x90);
> #endif
> ??????? if (ehci_readl(ehci, &ehci->regs->configured_flag) == FLAG_CF) {
>
> From this code, this burst function seems to be depending on CPUs,
> The driver by itself is not good idea because echi-s5p.c will have defined.
>
> Which is the better place to pus this CPU specific definition either
> drivers/usb/host/ehci-s5p.h is
> or mach/xx.h or? include/linux/usb/xxx.h ?? I am not clear about this.

Any configuration that is controller specific should be in the driver.
If that configuration has a SoC specific behavior, a id_table can be
provided to the platform_driver which can provide any SoC specific
information. The samsung keypad driver is an example of how this can
be handled (drivers/input/keyboard/samsung.c).

Thanks,
Thomas.

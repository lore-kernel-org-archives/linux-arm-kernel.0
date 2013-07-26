From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jul 2013 09:55:42 +0100
Subject: [PATCH v3 1/3] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <1374792135-30343-2-git-send-email-hauke@hauke-m.de>
References: <1374792135-30343-1-git-send-email-hauke@hauke-m.de>
 <1374792135-30343-2-git-send-email-hauke@hauke-m.de>
Message-ID: <20130726085542.GA17886@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 11:42:13PM +0100, Hauke Mehrtens wrote:
> This patch adds support for the BCM5301X/BCM470X SoCs with an ARM CPUs.
> Currently just booting to a shell is working and nothing else, no
> Ethernet, wifi, flash, ...
> 
> This SoC is used in small office and home router with Broadcom SoCs.
> This code should support the BCM4707, BCM4708, BCM4709, BCM53010,
> BCM53011 and BCM53012 SoC. It uses one or two ARM Cortex A9
> Cores, some highlights are 2 PCIe 2.0 controllers, 4 Gigabit Ethernet
> MACs and a USB 3.0 host controller.
> 
> This SoC uses a dual core CPU, but this is currently not implemented.
> More information about this SoC can be found here:
> http://www.anandtech.com/show/5925/broadcom-announces-bcm4708x-and-bcm5301x-socs-for-80211ac-routers

[...]

> +static int bcm5301x_abort_handler(unsigned long addr, unsigned int fsr,
> +				 struct pt_regs *regs)
> +{
> +	/*
> +	 * These happen for no good reason, possibly left over from CFE
> +	 */
> +	pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
> +		addr, fsr);
> +
> +	/* Returning non-zero causes fault display and panic */
> +	return 0;
> +}
> +
> +static void __init bcm5301x_init_early(void)
> +{
> +	/* Install our hook */
> +	hook_fault_code(16 + 6, bcm5301x_abort_handler, SIGBUS, 0,
> +			"imprecise external abort");
> +}

Surely you can't be serious?

At least, we need a pretty good explanation of what *exactly* is causing
these spurious aborts before we start ignoring them unconditionally like
this. You're effectively masking an extremely serious error indicator with
this change.

Cheers,

Will

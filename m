From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jul 2013 17:53:11 +0100
Subject: [PATCH v3 1/3] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <51F28A20.7060105@hauke-m.de>
References: <1374792135-30343-1-git-send-email-hauke@hauke-m.de>
 <1374792135-30343-2-git-send-email-hauke@hauke-m.de>
 <20130726085542.GA17886@mudshark.cambridge.arm.com>
 <51F28A20.7060105@hauke-m.de>
Message-ID: <20130726165311.GH17886@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 03:39:28PM +0100, Hauke Mehrtens wrote:
> On 07/26/2013 10:55 AM, Will Deacon wrote:
> >> +static int bcm5301x_abort_handler(unsigned long addr, unsigned int fsr,
> >> +				 struct pt_regs *regs)
> >> +{
> >> +	/*
> >> +	 * These happen for no good reason, possibly left over from CFE
> >> +	 */
> >> +	pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
> >> +		addr, fsr);
> >> +
> >> +	/* Returning non-zero causes fault display and panic */
> >> +	return 0;
> >> +}
> >> +
> >> +static void __init bcm5301x_init_early(void)
> >> +{
> >> +	/* Install our hook */
> >> +	hook_fault_code(16 + 6, bcm5301x_abort_handler, SIGBUS, 0,
> >> +			"imprecise external abort");
> >> +}
> > 
> > Surely you can't be serious?
> > 
> > At least, we need a pretty good explanation of what *exactly* is causing
> > these spurious aborts before we start ignoring them unconditionally like
> > this. You're effectively masking an extremely serious error indicator with
> > this change.
> 
> This fault occurs once every boot sometime early in the boot process,
> but the actual time this happens varies randomly.

Well that's interesting in itself. It sounds like we don't know *for sure*
whether the abort is triggered by Linux. Since the abort is imprecise, the
timing will vary.

> Sadly I do not understand this completely, and I copied this from the
> vendor BSP with the corresponding code documentation. They think CFE
> (Common Firmware Environment, the bootloader used on these devices), did
> something wrong, but I do not have the actual source of CFE and I do not
> have the chip documentation. This occurs just once as far as I have seen
> this, we could just catch the first one. Changing the boot loader is
> also not an option, because I want to use this code on devices already
> shipped to costumers and I do not have access to the boot loader source
> code.

Can somebody with hardware debug capability help you out (I notice csd is on
CC...)? We can have the hack if we know why it's needed, but as it stands it
could easily be hiding other problems.

> Do you know what this fault normally indicates?

Usually that something went horribly wrong in the memory subsystem at some
point in the past (i.e. invalid requests stuck on the bus, to which nobody
replied). You can sometimes get these if you try to probe for
non-discoverable devices by poking around in the physical memory map.

Will

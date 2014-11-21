From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Nov 2014 17:59:57 +0100
Subject: [PATCHv3 09/16] ARM: mvebu: implement suspend/resume support
 for Armada XP
In-Reply-To: <20141121164142.GB20238@lunn.ch>
References: <1416585613-2113-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1416585613-2113-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141121164142.GB20238@lunn.ch>
Message-ID: <20141121175957.6ef4f26d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri, 21 Nov 2014 17:41:42 +0100, Andrew Lunn wrote:
> > +static void mvebu_pm_store_bootinfo(void)
> > +{
> > +	u32 *store_addr;
> > +	phys_addr_t resume_pc;
> > +
> > +	store_addr = phys_to_virt(BOOT_INFO_ADDR);
> > +	resume_pc = virt_to_phys(armada_370_xp_cpu_resume);
> > +
> > +	/*
> > +	 * The bootloader expects the first two words to be a magic
> > +	 * value (BOOT_MAGIC_WORD), followed by the address of the
> > +	 * resume code to jump to. Then, it expects a sequence of
> > +	 * (address, value) pairs, which can be used to restore the
> > +	 * value of certain registers. This sequence must end with the
> > +	 * BOOT_MAGIC_LIST_END magic value.
> > +	 */
> 
> Hi Thomas
> 
> Is this a well defined mechanism supported by mainline uboot, barebox
> etc. Or is it some Marvell extension to their uboot?

As far as I know, it is a Marvell extension to their "binary header",
so it's done even before U-Boot starts. Since the hardware needs
assistance from the bootloader to do suspend/resume, there is
necessarily a certain amount of cooperation/agreement needed by what
the kernel does and what the bootloader expects. I'm not sure there's
any "standard" mechanism here. Do you know of any?

I know the suspend/resume on the Blackfin architecture works the same
way (at least it used to work that way years ago when I did a bit of
Blackfin stuff). And here as well, there was some cooperation between
the kernel and the bootloader. See
arch/blackfin/mach-common/dpmc_modes.S, function do_hibernate() at the
end.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

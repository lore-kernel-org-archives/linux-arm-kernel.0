From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 28 Oct 2010 21:50:14 +0200
Subject: New Kirkwood board support
In-Reply-To: <4CC9CFF9.3070808@kernelconcepts.de>
References: <4CC9C245.3030906@kernelconcepts.de>
	<20101028190133.GC31158@pengutronix.de>
	<4CC9CFF9.3070808@kernelconcepts.de>
Message-ID: <20101028195014.GD31158@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nils,

On Thu, Oct 28, 2010 at 09:33:13PM +0200, Nils Faerber wrote:
> Am 28.10.2010 21:01, schrieb Uwe Kleine-K?nig:
> > On Thu, Oct 28, 2010 at 08:34:45PM +0200, Nils Faerber wrote:
> >>  arch/arm/configs/tk71_defconfig     | 1700 +++++++++++++++++++++++++++++++++++
> > I'm sure we're not taking new defconfigs now.  Can you add your machine
> > to an existing defconfig?  Moreover it's not reduced.  You need to do at
> 
> Hmm... I have to look at the others. Probably a good idea.
> 
> > least:
> > 	make tk71_defconfig
> > 	make savedefconfig
> > 	mv defconfig arch/arm/configs/tk71_defconfig
> 
> OK, thanks, will check that out!
> 
> >> +	/* eth1 */
> >> +	if (gpio_request(28, "PHY2 reset") != 0 ||
> >> +		gpio_direction_input(28) != 0) // high-z
> > I don't know if it's usually in mach-kirkwood to write it this way, but
> > I think it can be done in a more readable way.
> 
> Most importantly I juts saw a remaining "//" comment - oops!
Do you know scripts/checkpatch.pl?  It should warn about these comments
and some more things.
 
> But how more readable should I do that? The pin is assigned to the gpio
> system (which is IMHO a good idea) and those line should make it high
> impedance. This has nothing much to do with kirkwood I think.
I think the usuals kernel style is something like:

	#define TK71_GPIO_PHY2_RESET 28
	static inline int tk71_setup_phy2_reset(void)
	{
		int ret = gpio_request(TK71_GPIO_PHY2_RESET, "PHY2 reset");
		if (ret)
			goto err_request_phy2_reset;
		
		ret = gpio_direction_input(TK71_GPIO_PHY2_RESET);
		if (ret) 
	err_request_phy2_reset:
			pr_err("something\n");

		return ret;
	}

It's a bit more verbose, but (IMHO) easier so parse.

> >> +		printk(KERN_ERR "can't deassert GPIO 28 (PHY2 reset)\n");
> > pr_err maybe?
> 
> Well - sure, could take that too, OK.
You can even define pr_fmt to something sensible to get a common prefix
for all pr_xyz.

> 
> >> +MACHINE_START(TK71, "TK71 Kirkwood based Q7 formfactor board")
> >> +	/* Maintainer: Nils Faerber <nils.faerber@kernelconcepts.de> */
> >> +	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
> >> +	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
> > These fields don't exist anymore.
> 
> Oh really? Which more exactly? I miss to see the difference with other
> boards in the mach-kirkwood/ subdir.
Then you didn't have the corresponding commit yet.

See http://git.kernel.org/linus/6451d7783ba5ff24eb1a544eaa6665b890f30466
.  (This is post-2.6.36 material.)
 
Liebe Gr??e
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Dec 2010 11:24:30 +0000
Subject: [PATCH V2] S5PC210: universal: update support pmic for c210
	universal board
In-Reply-To: <4D18174F.8060804@samsung.com>
References: <1293168299-11552-1-git-send-email-dh09.lee@samsung.com>
	<20101224173531.GA26913@sirena.org.uk>
	<4D18174F.8060804@samsung.com>
Message-ID: <20101227112429.GA25753@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 27, 2010 at 01:34:23PM +0900, Donghwa Lee wrote:
>  On 2010-12-25 ?? 2:35 , Mark Brown wrote:
> > On Fri, Dec 24, 2010 at 02:24:59PM +0900, Donghwa Lee wrote:

> >> +static struct regulator_consumer_supply max8952_consumer[] = {
> >> +	{
> >> +		.supply		= "varm_1.2v_c210",
> >> +	}, {
> >> +		.supply		= "vdd_arm",
> >> +	},
> > This looks very suspicious - you've got two supplies, both of which look
> > like the CPU core rail provided by the same regulator, one of which
> > looks like it's got the name of the supply hard coded into it.  What are
> > these two supplies exactly?

>  I will remove "vdd_arm" next patch.

I think that's the wrong one to remove; see below.

> >> +			.name		= "VARM_1.2V",

> > Interesting name for a supply that can change voltage :)

> 1.2V is default voltage. If it is needed , volatage can be changed.
> Is the name changed?

The name is fine, it's just amusing.

> >> +static struct regulator_consumer_supply lp3974_buck2_consumer[] = {
> >> +	{
> >> +		.supply		= "vg3d_1.2v_c210",
> >> +	},

> > This and most of the other consumers you're defining look like they're
> > actually the names for the relevant rails rather than supplies for
> > individual devices.  You shouldn't do this, supplies should be actual
> > supplies on individual consumers - probably most of these consumers
> > should just be removed.  You can name the supplies for UI purposes using
> > the .name field in the constraints.

> Supplies name of this patch is defined in the schematic diagram.
> Could you suggest the name for UI purposes?

You're misunderstanding what supplies are.  The supplies define how the
regulators are connected to the other devices on the board, they allow
other devices to request supplies in terms of the name the device itself
uses for the supply (eg, "DBVDD") rather than in terms of a board
specific name (like what you've got above).  This is why there's a
device field - it's to specify the device that the supplies are in terms
of.

> > Can you really turn off the VINT regulator at runtime?  I'd expect that
> > to crash the processor.  Similarly for many of the other supplies.

> If it turns off at run time, it would be crash the processor, but, it will be turn off
> only when executing SLEEP, maybe no problem.

That's a separate thing, no need to enable change status for that.

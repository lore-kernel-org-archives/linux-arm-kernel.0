From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 26 Jun 2018 15:59:04 +0200
Subject: [PATCH] pinctrl: armada-37xx: add suspend/resume support
In-Reply-To: <87a7tkby8z.fsf@bootlin.com>
References: <20180421141731.25556-1-miquel.raynal@bootlin.com>
 <87a7tkby8z.fsf@bootlin.com>
Message-ID: <20180626155904.1bdd5626@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Mon, 30 Apr 2018 15:49:16 +0200, Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

> Hi Miquel,
>  
>  On sam., avril 21 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > From: Ken Ma <make@marvell.com>
> >
> > Add suspend/resume hooks in pinctrl driver to handle S2RAM operations.
> >
> > Beyond the traditional register save/restore operations, these hooks
> > also keep the GPIOs used for both-edge IRQ synchronized between their
> > level (low/high) and expected IRQ polarity (falling/rising edge).
> >
> > Since pinctrl is an infrastructure module, its resume should be issued
> > prior to other IO drivers. The pinctrl PM is registered as syscore
> > level to make sure of it. A postcore initcall is added to register
> > syscore operation. Because of the use of such syscore_ops, the
> > suspend/resume hooks do not have access to a device pointer, and thus
> > need to use a global list in order to keep track of the probed devices
> > for which registers have to be saved/restored.  
> 
> Did you consider to use SET_LATE_SYSTEM_SLEEP_PM_OPS ?

Indeed, registering syscore operations is probably not the right thing
to do. Instead of registering the PM operations with
SET_LATE_SYSTEM_SLEEP_PM_OPS as suggested, I decided to just set
suspend_late and resume_early (which do the trick). Using the above
macro would have set other hooks (eg. for freeze and poweroff) that I
don't want to be set.

> 
> [...]
> 
> > +#if defined(CONFIG_PM)
> > +static int armada_3700_pinctrl_suspend(void)
> > +{
> > +	struct armada_37xx_pinctrl *info;
> > +
> > +	list_for_each_entry(info, &device_list, node) {
> > +		/* Save GPIO state */
> > +		regmap_read(info->regmap, OUTPUT_EN, &info->pm.out_en_l);
> > +		regmap_read(info->regmap, OUTPUT_EN + sizeof(u32),
> > +			    &info->pm.out_en_h);
> > +		regmap_read(info->regmap, OUTPUT_VAL, &info->pm.out_val_l);
> > +		regmap_read(info->regmap, OUTPUT_VAL + sizeof(u32),
> > +			    &info->pm.out_val_h);
> > +
> > +		info->pm.irq_en_l = readl(info->base + IRQ_EN);
> > +		info->pm.irq_en_h = readl(info->base + IRQ_EN + sizeof(u32));
> > +		info->pm.irq_pol_l = readl(info->base + IRQ_POL);
> > +		info->pm.irq_pol_h = readl(info->base + IRQ_POL + sizeof(u32));
> > +
> > +		/* Save pinctrl state */
> > +		regmap_read(info->regmap, SELECTION, &info->pm.selection);  
> 
> I thought there was an API with regmap which allow to save all the
> register in one call. If it is the case it woudl be nice to use it.

Yes there is one, your comment forced me to have a look at it. Once a
regcache is initialized, the hooks may be shrink to something like:

suspend()
{
        /* Flush the pending writes, buffering future accesses */
        regcache_cache_only(regmap, true);
        /* Indicate the device has been reset, all registers should be
         * synced on regcache_sync(), not only those that might have
         *  been written since turning regcache read-only.
	 */
        regcache_mark_dirty(regmap);
}

resume()
{
	/* Stop buffering */
        regcache_cache_only(regmap, false);
	/* Synchronize the registers with their saved values */
	regcache_sync(regmap);
}

However this would apply on the whole syscon regmap (which is huge),
with (I think) a global lock and the saving of more than 200 registers
while I just want 5 of them. It looks a bit overkill for what I need
and would imply a delay penalty on both suspend and resume operations so
I think I will let the code as is. Please have a look at the next
version.

Thanks for pointing these two features,
Miqu?l

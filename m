From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 5 Apr 2013 19:09:13 -0300
Subject: [PATCH v2 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130405214510.GB16221@obsidianresearch.com>
References: <1365196320-15084-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365196320-15084-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130405214510.GB16221@obsidianresearch.com>
Message-ID: <20130405220912.GA15162@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Thanks for the review.

On Fri, Apr 05, 2013 at 03:45:10PM -0600, Jason Gunthorpe wrote:
> On Fri, Apr 05, 2013 at 06:11:56PM -0300, Ezequiel Garcia wrote:
> 
> > +The reg property must specify the chip select as:
> > +
> > +  0: DEV_BOOTCS
> > +  1: DEV_CS0
> > +  2: DEV_CS1
> > +  3: DEV_CS2
> > +  4: DEV_CS3
> 
> I look at this and sort of go 'hmm'. These are basically register
> offsets into the block starting at 0xd0010400. I don't see any
> registers that are shared between targets. It would be simpler to keep
> each target as a seperate node and seperate driver instance.
> 

Mmm.. sounds sensible.

> Combining that idea with the suggestion for target-id centric mbus DT
> binding:
> 
> bootcs at d0010400 {
>    compatible = "marvell,armada370-devbus";
>    ranges = <0 MAPDEF_BOOTCS 0x1000>
>    reg = <MAPDEF_INTERNAL + 0x10400 0x8>;  // boot cs register set
>    devbus,dev-width = <1>;
>    [..] etc
> 
>    rom at 0 {
>       reg = <0 0x1000>
>    }
> }
> 
> bus_cs3 at d0010400 {
>    compatible = "marvell,armada370-devbus";
>    ranges = <0 MAPDEF_BUS_CS3 0x1000>
>    reg = <MAPDEF_INTERNAL + 0x10408 0x8>; // cs3 register set
>    devbus,dev-width = <1>;
>    [..] etc
> 
>    device at 0 {
>       reg = <0 0x1000>
>    }
> }
> 
> Which follows the usual DT convention that the parent bus sets up
> properties that apply to all children.
> 
> This isn't a major point, but give it a think :)
> 

Okey, I will.

> > +static void get_timing_param_ps(struct devbus *devbus,
> > +				struct device_node *node,
> > +				const char *name,
> > +				u32 *ticks)
> > +{
> > +	u32 time_ps;
> > +
> > +	of_property_read_u32(node, name, &time_ps);
> > +
> > +	*ticks = (time_ps + devbus->tick_ps - 1) / devbus->tick_ps;
> > +
> > +	dev_dbg(devbus->dev, "%s: %u ps -> 0x%x\n",
> > +		name, time_ps, *ticks);
> > +}
> 
> It looks like there is a problem here, if the properties are not
> present then what value will be in time_ps?
> 
> The driver should probably fail to load if any timing parameter is
> missing from the DT??
> 

Of course, I knew I was forgeting something. We should at least
zero every timing parameter by default.

I'll fix this in a soon to come v3.

Do you think it's also important/necessary to fail if *any*
parameter is missing? I guess it makes sense if we are making
these parameters mandatory.

> > +	/*
> > +	 * We probe NOR/NAND with different functions, because
> > +	 * we expect them to have some different parameters.
> > +	 * If this turns out not to be the case, we'll be able
> > +	 * to use any name for the child, and rename to devbus_probe_child().
> > +	 */
> 
> This statement seems confusing, all this driver does is set
> READ_PARAM_OFFSET/WRITE_PARAM_OFFSET - are there other NAND specific
> registers? What NOR/NAND difference do you imagine?
> 

Yes, you're probably right. Let me fix that too.

> I gave it all a quick look over and it looks broadly OK to me
> otherwise.
> 

Great, thanks!

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 26 Oct 2012 14:00:52 -0400
Subject: [PATCH] arm: kirkwood: add support for ZyXEL NSA310
In-Reply-To: <alpine.DEB.2.02.1210261857100.20029@mirri>
References: <alpine.DEB.2.02.1210251735020.15860@mirri>
 <20121025181326.GL18811@titan.lakedaemon.net>
 <alpine.DEB.2.02.1210261857100.20029@mirri>
Message-ID: <20121026180052.GA22042@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On Fri, Oct 26, 2012 at 08:25:52PM +0300, Tero Jaasko wrote:
> > hmmm, there probably won't be any conflicts when I go to apply this, but
> > in the future, please base against a tag in Linus' tree.  eg v3.6
> 
> I see and did that on the new submission attached to Andrew's mail.

Just to clarify, -rc's are fine as well, no need to change for this
patch.

> > > +	model = "ZyXEL NSA310";
> > > +	compatible = "zyxel,nsa310", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> > 
> > Is there only one variant of the nsa310?  eg did they change flash types
> > or ram size during a production run?  Whether they did or not, we prefer
> > to be as specific as possible here, eg "zyxel,nsa310-PRODNUM" If you can
> > locate a PRODNUM that will most likely change if they change the BOM,
> > etc.  Please add this string in addition to what you currently have.i
> 
> I have no idea what product number or other id this device has. 
> On http://zyxel.nas-central.org/wiki/Category:NSA-310 it is 
> said that there is at least a sister model under "TDC Homedisk" label.
> The TDC variant seems to have different amount of leds and at least
> the NAND partition configuration is also different. And also some 
> variant exists on some sources somewhere which might not have been 
> sold at all.
> 
> The device I have looks like the one described on previous link 
> as a "genuine". It does not have even the NSA310 printed in it, 
> just "ZyXEL" and two printed stickers, one with ethernet MAC 
> address and one with a long number which might be a serial number. 
> Or not. It is formatted as S111M32xxxxxx, x being a number. 
> The string itself is unknown to google, hence it might be a unique id.
> 
> What should we do? Add better device id if/when somebody from
> Denmark comes up with a TDC device that requires different DT?

Thanks for the explaination, let's leave it the way it is.  If we get
a hold of the TDC Homedisk, we can make it "zyxel,TDC-Homedisk".

> > > +config MACH_NSA310_DT
> > > +	bool "ZyXEL NSA-310 (Flattened Device Tree)"
> > > +	select ARCH_KIRKWOOD_DT
> > > +	select ARM_APPENDED_DTB
> > > +	select ARM_ATAG_DTB_COMPAT
> > 
> > I would prefer not to enable APPENDED_DTB by default.
> 
> Ok, I removed that. I just believe it is needed to be actually
> boot the device with stock uBoot. Or is there other/better way to bundle the
> DT blob into uImage? 

My understanding of the Kernel policy is that APPENDED_DTB defeats the
purpose of having devicetree (one kernel zImage capable of booting on
any ARM board when provided the dtb).  The sole reason I am aware of for
APPENDED_DTB existing in the kernel is to assist end users who are
unable to upgrade their bootloader.

Kirkwood doesn't really have this problem as a lot of the boards have
JTAG access, and those that don't can load a u-boot image over serial
via kwboot.

If you find a kirkwood board that doesn't work with kwboot, please let
us and the u-boot community know so we can fix kwboot.

> The uBoot my device is dated as "U-Boot 1.1.4 (Feb 22 2011 - 10:31:35) 
> Marvell version: 3.4.1", and as far as I know, it does not have the DT 
> support. I have not tried with a more recent uBoot. After having bricked 
> one Buffalo Ls-xhl with a failed uBoot update, I will not do another 
> before populating the JTAG pins on PCB and verifying that the plan 
> B works;-)

Have you tried kwboot to rescue it?  It doesn't require any bootloader
to work.  It's in the u-boot git tree under tools/, since v2012.07.

> > > diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
> > > new file mode 100644
> > > index 0000000..4d20841
> > > --- /dev/null
> > > +++ b/arch/arm/mach-kirkwood/board-nsa310.c
> > > @@ -0,0 +1,166 @@
> > > +/*
> > > + * arch/arm/mach-kirkwood/board-nsa310.c
> > > + *
> > > + * ZyXEL NSA-310 Setup
> > 
> > Copyright?
> 
> ..is not really mine at least. I have just deleted ~60% of 
> the code taken from openwrt.org's tree (commit at 
> https://dev.openwrt.org/browser/trunk/target/linux/kirkwood/
> patches-3.3/202-zyxel-nsa-310.patch?rev=31673) and replaced 
> it with the dt definitions.

Then please add this information to the commit log so that we can have a
good history of where it came from.

> > > +static unsigned int nsa310_mpp_config[] __initdata = {
> > > +	MPP12_GPIO, /* led esata green */
> > > +	MPP13_GPIO, /* led esata red */
> > 
> > There is a patch series to convert all kirkwood DT boards over to DT
> > init of MPP is under review currently.  If things go well, I'd like to
> > see this use it as well.
> 
> That will be really a good improvement for all the boards and
> conversion would be easy too. After this, ehci and pcie conversion,
> the board-nsa310.c would be something like 70-80 lines instead of 
> ~270 lines at original nsa-310-setup.c. Sweet.

even more than that since the gpio functionality will get wrapped up in
there as well. ;-)

> > > +
> > > +static void nsa310_power_off(void)
> > > +{
> > > +	gpio_set_value(NSA310_GPIO_POWER_OFF, 1);
> > > +}
> > > +
> > > +static int __init nsa310_gpio_request(unsigned int gpio, unsigned long flags,
> > > +				       const char *label)
> > > +{
> > > +	int err;
> > > +
> > > +	err = gpio_request_one(gpio, flags, label);
> > > +	if (err)
> > > +		pr_err("NSA-310: can't setup GPIO%u (%s), err=%d\n",
> > > +			gpio, label, err);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static void __init nsa310_gpio_init(void)
> > > +{
> > > +	int err;
> > > +
> > > +	err = nsa310_gpio_request(NSA310_GPIO_POWER_OFF, GPIOF_OUT_INIT_LOW,
> > > +				  "Power Off");
> > > +	if (!err)
> > > +		pm_power_off = nsa310_power_off;
> > 
> > This doesn't smell right.
> 
> What do you mean? The wrapper for gpio_request_one() that merely 
> serves as a source for debug messages? I can replace it with 
> a silent version if wanted. Is there a driver for shutting down device
> by some gpio pin defined in DT?

Sorry, I couldn't quite put my finger on it, and didn't want to delay
feedback to you.  Basically, I was referring to the entire gpio_* block
of code.  No one else needs this much code to accomplish the task,
however, it should all dissappear with the pinctrl conversion.  Let's
leave it as is on the condition that we'll get rid it with the conversion
to DT pinctrl/gpio.

> > > +	kirkwood_pcie_id(&dev, &rev);
> > 
> > Does this board actually use pcie?  If so, we've been looking for one to
> > test on.  Just an fyi, we'll probably be hitting you up later for pcie
> > DT binding testing. ;-)
> 
> If you point to a tree or patches somewhere, I am willing to test it and/or 
> modify the nsa310 code to use it.

Cool, thanks!  We'll hit you up when we get there.  Everyone is pretty
much task saturated atm.

thx,

Jason.

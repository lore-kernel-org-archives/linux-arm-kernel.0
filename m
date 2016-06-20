From: pantelis.antoniou@konsulko.com (Pantelis Antoniou)
Date: Mon, 20 Jun 2016 12:27:11 +0300
Subject: Auto-detecting touchscreen controller and dealing with hw
 configuration differences on q8 tablets
In-Reply-To: <bc978925-46a4-c069-8793-903a87ec70b8@redhat.com>
References: <bc978925-46a4-c069-8793-903a87ec70b8@redhat.com>
Message-ID: <5E70AD96-4E8E-4430-AF99-0AA0FCF5F8E7@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

I?m going to commend only on the overlay related parts since I?m not I
get all the nuances right.

> On Jun 19, 2016, at 14:06 , Hans de Goede <hdegoede@redhat.com> wrote:
> 
> <resend with Pantelis' email address fixed>
> 
> Hi All,
> 
> The sunxi support in the kernel supports (amongst many other devices) the quite
> popular low cost q8 form factor 7" tablets.
> 
> These are all based on the same case, with an allwinner SoC inside (there
> are non allwinner versions, but those are out of scope) and typically all based on
> the same reference design.
> 
> Currently we support any such tablet with 4 u-boot defconfigs / 4 dts files:
> 
> q8_a13_tablet
> q8_a23_tablet_800x480
> q8_a33_tablet_800x480
> q8_a33_tablet_1026x600
> 
> So all the user needs to know to get mainline running on these is which SoC his
> tablet is using and which resolution his lcd has.
> 
> However the reference design gets completed by the manufacturers with whatever
> accelerometer, wifi chip and touchscreen controller are cheapest for the batch
> being produced that week.
> 
> The plan is (was ?) to use auto-detection to figure out which components are
> used and adjust the dts using e.g. overlays.
> 
> Recently I've been working together with some students from my local university
> to get a driver for the gsl1680 touchscreen controller used in most of these
> tablets upstream.
> 
> So now I've been testing the touschscreen on all q8 tablets I own and
> unfortunately things are not so easy. The gsl1680 is quite flexible, it features
> a number of capacitive sense pins and these can be routed in random order to
> sense lines in the display, during init the controller gets feed a configuration
> data file with which pins go where and various lookup tables.
> 
> Here is a table of all tablets I've tested:
> 
> a13-94v-0:		a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600 inverted-x
> a13-tzx-713b-v2.1:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600
> a23-q8h-v3:		a082 a23-tj-a23-q88-v4.0_20140815/GSL1688_A70_FW.fw	 800x480 swapped-x-y
> a23-tj-a23-q88-v4.0:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600
> a23-ippo-q8h-v1.2:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1688_A70_FW.fw	 800x480 swapped-x-y
> a33-ippo-q8h-v1.2:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1688_A70_FW.fw	 800x480 swapped-x-y
> a33-tzx-723q4:		b482 a33-Q8_V2.4_1118/GSL1680_FW_D702.fw		 960x480 inverted-x
> a33-q8-v2.4-1118:	b482 a33-Q8_V2.4_1118/GSL1680_FW_D702.fw		 960x480
> a33-q8h-v1.5:		b482 a33-q8h-v1.5/GSL1688_A70_FW.fw			 960x480
> 
> 
> The first column is <soc>-<pcb-marking>, the second is the chip-id from the gsl1680 (this can be read
> via i2c), the third column is the configdata file used for testing, the directory-name it is prefixed
> with is from which board's android image the firmware file was extracted. The 4th column shows
> the resolution of the reported coordinates and any necessary flags.
> 
> Note that the resolution and if we need swapped-x-y actually is fixed for a given fw file, so
> we need to keep this information paired.
> 
> So as you can see which fw file to use, and whether x is inverted or not vary from board to board.
> 
> This leaves us with 2 options:
> 
> 1) Move to 1 dts file per PCB variant solution, of ALL the q8 tablets I've seen I've only ever
> had 2 with identical PCB-s and those were from the same batch, so this seems unmaintainable.
> Which leaves us with:
> 

Yeah, you?re going to be fighting a losing battle.

> 2) Give the user some way to override the dts settings.
> 
> Which after a somewhat long intro brings me to the actual purpose of this thread, discuss
> how to best deal with this. I again see 2 options:
> 
> 1) Put a disabled gsl1680 node in the dts file, have a q8_autodetect.c in u-boot
> which probes i2c and if it finds the gsl1680 nodes enables it, and patches in a best-effort
> default for which fw file to use. Allow the user to set a touchscreen_fw u-boot env
> variable which will override this. Also allow the user to set a touchscreen_inverted_x env
> variable to add inverted-x to the dt node for the gsl1680.
> 

That can work. The problem is that having anything requiring smarts in u-boot always
leads to trouble with users. It all depends on your user?s technical proficiency, if
they are comfortable tweaking things in u-boot it?s fine. If it?s not, expect lots of
bricked boards when they mess up.

> 2) Write an in kernel overlay manager which does auto-detect as described by 1, and
> loads an overlay for the detected touchscreen controller, with module options to allow
> specifying the fw-file, x-inversion, etc.
> 
> One things which worries me about 2. is that we would need to have 2 overlay files
> per fw-file, one regular config, one inverted-x, or is it possible for the overlay
> manager to modify an overlay before applying it ?
> 

Yes, it?s quite possible. You can even have stacked overlays.

> I tend towards doing the auto-detect in u-boot, since that will give the greatest
> flexibility (the dtb is fully read-writable in u-boot) and I can easily access
> things like i2c-busses, soc id/version register, etc. there.
> 

u-boot will work, but you will get into trouble if you demand users to drop to u-boot
to make changes.

> But before sinking a lot of time in either one of these I first wanted to discuss
> this, if the consensus is that an in kernel overlay manager is the way to go
> I will take a shot at that instead.
> 
> Regards,
> 
> Hans

Regards

? Pantelis

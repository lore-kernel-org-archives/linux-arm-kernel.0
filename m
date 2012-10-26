From: tero.jaasko@gmail.com (Tero Jaasko)
Date: Fri, 26 Oct 2012 20:25:52 +0300 (EEST)
Subject: [PATCH] arm: kirkwood: add support for ZyXEL NSA310
In-Reply-To: <20121025181326.GL18811@titan.lakedaemon.net>
References: <alpine.DEB.2.02.1210251735020.15860@mirri>
 <20121025181326.GL18811@titan.lakedaemon.net>
Message-ID: <alpine.DEB.2.02.1210261857100.20029@mirri>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello, Jason and thanks for your comments.
 
> hmmm, there probably won't be any conflicts when I go to apply this, but
> in the future, please base against a tag in Linus' tree.  eg v3.6

I see and did that on the new submission attached to Andrew's mail.

> > +	model = "ZyXEL NSA310";
> > +	compatible = "zyxel,nsa310", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> 
> Is there only one variant of the nsa310?  eg did they change flash types
> or ram size during a production run?  Whether they did or not, we prefer
> to be as specific as possible here, eg "zyxel,nsa310-PRODNUM" If you can
> locate a PRODNUM that will most likely change if they change the BOM,
> etc.  Please add this string in addition to what you currently have.i

I have no idea what product number or other id this device has. 
On http://zyxel.nas-central.org/wiki/Category:NSA-310 it is 
said that there is at least a sister model under "TDC Homedisk" label.
The TDC variant seems to have different amount of leds and at least
the NAND partition configuration is also different. And also some 
variant exists on some sources somewhere which might not have been 
sold at all.

The device I have looks like the one described on previous link 
as a "genuine". It does not have even the NSA310 printed in it, 
just "ZyXEL" and two printed stickers, one with ethernet MAC 
address and one with a long number which might be a serial number. 
Or not. It is formatted as S111M32xxxxxx, x being a number. 
The string itself is unknown to google, hence it might be a unique id.

What should we do? Add better device id if/when somebody from
Denmark comes up with a TDC device that requires different DT?

> > +config MACH_NSA310_DT
> > +	bool "ZyXEL NSA-310 (Flattened Device Tree)"
> > +	select ARCH_KIRKWOOD_DT
> > +	select ARM_APPENDED_DTB
> > +	select ARM_ATAG_DTB_COMPAT
> 
> I would prefer not to enable APPENDED_DTB by default.

Ok, I removed that. I just believe it is needed to be actually
boot the device with stock uBoot. Or is there other/better way to bundle the
DT blob into uImage? 

The uBoot my device is dated as "U-Boot 1.1.4 (Feb 22 2011 - 10:31:35) 
Marvell version: 3.4.1", and as far as I know, it does not have the DT 
support. I have not tried with a more recent uBoot. After having bricked 
one Buffalo Ls-xhl with a failed uBoot update, I will not do another 
before populating the JTAG pins on PCB and verifying that the plan 
B works;-)

> > diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
> > new file mode 100644
> > index 0000000..4d20841
> > --- /dev/null
> > +++ b/arch/arm/mach-kirkwood/board-nsa310.c
> > @@ -0,0 +1,166 @@
> > +/*
> > + * arch/arm/mach-kirkwood/board-nsa310.c
> > + *
> > + * ZyXEL NSA-310 Setup
> 
> Copyright?

..is not really mine at least. I have just deleted ~60% of 
the code taken from openwrt.org's tree (commit at 
https://dev.openwrt.org/browser/trunk/target/linux/kirkwood/
patches-3.3/202-zyxel-nsa-310.patch?rev=31673) and replaced 
it with the dt definitions.

> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */


> > +#define NSA310_GPIO_LED_ESATA_GREEN	12
> Please remove any of the above #define's that aren't used.

Done.

> > +static unsigned int nsa310_mpp_config[] __initdata = {
> > +	MPP12_GPIO, /* led esata green */
> > +	MPP13_GPIO, /* led esata red */
> 
> There is a patch series to convert all kirkwood DT boards over to DT
> init of MPP is under review currently.  If things go well, I'd like to
> see this use it as well.

That will be really a good improvement for all the boards and
conversion would be easy too. After this, ehci and pcie conversion,
the board-nsa310.c would be something like 70-80 lines instead of 
~270 lines at original nsa-310-setup.c. Sweet.

> > +static struct mtd_partition nsa310_mtd_parts[] = {
> > +	{
> > +		.name	= "uboot",
> Please move the above partition definitions into the dts file, you can
> then remove all of the nand init and relevant includes.

Done.

> > +
> > +static struct i2c_board_info __initdata nsa310_i2c_info[] = {
> > +	{ I2C_BOARD_INFO("adt7476", 0x2e) },
> > +};
> 
> how far off from the adt7461 (lm90) is this?  If similar, please
> consider extending lm90's compatibility list and describing this in the
> dts instead.

I did move at least the I2C to DT. Good catch, this is something 
worth of a experimentation when a free time slot arrives. The chip seems 
to have some sort of compatibility mode with adt7463 so it might just 
work somehow with the other driver too.

> > +
> > +static void nsa310_power_off(void)
> > +{
> > +	gpio_set_value(NSA310_GPIO_POWER_OFF, 1);
> > +}
> > +
> > +static int __init nsa310_gpio_request(unsigned int gpio, unsigned long flags,
> > +				       const char *label)
> > +{
> > +	int err;
> > +
> > +	err = gpio_request_one(gpio, flags, label);
> > +	if (err)
> > +		pr_err("NSA-310: can't setup GPIO%u (%s), err=%d\n",
> > +			gpio, label, err);
> > +
> > +	return err;
> > +}
> > +
> > +static void __init nsa310_gpio_init(void)
> > +{
> > +	int err;
> > +
> > +	err = nsa310_gpio_request(NSA310_GPIO_POWER_OFF, GPIOF_OUT_INIT_LOW,
> > +				  "Power Off");
> > +	if (!err)
> > +		pm_power_off = nsa310_power_off;
> 
> This doesn't smell right.

What do you mean? The wrapper for gpio_request_one() that merely 
serves as a source for debug messages? I can replace it with 
a silent version if wanted. Is there a driver for shutting down device
by some gpio pin defined in DT?

> > +	kirkwood_pcie_id(&dev, &rev);
> 
> Does this board actually use pcie?  If so, we've been looking for one to
> test on.  Just an fyi, we'll probably be hitting you up later for pcie
> DT binding testing. ;-)

If you point to a tree or patches somewhere, I am willing to test it and/or 
modify the nsa310 code to use it.
There is a NIC at end of pcie, or at least this is what the "lspci -vv" prints:

8<----8<------
00:00.0 Memory controller: Marvell Technology Group Ltd. 88F6281 [Kirkwood] ARM SoC (rev 03)
	Subsystem: Marvell Technology Group Ltd. Device 11ab
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory@<ignored> (64-bit, prefetchable)
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <256ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 unlimited
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-

00:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 03)
	Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1000 [size=256]
	Region 2: Memory at e0014000 (64-bit, prefetchable) [size=4K]
	Region 4: Memory at e0010000 (64-bit, prefetchable) [size=16K]
	[virtual] Expansion ROM@e0000000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 01
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [ac] MSI-X: Enable- Count=4 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00000800
	Capabilities: [cc] Vital Product Data
		Unknown small resource type 00, will not decode more.
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Kernel driver in use: r8169
8<----8<------

Best regards,
Tero

From: kaloz@openwrt.org (Imre Kaloz)
Date: Tue, 20 Jan 2015 11:57:11 +0100
Subject: [PATCHv2] mvebu: add Linksys WRT1900AC (Mamba) support
In-Reply-To: <20150119182113.GH32663@lunn.ch>
References: <1421687701-5667-1-git-send-email-kaloz@openwrt.org>
 <20150119182113.GH32663@lunn.ch>
Message-ID: <op.xsrcplz12s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Mon, 19 Jan 2015 19:21:13 +0100, Andrew Lunn <andrew@lunn.ch> wrote:

> Thanks for the v2. I have a few comments, and some points we will need
> to discuss.

Sure thing, thanks.

>> + *
>> + * Note: this board is shipped with a new generation boot loader that
>> + * remaps internal registers at 0xf1000000. Therefore, if earlyprintk
>> + * is used, the CONFIG_DEBUG_MVEBU_UART_ALTERNATE option should be
>
> There is a patch already queued up for this cycle:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313605.html
>
> Please can you change CONFIG_DEBUG_MVEBU_UART_ALTERNATE to
> CONFIG_DEBUG_MVEBU_UART0_ALTERNATE

Ok.

>> +	model = "Linksys WRT1900AC (Mamba)";
>> +	compatible = "linksys,mamba", "marvell,armadaxp-mv78230",
>> +		     "marvell,armadaxp", "marvell,armada-370-xp";
>
> So this is where the discussion starts. I don't like Mamba being so
> prominent. As far as i understand, Mamba is the board, not the device.
> In theory, another device could be created using the same board as a
> basis, but with different PCIe cards, etc. At that point, i would
> suggest refactoring the common parts out into a
> armada-xp-linksys-mamba.dtsi which is then included into any device
> .dts file using the Mamba board.
>
> This file describes the device. So i would prefer it to be called
> armada-xp-linksys-wrt1900ac.dts. The first compatible should be
> "linksys,wrt1900ac". Having "linksys,mamba" second is O.K.

I would like to ask for others' opinion for multiple reasons, and would  
decide in v3 based on that.

- The device is called the "mamba", the marketing name is the WRT1900AC.  
As history showed, it's perfectly possible that exactly the same device go  
on the market under a different name. The E4200v2 is the same device as  
the EA4500, with a different factory firmware. There the name of the  
device is "viper".

- OpenWrt is the only firmware/stack other than the official one and  
people already know this device as "mamba".

- Let's say the same device gets released under the same name or just the  
radios change - so no redesign takes place at all. In my opinion that  
hardly justifies adding multiple .dts files just to change the name of the  
LEDs to reflect that. I think people who want to run mainline on their  
device wouldn't be concerned about seeing a codename, but on the other  
hand we could receive patches to "correct" the marketing name in the LEDs.

>> +		internal-regs {
>
> It would be nice to document the jumper and pinout here.
>
>> +			serial at 12000 {
>> +				status = "okay";
>> +			};

Do you mean serial console pinout?


> The discussion about the i2c LED controller is still ongoing, but i
> think TI are unlikely to get a PWM based driver accepted in place of a
> LED driver. So you could include the LEDs here, and something
> unexpected happens, we can remove it.

Ok, I have that locally already, too.

>
>> +			nand at d0000 {
>> +				status = "okay";
>> +				num-cs = <1>;
>> +				marvell,nand-keep-config;
>> +				marvell,nand-enable-arbiter;
>> +				nand-on-flash-bbt;
>> +				nand-ecc-strength = <4>;
>> +				nand-ecc-step-size = <512>;
>> +
>> +				partition at 0 {
>> +					label = "u-boot";
>> +					reg = <0x0000000 0x100000>;  /* 1MB */
>> +					read-only;
>> +				};
>> +
>> +				partition at 100000 {
>> +					label = "u_env";
>> +					reg = <0x100000 0x40000>;    /* 256KB */
>> +				};
>> +
>> +				partition at 140000 {
>> +					label = "s_env";
>> +					reg = <0x140000 0x40000>;    /* 256KB */
>> +				};
>
> So there is a big gap here? 768KB of unused space before the devinfo  
> section?

See below.

>> +
>> +				partition at 900000 {
>> +					label = "devinfo";
>> +					reg = <0x900000 0x100000>;    /* 1MB */
>> +					read-only;
>> +				};
>> +
>> +				partition at a00000 {
>> +					label = "kernel1";
>> +					reg = <0xa00000 0x2800000>;    /* 3MB + rootfs1 */
>
> There are some long lines here. We try to keep to the 80 character
> rule.

I've thought that would look kinda awkward, hence I left it this way.

>
>> +				};
>
> This partition overlaps the next one? That is new to me. Seems to be
> accepted practice for OpenWRT, but i'm not aware of any mainline
> Marvell DT doing this. Comments from others welcome...

The gap and the overlapping partitions (pretty much the whole layout) are  
straight from the official firmware. The overlap is used to flash a single  
file which contains the rootfs, too.

>> +
>> +		power {
>> +			label = "mamba:white:power";
>
> Please replace this mamba with wrt1900ac. It is a property of the
> device, not the board. Another device using the mamba board may use it
> differently.
>

See above.



Imre

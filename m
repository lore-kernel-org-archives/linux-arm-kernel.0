From: agust@denx.de (Anatolij Gustschin)
Date: Fri, 14 Feb 2014 21:06:35 +0100
Subject: How to select between different display timings?
In-Reply-To: <52FE53DD.7040102@gmail.com>
References: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
 <1375966287-6784-8-git-send-email-LW@KARO-electronics.de>
 <52FE1F2D.4010102@de.bosch.com>
 <20140214150208.12417b11@ipc1.ka-ro> <52FE53DD.7040102@gmail.com>
Message-ID: <20140214210635.1561d4b6@crub>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Feb 2014 18:35:25 +0100
Dirk Behme <dirk.behme@gmail.com> wrote:
...
> > You need to set the property 'native-mode' to the phandle of the
> > display-timings entry like marked above.
> 
> Hmm, let's see if we talk about the same thing ;) Let me rephrase my 
> questions:
> 
> Using above example and booting a system with the resulting .dtb, 
> timing5 is selected at boot time, correct?

yes.

> Assuming I want to use timing1 instead: who would set when the 
> property 'native-mode' to &timing1?
> 
> Can the switch to
> 
> native-mode = <&timing1>;
> 
> only be done at compile time of the dts -> dtb? Or can this be done at 
> boot/kernel run time, too?

it could be done in U-Boot before booting the kernel. You can load
the dtb and patch the property as needed, i.e.:

U-Boot > tftp 107f0000 ${fdtfile}
U-Boot > fdt addr 107f0000
U-Boot > fdt pri /soc/aips-bus at 02000000/ldb at 020e0008/lvds-channel at 0/display-timings
display-timings {
	native-mode = <0x0000000d>;
	hsd100pxn1 {
		clock-frequency = <0x03dfd240>;
		hactive = <0x00000400>;
		vactive = <0x00000300>;
		hback-porch = <0x000000dc>;
		hfront-porch = <0x00000028>;
		vback-porch = <0x00000015>;
		vfront-porch = <0x00000007>;
		hsync-len = <0x0000003c>;
		vsync-len = <0x0000000a>;
		linux,phandle = <0x0000000d>;
		phandle = <0x0000000d>;
	};
	wvga {
		clock-frequency = <0x019bfcc0>;
		hactive = <0x00000320>;
		vactive = <0x000001e0>;
		hback-porch = <0x00000028>;
		hfront-porch = <0x0000003c>;
		vback-porch = <0x0000000a>;
		vfront-porch = <0x0000000a>;
		hsync-len = <0x00000014>;
		vsync-len = <0x0000000a>;
		hsync-active = <0x00000000>;
		vsync-active = <0x00000000>;
		de-active = <0x00000001>;
		pixelclk-active = <0x00000000>;
		linux,phandle = <0x0000000e>;
		phandle = <0x0000000e>;
	};
};

U-Boot > fdt set /soc/aips-bus at 02000000/ldb at 020e0008/lvds-channel at 0/display-timings native-mode <0x0000000e>

U-Boot > fdt list /soc/aips-bus at 02000000/ldb at 020e0008/lvds-channel at 0/display-timings/          
display-timings {
	native-mode = <0x0000000e>;
	hsd100pxn1 {
	};
	wvga {
	};
};

native-mode is referencing second timing node now.

But note that dtc could eliminate the phandles in the nodes if
these are not referenced in dts. To avoid this, the nodes could
contain a self-reference:

 timing1: wvga {
   ...
   linux,phandle = <&timing1>;
 };

> In the end, I'm looking for a way to have several timings like above 
> in the device tree, and select one at kernel boot time based on the 
> display detected. Would this be possible?

You could add a function in U-Boot to detect the display and
update the dtb before booting. This function can be called
before booting if you define CONFIG_OF_BOARD_SETUP in the
U-Boot config file for your board and provide ft_board_setup()
in your board code.

HTH,

Anatolij

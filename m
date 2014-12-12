From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 12 Dec 2014 02:15:04 +0100
Subject: __hci_cmd_sync() not suitable for nokia h4p
In-Reply-To: <20141211221306.GA2905@amd>
References: <20141209190210.GA15641@amd>
 <304050AD-DB11-4A2B-A1F7-8B1BBB5F04F0@holtmann.org>
 <20141209201328.GA18003@amd>
 <7EFD3C33-E503-4FB6-BCCF-52836080ABD6@holtmann.org>
 <20141210131519.GA14748@amd>
 <EE1A4B9D-30D5-4BD9-9A43-532619494A0C@holtmann.org>
 <20141211221306.GA2905@amd>
Message-ID: <20141212011504.GA16599@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 11, 2014 at 11:13:07PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > h4p changes uart speed again after load of the firmware, but I guess
> > > that's ok.
> 
> >  if you can do it the other way around it would result in a faster
> > init. Depending on how many patches are actually required to be
> > loaded.
> 
> IIRC driver does two speed changes, so it looks to me like someone
> already tried that (and it did not work).

maybe. maybe not. Should be easy to test it (again) and add a
comment, shouldn't it?

> > >> What needs to be done is the bring up of the device including the proper UART settings and speed and then just run the firmware downloads. All firmware files on the Nokia devices where just HCI commands with vendor specific details. Some from CSR, some from Broadcom and some from TI. You can actually decode them if you really want to. Shouldn't be that hard.
> > >> 
> > > 
> > > Speed changes at the end of firmware load, but I guess that's detail?
> > > Anyway, patch would look like this.
> > 
> > You should really look into providing hdev->setup() callback. That is normally the callback where you want to load the firmware.
> > 
> 
> I can provide setup() callback and load firmware from there.
> 
> I have created provisional device tree binding, and the driver still
> works.

I don't have time to look at the code now, but I have some comments
regarding the binding.

> Some time ago you mentioned that with the "big" issues fixed, you'd be
> willing to take it into the tree. What way forward do you see? Would
> it make sense to re-enable the driver in staging, so that "big"
> changes could be applied, followed by renames?
> 
> Thanks,
> 								Pavel
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 9e0e5a2..201f21b 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -790,9 +776,21 @@
>  };
>  
>  &uart2 {
> +        compatible = "brcm,uart,bcm2048";

This does not look correct. The uart should not be overwritten. The
current h4p driver indeed implements a driver for the serial port,
but that's a) linux specific and does not belong in the DT and b)
should probably be changed in the mainline kernel.

>  	interrupts-extended = <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart2_pins>;
> +	device {
> +		  compatible = "brcm,bcm2048";
> +		  uart = <&uart2>;

You don't need a phandle to the parent device.

> +		  reset-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>; /* want 91 */
> +		  host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* want 101 */

The host-wakeup should be mapped as irq, gpio2irq conversion
will happen ;)

> +		  bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* want 37 */

To be consistent with the n900 DTS file you should probably drop
"want " from the comments.

> +		  chip-type = <3>;

This should be set in the driver based on the compatible
value and not via DT data.

> +		  clocks = <&uart2_fck>, <&uart2_ick>;
> +		  clock-names = "fck", "ick";

These clocks you defined belong to the uart device and not to the
uart slave (bluetooth) device.

> +		  bt-sysclk = <2>;

I think this should be mapped cleanly in DT by adding a new clock
to the DTS file:

vctcxo_clock: clock  {
    compatible = "fixed-clock";
    #clock-cells = <0>;
    clock-frequency = <38400000>;
};

Then the bluetooth device can reference its clock device:

clocks = <&vctcxo_clock>;

The same clock reference should be added to the wl1251 DT node :)

> ... [code] ...

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141212/e0496be9/attachment.sig>

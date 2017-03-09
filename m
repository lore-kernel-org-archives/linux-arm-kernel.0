From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 09 Mar 2017 16:22:37 +0100
Subject: [PATCH v2 1/3] usb: orion-echi: Add support for the Armada 3700
In-Reply-To: <Pine.LNX.4.44L0.1703091006390.1912-100000@iolanthe.rowland.org>
 (Alan Stern's message of "Thu, 9 Mar 2017 10:13:19 -0500 (EST)")
References: <Pine.LNX.4.44L0.1703091006390.1912-100000@iolanthe.rowland.org>
Message-ID: <878toelbk2.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,
 
 On jeu., mars 09 2017, Alan Stern <stern@rowland.harvard.edu> wrote:

>> @@ -47,6 +47,21 @@
>>  #define USB_PHY_IVREF_CTRL	0x440
>>  #define USB_PHY_TST_GRP_CTRL	0x450
>>  
>> +#define USB_SBUSCFG		0x90
>> +#define	    USB_SBUSCFG_BAWR_SHIFT	    0x6
>> +#define	    USB_SBUSCFG_BARD_SHIFT	    0x3
>> +#define	    USB_SBUSCFG_AHBBRST_SHIFT	    0x0
>
> Shift amounts are just regular numbers.  Giving them in hex is 
> confusing because it leads people to think the bit pattern has some 
> particular significance, which it doesn't.  Which would you rather see: 
> (0x24 << 0x12) or (0x24 << 18)?

Right

>
>> +
>> +/* BAWR = BARD = 3 : Align read/write bursts packets larger than 128 bytes */
>> +#define USB_SBUSCFG_BAWR_ALIGN_128B	(0x3 << USB_SBUSCFG_BAWR_SHIFT)
>> +#define USB_SBUSCFG_BARD_ALIGN_128B	(0x3 << USB_SBUSCFG_BARD_SHIFT)
>> +/* AHBBRST = 3	   : Align AHB Burst to INCR16 (64 bytes) */
>> +#define USB_SBUSCFG_AHBBRST_INCR16	(0x3 << USB_SBUSCFG_AHBBRST_SHIFT)
>
> Besides, since these shift amounts are each used only once, it would be
> simpler (and easier to read!) to do:
>
> +#define USB_SBUSCFG_BAWR_ALIGN_128B  (0x3 << 6)
> +#define USB_SBUSCFG_BARD_ALIGN_128B  (0x3 << 3)
> +/* AHBBRST = 3          : Align AHB Burst to INCR16 (64 bytes) */
> +#define USB_SBUSCFG_AHBBRST_INCR16   (0x3 << 0)
>

I think the intent was to document the register layout. But I have no
problem following your advice.

>
>> +
>> +#define USB_SBUSCFG_DEF_VAL (USB_SBUSCFG_BAWR_ALIGN_128B	\
>> +			     | USB_SBUSCFG_BARD_ALIGN_128B	\
>> +			     | USB_SBUSCFG_AHBBRST_INCR16)
>> +
>>  #define DRIVER_DESC "EHCI orion driver"
>>  
>>  #define hcd_to_orion_priv(h) ((struct orion_ehci_hcd *)hcd_to_ehci(h)->priv)
>> @@ -151,8 +166,31 @@ ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
>>  	}
>>  }
>>  
>> +static int ehci_orion_drv_reset(struct usb_hcd *hcd)
>> +{
>> +	struct device *dev = hcd->self.controller;
>> +	int retval;
>> +
>> +	retval = ehci_setup(hcd);
>> +	if (retval)
>> +		dev_err(dev, "ehci_setup failed %d\n", retval);
>
> Was lack of this error message in the original driver a source of 
> problems?  If not, I submit that there's no good reason to add it.
>

I will remove the message and replace it by "return retval;" as
suggested below.

Thanks,

Gregory

>> +
>> +	/*
>> +	 * For SoC without hlock, need to program sbuscfg value to guarantee
>> +	 * AHB master's burst would not overrun or underrun FIFO.
>> +	 *
>> +	 * sbuscfg reg has to be set after usb controller reset, otherwise
>> +	 * the value would be override to 0.
>> +	 */
>> +	if (of_device_is_compatible(dev->of_node, "marvell,armada-3700-ehci"))
>> +		wrl(USB_SBUSCFG, USB_SBUSCFG_DEF_VAL);
>
> Do you want to do this even when retval != 0?
>
> Alan Stern

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

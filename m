From: rafal@milecki.pl (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 13 Mar 2017 22:46:00 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add support for TP-LINK Archer C5 V2
In-Reply-To: <20170313193517.GC10397@lunn.ch>
References: <20170311121453.18534-1-zajec5@gmail.com>
 <20170312171032.GK15842@lunn.ch>
 <437d898d-b0f4-a4b5-cb51-8ea88ba7a35a@milecki.pl>
 <20170313191416.GB10397@lunn.ch>
 <89081716-c0e3-236f-4291-e700dbedbd34@milecki.pl>
 <20170313193517.GC10397@lunn.ch>
Message-ID: <361a3978-d762-b252-43b9-9739ceedc128@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2017 08:35 PM, Andrew Lunn wrote:
> On Mon, Mar 13, 2017 at 08:15:27PM +0100, Rafa?? Mi??ecki wrote:
>> On 03/13/2017 08:14 PM, Andrew Lunn wrote:
>>> On Mon, Mar 13, 2017 at 07:48:26PM +0100, Rafa?? Mi??ecki wrote:
>>>> On 03/12/2017 06:10 PM, Andrew Lunn wrote:
>>>>>> +	chosen {
>>>>>> +		bootargs = "console=ttyS0,115200 earlycon";
>>>>>
>>>>> Using bootargs to pass the serial settings has been deprecated for a
>>>>> while. Please use stdout-path instead.
>>>>
>>>> I tried following patch with my SR400ac (I put Archer C5 aside for now).
>>>
>>> Hi Rafael
>>>
>>> Take a look at for example the bcm911360k.dts
>>>
>>>        aliases {
>>>                serial0 = &uart3;
>>>        };
>>>
>>>        chosen {
>>>                stdout-path = "serial0:115200n8";
>>>        };
>>>
>>> You need an alias to the serial device you want to us, and you should
>>> list the speed, parity, bits etc.
>>
>> That was actually my first try (just with s/uart3/uart0) and I got the same problem.
>
> Hi Rafael
>
> Try decompiling the generate .dtb file back to a dts and see if it
> looks correct.

I decompiled dtb, it looks OK to me, let me paste relevant part:

	chosen {
		stdout-path = "serial0:115200n8";
		bootargs = "earlycon";
	};

	aliases {
		serial0 = "/chipcommonA/serial at 0300";
	};

	memory {
		device_type = "memory";
		reg = <0x0 0x8000000 0x88000000 0x8000000>;
	};

	chipcommonA {
		compatible = "simple-bus";
		ranges = <0x0 0x18000000 0x1000>;
		#address-cells = <0x1>;
		#size-cells = <0x1>;

		serial at 0300 {
			compatible = "ns16550";
			reg = <0x300 0x100>;
			interrupts = <0x0 0x55 0x4>;
			clocks = <0x2>;
			status = "okay";
		};

		serial at 0400 {
			compatible = "ns16550";
			reg = <0x400 0x100>;
			interrupts = <0x0 0x55 0x4>;
			clocks = <0x2>;
			status = "disabled";
		};
	};

I got some warnings, but I don't think they are critical:
Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /chipcommonA has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /mpcore has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /usb2-phy has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /usb3-phy has a reg or ranges property, but no unit name

From: david@lechnology.com (David Lechner)
Date: Thu, 27 Oct 2016 10:55:42 -0500
Subject: [PATCH v6 5/5] ARM: DTS: da850: Add usb phy node
In-Reply-To: <d55f19f2-beb3-a681-a6e9-c1d2c303173c@ti.com>
References: <1477451211-31979-1-git-send-email-david@lechnology.com>
 <1477451211-31979-6-git-send-email-david@lechnology.com>
 <d55f19f2-beb3-a681-a6e9-c1d2c303173c@ti.com>
Message-ID: <7a57b179-bbe7-1412-84d4-8406981665ab@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2016 05:26 AM, Sekhar Nori wrote:
> On Wednesday 26 October 2016 08:36 AM, David Lechner wrote:
>> Add a node for the new usb phy driver.
>
> changed this to:
>
>     Add a node for usb phy device. This device
>     controls both the USB 1.1 and USB 2.0 PHYs.
>
> mainly because the node is for the device, not the driver.
>
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>
> Applied to v4.10/dt
>
> Thanks,
> Sekhar
>

I found a better way to represent this device as a child of the syscon 
node. How should we handle the change? Should I submit a new patch that 
applies on top of this one or will you drop this patch and I should send 
a new one to take it's place?

Assuming that you agree that this is better:

	cfgchip: cfgchip at 1417c {
		compatible = "ti,da830-cfgchip", "syscon", "simple-mfd";
		reg = <0x1417c 0x14>;

		usb_phy: usb-phy {
			compatible = "ti,da830-usb-phy";
			#phy-cells = <1>;
			status = "disabled";
		};
	};

Since the phy consists entirely as registers in the syscon device, we 
should make it a child of the syscon device instead of a child of the 
soc node.

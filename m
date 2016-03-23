From: david@lechnology.com (David Lechner)
Date: Wed, 23 Mar 2016 12:56:39 -0500
Subject: [PATCH v2 05/11] dt-bindings: Add bindings for phy-da8xx-usb
In-Reply-To: <56F2CD16.9060106@ti.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-6-git-send-email-david@lechnology.com>
 <56F2CD16.9060106@ti.com>
Message-ID: <56F2D8D7.5070206@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2016 12:06 PM, Sekhar Nori wrote:
> On Thursday 17 March 2016 07:56 AM, David Lechner wrote:
>> Device tree binding for new phy-da8xx-usb driver.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>
>> v2 changes: This is new patch in v2.
>>
>>
>>   .../devicetree/bindings/phy/phy-da8xx-usb.txt      | 34 ++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt
>> new file mode 100644
>> index 0000000..ed6b710
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt
>> @@ -0,0 +1,34 @@
>> +TI DaVinci DA8XX USB PHY
>> +
>> +Required properties:
>> + - compatible: must be "ti,da830-usbphy".
>> + - #phy-cells: must be 1.
>> + - reg : Address and length of the CFGCHIP2 register.
>
> I am not sure passing CFGCHIP2 register as reg property to the phy is
> future proof. At some point, we do want to move to common clock
> framework and at that point USB clocks controlled by CFGCHIP2 will be a
> separate driver needing access to the same register.
>
> So I think the CFGCHIP2 access in USB phy driver should happen through a
> syscon phandle. This needs to happen now, not later since we cannot
> break DT backward-compatibility.
>

I think using "syscon" for the CFGCHIP registers makes sense (based on 
my minimal experience). Would we want one "syscon" device node that 
includes all of the CFGCHIP registers or one each?

Something like this?

cfgchip at 1417C {
	compatible = "ti,da830-cfgchip", "syscon";
	reg = <1417C 20>;
}

or this?

cfgchip0 at 1417C {
	compatible = "ti,da830-cfgchip0", "syscon";
	reg = <1417C 4>;
}

cfgchip1 at 14180 {
	compatible = "ti,da830-cfgchip1", "syscon";
	reg = <14180 4>;
}

etc.



-or-

Would it be OK if the PHY driver registered clocks? I'm guessing this 
falls into the category of "not such a good idea".

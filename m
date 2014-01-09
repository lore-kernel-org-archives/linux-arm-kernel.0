From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 09 Jan 2014 14:26:30 +0100
Subject: [PATCH v2 2/2] ehci-platform: Add support for clks and phy passed
 through devicetree
In-Reply-To: <20140108181632.GG2941@lukather>
References: <1389198608-24339-1-git-send-email-hdegoede@redhat.com>
 <1389198608-24339-3-git-send-email-hdegoede@redhat.com>
 <20140108181632.GG2941@lukather>
Message-ID: <52CEA386.6060103@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/08/2014 07:16 PM, Maxime Ripard wrote:
> On Wed, Jan 08, 2014 at 05:30:08PM +0100, Hans de Goede wrote:
>> Currently ehci-platform is only used in combination with devicetree when used
>> with some via socs. By extending it to (optionally) get clks and a phy from
>> devicetree, and enabling / disabling those on power_on / off, it can be used
>> more generically. Specifically after this commit it can be used for the
>> ehci controller on Allwinner sunxi SoCs.
>>
>> Somehow we've ended up with 2 device-bindings documents for ehci-platform.c,
>> this patch renames and updates one to platform-ehci.txt to reflect that this
>> is a generic platform driver, and removes the other.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   .../devicetree/bindings/usb/platform-ehci.txt      |  25 ++++
>>   .../devicetree/bindings/usb/via,vt8500-ehci.txt    |  15 ---
>>   .../devicetree/bindings/usb/vt8500-ehci.txt        |  12 --
>>   drivers/usb/host/ehci-platform.c                   | 126 +++++++++++++++++----
>>   4 files changed, 131 insertions(+), 47 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/usb/platform-ehci.txt
>>   delete mode 100644 Documentation/devicetree/bindings/usb/via,vt8500-ehci.txt
>>   delete mode 100644 Documentation/devicetree/bindings/usb/vt8500-ehci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/platform-ehci.txt b/Documentation/devicetree/bindings/usb/platform-ehci.txt
>> new file mode 100644
>> index 0000000..56c478d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/platform-ehci.txt
>> @@ -0,0 +1,25 @@
>> +Generic Platform EHCI controller
>> +
>> +Required properties:
>> +- compatible : "via,vt8500-ehci" or "wm,prizm-ehci"
>> +- reg : ehci controller register range (address and length)
>> +- interrupts : ehci controller interrupt
>> +
>> +Optional properties:
>> +- clocks : a list of phandle + clock specifier pairs, one for each entry
>> +   in clock-names.
>> +- clock-names : "clk0", "clk1", ...
>> +- phys : phy
>> +- phy-names : "phy0"
>> +
>> +Example:
>> +
>> +	ehci at d8007900 {
>> +		compatible = "via,vt8500-ehci";
>> +		reg = <0xd8007900 0x200>;
>> +		interrupts = <43>;
>> +		clocks = <&usb_clk 6>, <&ahb_gates 2>;
>> +		clock-names = "clk0", "clk1";
>
> I'm really not convinced by this either. It prevents you from doing
> anything useful out of these clocks, and the only thing you can
> actually do with it is calling clk_get, and that's pretty much it.
>
> What if you some platform needs to adjust the rate of one of the two?

Then it needs its own driver. This is intended as a binding for a
*generic* driver, which is meant to cover simple straight forward
non-pci ohci cases. For more complex cases a separate driver will
need to be written.

I must say I'm becoming a bit unhappy with how the reviews of devicetree
bindings are being done. In one case it is not generic enough (ahci-sunxi).

If I then try to make it more generic in a case where that can actually
be done as the hardware is pretty straight forward, it is not specific enough.
You can simply not have both!

> Or wants to cut one but not the other for any reason?

This is another example of non generic behavior, requiring a separate
(small using the existing ohci core) platform glue driver, like the *19* we
already have.

Regards,

Hans

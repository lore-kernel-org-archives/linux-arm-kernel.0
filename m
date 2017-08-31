From: stefan.mavrodiev@gmail.com (Stefan Mavrodiev)
Date: Thu, 31 Aug 2017 08:20:18 +0300
Subject: [PATCH v2 1/2] ARM: dts: sun7i: Fix A20-OLinuXino-MICRO dts for
 LAN8710
In-Reply-To: <20170830143728.friajjequvioqjpu@flea.lan>
References: <1503901963-9457-1-git-send-email-stefan@olimex.com>
 <1503901963-9457-2-git-send-email-stefan@olimex.com>
 <20170830143728.friajjequvioqjpu@flea.lan>
Message-ID: <e7e61776-b8d7-c42f-4e9e-04da835374a9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2017 05:37 PM, Maxime Ripard wrote:
> Hi,
>
> On Mon, Aug 28, 2017 at 09:32:42AM +0300, Stefan Mavrodiev wrote:
>>  From revision J the board uses new phy chip LAN8710. Compared
>> with RTL8201, RA17 pin is TXERR. It has pullup which causes phy
>> not to work. To fix this PA17 is muxed with GMAC function. This
>> makes the pin output-low.
>>
>> This patch is compatible with earlier board revisions, since this
>> pin wasn't connected to phy.
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>>   arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>> index 0b7403e..cb1b081 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>> @@ -102,7 +102,7 @@
>>   
>>   &gmac {
>>   	pinctrl-names = "default";
>> -	pinctrl-0 = <&gmac_pins_mii_a>;
>> +	pinctrl-0 = <&gmac_pins_mii_a>,<&gmac_txerr>;
>>   	phy = <&phy1>;
>>   	phy-mode = "mii";
>>   	status = "okay";
>> @@ -229,6 +229,11 @@
>>   };
>>   
>>   &pio {
>> +	gmac_txerr: gmac_txerr at 0 {
>> +		pins = "PA17";
>> +		function = "gmac";
>> +	};
>> +
> The patch looks fine, I still have one question though.
>
> Can a PHY operate without this signal? My real question is, would it
> make sense to mux that pin for all the users, or is it an optional
> signal that each board designer can choose to use or not?
>
> Thanks!
> Maxime
>
This phy (LAN8710) cannot work without this pin. Part of the problem is in that we've replaced
without paying attention to this signal.

RTL8201 has no TXERR pin. The pin PA17 is used as reset signal and therefore is pulled up with
resistor. However on old revisions this option (there is jumper pad between SOC and PHY).

As I said, LAN8710 cannot work without this signal. In the datasheet is written:
	...
	The controller drives TXER high when a transmit error is detected.
	...

In the current variant of the dts, all data is threated as error.

So to answer you question. This is feature only on our board and highly depends on the chosen PHY.
I don't think this should be muxed for all users.



Best regards,
Stefan Mavrodiev,
Olimex Ltd.

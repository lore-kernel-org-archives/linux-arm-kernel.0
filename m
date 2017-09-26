From: net147@gmail.com (Jonathan Liu)
Date: Tue, 26 Sep 2017 23:09:59 +1000
Subject: [linux-sunxi] Re: [PATCH v2 1/2] ARM: dts: sun7i: Fix
 A20-OLinuXino-MICRO dts for LAN8710
In-Reply-To: <e7e61776-b8d7-c42f-4e9e-04da835374a9@gmail.com>
References: <1503901963-9457-1-git-send-email-stefan@olimex.com>
 <1503901963-9457-2-git-send-email-stefan@olimex.com>
 <20170830143728.friajjequvioqjpu@flea.lan>
 <e7e61776-b8d7-c42f-4e9e-04da835374a9@gmail.com>
Message-ID: <CANwerB2G1Acxn_Acf-68R=a_kchrro5vo4sQ_gNoMUUu7vYT3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 31 August 2017 at 15:20, Stefan Mavrodiev <stefan.mavrodiev@gmail.com> wrote:
> On 08/30/2017 05:37 PM, Maxime Ripard wrote:
>>
>> Hi,
>>
>> On Mon, Aug 28, 2017 at 09:32:42AM +0300, Stefan Mavrodiev wrote:
>>>
>>>  From revision J the board uses new phy chip LAN8710. Compared
>>> with RTL8201, RA17 pin is TXERR. It has pullup which causes phy
>>> not to work. To fix this PA17 is muxed with GMAC function. This
>>> makes the pin output-low.
>>>
>>> This patch is compatible with earlier board revisions, since this
>>> pin wasn't connected to phy.
>>>
>>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>>> ---
>>>   arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>>> b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>>> index 0b7403e..cb1b081 100644
>>> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>>> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>>> @@ -102,7 +102,7 @@
>>>     &gmac {
>>>         pinctrl-names = "default";
>>> -       pinctrl-0 = <&gmac_pins_mii_a>;
>>> +       pinctrl-0 = <&gmac_pins_mii_a>,<&gmac_txerr>;
>>>         phy = <&phy1>;
>>>         phy-mode = "mii";
>>>         status = "okay";
>>> @@ -229,6 +229,11 @@
>>>   };
>>>     &pio {
>>> +       gmac_txerr: gmac_txerr at 0 {
>>> +               pins = "PA17";
>>> +               function = "gmac";
>>> +       };
>>> +
>>
>> The patch looks fine, I still have one question though.
>>
>> Can a PHY operate without this signal? My real question is, would it
>> make sense to mux that pin for all the users, or is it an optional
>> signal that each board designer can choose to use or not?
>>
>> Thanks!
>> Maxime
>>
> This phy (LAN8710) cannot work without this pin. Part of the problem is in
> that we've replaced
> without paying attention to this signal.
>
> RTL8201 has no TXERR pin. The pin PA17 is used as reset signal and therefore
> is pulled up with
> resistor. However on old revisions this option (there is jumper pad between
> SOC and PHY).
>
> As I said, LAN8710 cannot work without this signal. In the datasheet is
> written:
>         ...
>         The controller drives TXER high when a transmit error is detected.
>         ...
>
> In the current variant of the dts, all data is threated as error.
>
> So to answer you question. This is feature only on our board and highly
> depends on the chosen PHY.
> I don't think this should be muxed for all users.
>
>
>
> Best regards,
> Stefan Mavrodiev,
> Olimex Ltd.

Will you be submitting a patch for U-Boot as well?

Regards,
Jonathan

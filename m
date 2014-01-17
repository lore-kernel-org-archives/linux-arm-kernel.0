From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 18 Jan 2014 01:43:31 +0800
Subject: [PATCH RFC 4/6] net: rfkill: gpio: add device tree support
In-Reply-To: <201401171747.46332.arnd@arndb.de>
References: <1389941251-32692-1-git-send-email-wens@csie.org>
 <1389941251-32692-5-git-send-email-wens@csie.org>
 <201401171747.46332.arnd@arndb.de>
Message-ID: <CAGb2v67UKiyfJbKZ_Frk3OwZupMPoA2Ck3Hj2zsRFXBQPztavg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 18, 2014 at 12:47 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 17 January 2014, Chen-Yu Tsai wrote:
>> diff --git a/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt b/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt
>> new file mode 100644
>> index 0000000..8a07ea4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt
>> @@ -0,0 +1,26 @@
>> +GPIO controlled RFKILL devices
>> +
>> +Required properties:
>> +- compatible   : Must be "rfkill-gpio".
>> +- rfkill-name  : Name of RFKILL device
>> +- rfkill-type  : Type of RFKILL device: 1 for WiFi, 2 for BlueTooth
>> +- NAME_shutdown-gpios  : GPIO phandle to shutdown control
>> +                         (phandle must be the second)
>> +- NAME_reset-gpios     : GPIO phandle to reset control
>> +
>> +NAME must match the rfkill-name property. NAME_shutdown-gpios or
>> +NAME_reset-gpios, or both, must be defined.
>> +
>
> I don't understand this part. Why do you include the name in the
> gpios property, rather than just hardcoding the property strings
> to "shutdown-gpios" and "reset-gpios"?

This quirk is a result of how gpiod_get_index implements device tree
lookup. You'll also notice that the shutdown GPIO must be the second
phandle, as the driver uses indexed lookup to support ACPI cases.
If con_id is given, it is prepended to "gpios" as the property string.
con_id is also used as the label passed to gpiod_request, which is
then shown in /sys/kernel/debug/gpio.

I can do a seperate lookup for the device tree case, with or without
fallback to platform lookup tables. Then the names can be "reset-gpio"
and "shutdown-gpio". Need to promote gpiod_request to non-static so
we can register usage of the gpio, to match non-dt code path.

Personally I prefer adding a "label" parameter to gpiod_get_index, so
we can use a different name than con_id. con_id isn't used in the ACPI
case, and is optional in platform lookup case. However device tree
lookup is dependent on this. What I see is non-uniform behavior
between the three. In my opinion this is undesirable, but I haven't
come up with a good solution yet.

About the property string, is the plural form required, even though we
only want one?

Thanks!

ChenYu

> The description of hte "rfkill-name" property seems to suggest
> that you can only have one logical RFKILL device per device node,
> so he names would not be ambiguous.
>
>         Arnd

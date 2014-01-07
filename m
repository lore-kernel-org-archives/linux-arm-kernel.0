From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 7 Jan 2014 10:09:12 +0800
Subject: [PATCH v4] ARM: prima2: move to generic reset controller driver
 framework
In-Reply-To: <201401061641.03491.arnd@arndb.de>
References: <1389003878-10094-1-git-send-email-21cnbao@gmail.com>
 <201401061641.03491.arnd@arndb.de>
Message-ID: <CAGsJ_4zE115p011hfDgzQPTUHUYk6WoQvw=vNSJP_yi=TvVkbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/6 Arnd Bergmann <arnd@arndb.de>:
> On Monday 06 January 2014, Barry Song wrote:
>> this moves to generic IP module reset framework, and make other drivers
>> use common device_reset() API.
>>
>> diff --git a/Documentation/devicetree/bindings/reset/sirf,rstc.txt b/Documentation/devicetree/bindings/reset/sirf,rstc.txt
>> new file mode 100644
>> index 0000000..0505de7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/sirf,rstc.txt
>> @@ -0,0 +1,42 @@
>> +CSR SiRFSoC Reset Controller
>> +======================================
>> +
>> +Please also refer to reset.txt in this directory for common reset
>> +controller binding usage.
>> +
>> +Required properties:
>> +- compatible: Should be "sirf,prima2-rstc" or "sirf,marco-rstc"
>> +- reg: should be register base and length as documented in the
>> +  datasheet
>> +- #reset-cells: 1, see below
>> +
>> +example:
>> +
>> +rstc: reset-controller at 88010000 {
>> +     compatible = "sirf,prima2-rstc";
>> +     reg = <0x88010000 0x1000>;
>> +     #reset-cells = <1>;
>> +};
>
> Binding looks good to me.
>
>> +void __init sirfsoc_of_rstc_init(void)
>> +{
>> +     struct device_node *np = of_find_matching_node(NULL, rstc_ids);
>> +     if (!np) {
>> +             pr_err("unable to find compatible sirf rstc node in dtb\n");
>> +             return;
>> +     }
>> +
>> +     sirfsoc_rstc_base = of_iomap(np, 0);
>> +     if (!sirfsoc_rstc_base) {
>> +             pr_err("unable to map rstc cpu registers\n");
>> +             return;
>> +     }
>> +
>> +     sirfsoc_reset_controller.of_node = np;
>> +
>> +     reset_controller_register(&sirfsoc_reset_controller);
>> +}
>> +
>
> Can't this be a regular platform device? Drivers that get the reference to
> the reset controller should respect a -EPROBE_DEFER error message if they
> get initialized in the wrong order.

Arnd, it is ok if prima2 is not a platform for automotive. here prima2
actually wants a "right" order for products.
for example, there are some local hacking to move camera for rearview
started earlier than other devices as this feature needs to be ready
as early as possible.
some earlier boot devices depend on reset module to be ready. so if we
move to regular platform driver for upstream, it still requires some
local hacking to move it earlier.

>
>         Arnd

-barry

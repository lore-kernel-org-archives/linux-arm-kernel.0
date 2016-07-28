From: mirza.krak@gmail.com (Mirza Krak)
Date: Thu, 28 Jul 2016 11:29:03 +0200
Subject: [RFC 3/6] dt/bindings: Add bindings for Tegra20/30 NOR bus driver
In-Reply-To: <20160725141544.GN21170@ulmo.ba.sec>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
 <20160725113034.GD21170@ulmo.ba.sec>
 <CALw8SCWEFVu__8Gyr5q995h+=oMQEz1VUNB=Ne7MRb0O-tZXqg@mail.gmail.com>
 <20160725141544.GN21170@ulmo.ba.sec>
Message-ID: <CALw8SCX+Sktdij7AKFtkAh3To6qA16xtZNFi4GpkzHE8256N_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-25 16:15 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> On Mon, Jul 25, 2016 at 03:16:28PM +0200, Mirza Krak wrote:
>> 2016-07-25 13:30 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> Yes, that clarifies many things. The presence of an external, address-
> based chip-select is essential information in order to describe this
> setup properly.
>
> Given that the external chip select is entirely invisible to software, I
> think a more accurate description of your setup would be:
>
>         gmi at 70090000 {
>                 ...
>
>                 /* for the chip select */
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 /*
>                  * Technically this could be used to translate the range from
>                  * 0x48000000 to 0x4fffffff into a different range, but that
>                  * no longer works because of the #address-cells. Does this
>                  * matter?
>                  */
>                 ranges;
>
>                 bus at 0 {
>                         compatible = "simple-bus";
>                         reg = <0>;
>
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>
>                         can at 48000000 {
>                                 reg = <0x48000000 0x100>;
>                                 ...
>                         };
>
>                         can at 48040000 {
>                                 reg = <0x48040000 0x100>;
>                                 ...
>                         };
>                 };
>         };
>

Finally got around to test this. Above example had some issues, or I
am doing something wrong.

First of, the address parser does not seem to like that #size-cells =
<0> when ranges are empty. Got following warning from device tree
compiler:
Warning (ranges_format): /nor at 70009000 has empty "ranges" property but
its #size-cells (0) differs from / (1)

and on boot:
[    0.399357] prom_parse: Bad cell count for /nor at 70009000/bus at 0

Got it to work if I changed to (also had to add an empty ranges prop
in bus node):

gmi at 70009000 {
    #address-cells = <1>;
    #size-cells = <1>;
    ranges;

    bus at 0,0 {
                compatible = "simple-bus";
                reg = <0 0>;
                ranges;

                #address-cells = <1>;
                #size-cells = <1>;

                can at 48000000 {
                    reg = <0x48000000 0x100>;
                    ...
                };


                can at 48040000 {
                    reg = <0x48040000 0x100>;
                    ...
                };
}

But I wonder is there something wrong with below example (which does
work), that is omitting the bus node:

gmi at 70009000 {
    #address-cells = <1>;
    #size-cells = <1>;
    ranges;

    can at 48000000 {
        reg = <0x48000000 0x100>;
        ...
    };

    can at 48040000 {
        reg = <0x48040000 0x100>;
        ...
    };
}

Just feel that I need to duplicate information if add an bus node.

Best Regards,
Mirza

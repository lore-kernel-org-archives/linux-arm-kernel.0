From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 24 Sep 2014 09:02:23 +0200
Subject: regulator node names and unit-addresses? (Re: [PATCH v2 1/5] ARM:
 shmobile: kzm9d: Remove spurious regulator base addresses)
Message-ID: <CAMuHMdVC2h4_Q+4BpV5iLbhfviimzrnfZ3+c6dqnegTAxBHw_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

(pulling in regulator people and DT list)

On Wed, Sep 24, 2014 at 3:13 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Sep 17, 2014 at 09:33:49AM +0200, Geert Uytterhoeven wrote:
>> On Wed, Sep 17, 2014 at 2:48 AM, Simon Horman
>> <horms+renesas@verge.net.au> wrote:
>> > As there is no reg property the regulator nodes should
>> > not include @...
>>
>> You missed an important part of my comment:
>>
>> "However, in the absence of a unit-address, the node name must be unique."
>>
>> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> >
>> > ---
>> > v2
>> > * First post
>> > ---
>> >  arch/arm/boot/dts/emev2-kzm9d.dts | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
>> > index 50ccd15..f27fcf0 100644
>> > --- a/arch/arm/boot/dts/emev2-kzm9d.dts
>> > +++ b/arch/arm/boot/dts/emev2-kzm9d.dts
>> > @@ -27,7 +27,7 @@
>> >                 bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
>> >         };
>> >
>> > -       reg_1p8v: regulator at 0 {
>> > +       reg_1p8v: regulator {
>> >                 compatible = "regulator-fixed";
>> >                 regulator-name = "fixed-1.8V";
>> >                 regulator-min-microvolt = <1800000>;
>> > @@ -36,7 +36,7 @@
>> >                 regulator-boot-on;
>> >         };
>> >
>> > -       reg_3p3v: regulator at 1 {
>> > +       reg_3p3v: regulator {
>> >                 compatible = "regulator-fixed";
>> >                 regulator-name = "fixed-3.3V";
>> >                 regulator-min-microvolt = <3300000>;
>>
>> Now there are two "regulator" nodes.
>>
>> Dtc will not complain, but will assume the second contains overrides for
>> first. "vddvario-supply" and "vdd33a-supply" of node "lan9220 at 20000000"
>> will both the point to the same node, and the network may not work.
>>
>> You can see this yourself running
>>
>>     dtc -I dtb -O dts arch/arm/boot/dts/emev2-kzm9d.dtb
>
> What should we call the nodes?

"regulator0" and "regulator1"?
"regulator1v8" and "regulator3v3"?

Documentation/devicetree/bindings/regulator/regulator.txt doesn't mention
node names or (presence/lack of) unit-adresses, but the examples do have
unit-addresses.

Is this another case where we don't follow the "no reg, no unit-address"
ePAPR rule?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

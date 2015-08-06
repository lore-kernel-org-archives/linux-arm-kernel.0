From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Aug 2015 18:21:58 +0200
Subject: [PATCH v4 1/6] ARM: shmobile: r8a7740 dtsi: Add L2
 cache-controller node
In-Reply-To: <55C1EC3C.9000407@arm.com>
References: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
 <1438765090-823-2-git-send-email-geert+renesas@glider.be>
 <55C1D894.8070302@arm.com>
 <CAMuHMdXdEV+41mH338bDbazzqOErDLQkBUAj2+uVX4Wupn1ABQ@mail.gmail.com>
 <55C1EC3C.9000407@arm.com>
Message-ID: <CAMuHMdVAOba0ofmoy8OH2DdY1m3XaD8iOXvXBE035=C4yK58VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Wed, Aug 5, 2015 at 12:58 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 05/08/15 11:44, Geert Uytterhoeven wrote:
>> On Wed, Aug 5, 2015 at 11:34 AM, Sudeep Holla <sudeep.holla@arm.com>
>> wrote:
>>> On 05/08/15 09:58, Geert Uytterhoeven wrote:
>>>> Add the missing L2 cache-controller node. This will allow migration to
>>>> the generic l2c OF initialization.
>>>>
>>>> The L2 cache is an ARM L2C-310 (r3p1-150rel0), of size 256 KiB (32 KiB x
>>>> 8 ways).
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>>
>>>> diff --git a/arch/arm/boot/dts/r8a7740.dtsi
>>>> b/arch/arm/boot/dts/r8a7740.dtsi
>>>> index d84714468cce18df..ddef5b1c68fa06b3 100644
>>>> --- a/arch/arm/boot/dts/r8a7740.dtsi
>>>> +++ b/arch/arm/boot/dts/r8a7740.dtsi
>>>> @@ -37,6 +37,22 @@
>>>>                        <0xc2000000 0x1000>;
>>>>          };
>>>>
>>>> +       L2: cache-controller {
>>>> +               compatible = "arm,pl310-cache";
>>>> +               reg = <0xf0100000 0x1000>;
>>>> +               interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
>>>> +               power-domains = <&pd_a3sm>;
>>>> +               arm,data-latency = <3 3 3>;
>>>> +               arm,tag-latency = <2 2 2>;
>>>> +               arm,shared-override;
>>>> +               cache-unified;
>>>> +               cache-level = <2>;
>>>> +               cache-size = <0x40000>;
>>>> +               cache-sets = <1024>;
>>>> +               cache-block-size = <32>;
>>>> +               cache-line-size = <32>;
>>>
>>> Any particular reason whey you need all this cache-* properties ? Is
>>
>> To describe the cache as good as possible.
>
> Why if you can probe it ? IMO DT is mostly useful to describe things
> that can't be probed/discovered using hardware.
>
>>> something broken on these SoCs ? We should be able to get most of these
>>> information from the SoC(reading some registers). It's good to avoid
>>> passing them via DT if they can be discovered from hardware.
>>
>> So we have all these documented properties in
>> Documentation/devicetree/bindings/arm/l2cc.txt, but they're not meant to
>> be used?
>
> No I didn't mean that, I just wanted to know if they can't be probed due
> to some hardware issue. It would avoid issues with wrong DTs especially
> if they are not so easy to upgrade.

I think it works just fine without them.

Should I drop all cache-* properties marked optional in
Documentation/devicetree/bindings/arm/l2cc.txt?
That would be cache-size, cache-sets, cache-block-size, and cache-line-size.

What about the L1 cache? I know Linux uses none of the d-cache-*
and i-cache-* properties.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

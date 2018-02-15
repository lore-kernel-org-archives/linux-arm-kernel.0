From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 15 Feb 2018 13:46:32 +0100
Subject: [PATCH 5/8] arm64: dts: renesas: r8a77995: Add LVDS support
In-Reply-To: <b8cc84ad-0a64-38f0-d8ac-ad9ae88c5912@ideasonboard.com>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
 <1518683903-10681-6-git-send-email-kbingham@kernel.org>
 <CAMuHMdVKczZpoXgSDOSEJZb59LAZtbWsopRaa8PtHDoZcFEMTQ@mail.gmail.com>
 <b8cc84ad-0a64-38f0-d8ac-ad9ae88c5912@ideasonboard.com>
Message-ID: <CAMuHMdVUQ5c3rEG7-eYCQRPK=si8OSz-o+7z8qPsSOd5y7URww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kieran,

On Thu, Feb 15, 2018 at 1:41 PM, Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
> On 15/02/18 09:07, Geert Uytterhoeven wrote:
>> On Thu, Feb 15, 2018 at 9:38 AM, Kieran Bingham <kbingham@kernel.org> wrote:
>>> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>>
>>> The r8a77995 D3 platform has 2 LVDS channels connected to the DU.
>>>
>>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> I love your patch!
>> Yet something to improve...
>>
>>> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>>> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>>> @@ -773,18 +773,70 @@
>>>                                 port at 1 {
>>>                                         reg = <1>;
>>>                                         du_out_lvds0: endpoint {
>>> +                                               remote-endpoint = <&du_out_lvds0>;
>>>                                         };
>>>                                 };
>>>
>>>                                 port at 2 {
>>>                                         reg = <2>;
>>>                                         du_out_lvds1: endpoint {
>>> +                                               remote-endpoint = <&du_out_lvds1>;
>>>                                         };
>>>                                 };
>>>                         };
>>>                 };
>>>         };
>>>
>>> +       lvds0: lvds at feb90000 {
>>> +               compatible = "renesas,lvds-r8a77995";
>>> +               reg = <0 0xfeb90000 0 0x20>;
>>> +               clocks = <&cpg CPG_MOD 727>;
>>> +               status = "disabled";
>>
>> Missing resets, power-domains
>
> Both lvds0, and lvds1 are actually the same 'module' (just different mappings
> within the same IP block).
>
> That means they will share clock, reset etc.
>
> Will specifying the resets cause one to affect the other unduly?
>
> like if one becomes un-used, will it power down? or is it refcounted, and will
> gracefully handle both device nodes from the same device?
>
> I'm already fairly sure clocks is fine for this - but it's just the reset's that
> worry me. If the reset module tries to reset lvds0 for some reason - would lvds1
> get reset as a side effect ...

Clocks handle sharing fine, they do refcounting.

For resets, there is some sharing/exclusive support, but we don't have that
much experience with resets as we don't use it that much yet (USB uses it).
So for now it's mostly about "describing the hardware".

Triggering a reset will indeed reset all modules using the same reset.
The same is true for e.g. PWM.

> Or perhaps that won't ever happen with an :
>
>                 power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>                 resets = <&cpg 727>;

The power-domains property is related to power management (in this case
clock domain only, as it's the "always-on" domain), not reset.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

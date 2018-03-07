From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 7 Mar 2018 08:47:43 +0100
Subject: [PATCH 3/5] arm64: dts: renesas: r8a7795: Add cpu
 capacity-dmips-mhz
In-Reply-To: <OSBPR01MB1800C2DBEAB2BC506BF80AB9A2D80@OSBPR01MB1800.jpnprd01.prod.outlook.com>
References: <1519697995-6061-1-git-send-email-gaku.inami.xh@renesas.com>
 <1519697995-6061-4-git-send-email-gaku.inami.xh@renesas.com>
 <CAMuHMdWswL8N3uTCcGmWSfa98_bpz7_11PDs=m+_RC--wBVu6w@mail.gmail.com>
 <OSBPR01MB1800C2DBEAB2BC506BF80AB9A2D80@OSBPR01MB1800.jpnprd01.prod.outlook.com>
Message-ID: <CAMuHMdXYZB8emmj5TdZih-VQ5SVF-F0LkBRsPPGe=XGvNDt_Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Inami-san,

On Wed, Mar 7, 2018 at 2:48 AM, Gaku Inami <gaku.inami.xh@renesas.com> wrote:
>> From: geert.uytterhoeven at gmail.com [mailto:geert.uytterhoeven at gmail.com] On Behalf Of Geert Uytterhoeven
>> Sent: Monday, March 5, 2018 7:24 PM
> [snip]
>>
>> 411 for the A53 cores sounds a bit low to me, though.
>> Documentation/devicetree/bindings/arm/cpu-capacity.txt uses 578.
>>
>> Perhaps you already took into account the maximum clock frequencies?
>> According to the binding document, you should not do that (cfr.
>> "final capacities are 1024 for cluster0 and 446 for cluster1" in the
>> bindings doc).
>
> Thanks for your review.
>
> I set 411 for CA53 based on dhrystone measurement and current implementation.
>
> The average in 10 times of measurement as follows:
>
>   cpu   max-freq   dhrystone
>   ---------------------------------
>   A57   1500 MHz  15532585 lps/s
>   A53   1200 MHz   6241541 lps/s
>
> With the value of CA57 is scaled at 1024, I end up with 411 for CA53.
> However, since cpufreq is not available on renesas-devel-20180212-v4.16-rc1,
> the final capacity is set by directly using capacity-dmips-mhz in dt as below.

Documentation/devicetree/bindings/arm/cpu-capacity.txt:

"capacity-dmips-mhz is an optional cpu node [1] property: u32 value
 representing CPU capacity expressed in normalized DMIPS/MHz. At boot time, the
 maximum frequency available to the cpu is then used to calculate the capacity
 value internally used by the kernel."

IIUIC, you should thus not use 15532585 and 6241541 directly, but
scale them to the frequency.

So the formula for CA53 becomes:

1024 / (15532585 / 1500) * (6241541 / 1200) = 514

> Considering cpufreq is available later, is it better to set the value(514)
> for CA53 scaled by different maximum frequencies?

DT describes the hardware, not software limitations, so IMHO 514 is the correct
value.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

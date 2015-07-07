From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Jul 2015 16:58:21 +0200
Subject: [PATCH/RFC 06/11] ARM: shmobile: r8a7790: Link CPG to RST using
 "renesas, modemr"
In-Reply-To: <3792169.nKlDE6xfl4@avalon>
References: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
 <1436278217-20522-7-git-send-email-geert+renesas@glider.be>
 <3792169.nKlDE6xfl4@avalon>
Message-ID: <CAMuHMdWCXFbBAPS46d7+3o=FiLLzVacdiTiJq09tCHSCQPUfxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Jul 7, 2015 at 4:23 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 07 July 2015 16:10:12 Geert Uytterhoeven wrote:
>> Add a link from the Clock Pulse Generator node to the Reset Controller
>> node, so the CPG can read the Mode Monitoring Register (MODEMR) to
>> obtain the MD pin values.x
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  arch/arm/boot/dts/r8a7790.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
>> index 08067ae177643b8f..4ee5523fc3e13e12 100644
>> --- a/arch/arm/boot/dts/r8a7790.dtsi
>> +++ b/arch/arm/boot/dts/r8a7790.dtsi
>> @@ -1115,6 +1115,7 @@
>>                                            "lb", "qspi", "sdh", "sd0", "sd1",
>>                                            "z", "rcan", "adsp";
>>                       #power-domain-cells = <0>;
>> +                     renesas,modemr = <&rst 0x60>;
>
> I have mixed feelings about this as I don't think it really describes the
> hardware.

>From the R-Car Gen2 manual:

8. Reset (RST)
8.1 Features
The following functions are implemented by RST.
[...]
Latching of the levels on mode pins when PRESET# is negated
Mode monitoring register

7. Clock Pulse Generator (CPG)
7.2 Input/Output Pins
Table 7.1 lists the CPG pin configuration.
Table 7.1 Pin Configuration and Functions of CPG
Pin Name Function I/O Description
[...]
MD0 Mode 0 ...

Hence there definitely is a link between the (latched) values in the RST module
and CPG configuration. This link is expressed using the "renesas,modemr"
property, where the phandle provides the link to the RST block, and the
register offset provides a way for software to read the configuration.

> Wouldn't it make sense to instead add a standard kernel API to retrieve the
> boot mode value ? It seems to be a pretty common feature of SoCs across all
> vendors.

What format would the boot mode value be in? One u32 word, an array
of u32s?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

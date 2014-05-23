From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 May 2014 08:47:46 +0200
Subject: [PATCH v3] clk: shmobile: Add R8A7740-specific clock support
In-Reply-To: <93388596.mpU9e50d0D@avalon>
References: <1400682086-5705-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1768296.AYVfH6xHtk@avalon>
 <CAMuHMdUNpgn1ciHsvqWtEyn0RugxQTaCV+ki=S=5hUbmCjA6tg@mail.gmail.com>
 <93388596.mpU9e50d0D@avalon>
Message-ID: <CAMuHMdW6=Axo8s2Jy9cdBkLczDc41Tk0JnORpv4h3oaO3kC13Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Fri, May 23, 2014 at 12:42 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 21 May 2014 17:50:35 Geert Uytterhoeven wrote:
>> On Wed, May 21, 2014 at 5:41 PM, Laurent Pinchart wrote:
>> >> +cpg_clocks: cpg_clocks at e6150000 {
>> >> +        compatible = "renesas,r8a7740-cpg-clocks";
>> >> +        reg = <0xe6150000 0x10000>;
>> >
>> > This range covers the MSTP registers. Unlike other Renesas SoCs with CCF
>> > support in mainline, the MSTP registers are in the middle of the CPG
>> > address space here, which is quite problematic.
>>
>> This is also the case for R-Car Gen2?!?
>>
>>                 /* Special CPG clocks */
>>                 cpg_clocks: cpg_clocks at e6150000 {
>>                         compatible = "renesas,r8a7791-cpg-clocks",
>>                                      "renesas,rcar-gen2-cpg-clocks";
>>                         reg = <0 0xe6150000 0 0x1000>;
>>
>>                 mstp0_clks: mstp0_clks at e6150130 {
>>                         compatible = "renesas,r8a7791-mstp-clocks",
>> "renesas,cpg-mstp-clocks";
>>                         reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
>
> Indeed :-/ It looks like we're just lucky that of_iomap() doesn't request the
> memory resource.
>
> Do you think it would make sense to move the MSTP nodes inside the CPG node to
> better describe the hardware, and avoid future breakages if of_iomap() starts
> calling request_resource() tomorrow ?

That indeed makes sense.

In general (not limited to r8a7740), I think we should move a few more nodes.
Currently we have almost all device nodes at the top level, while they should be
under a bus node. Or in a tree of bus nodes, matching the block diagram
in the datasheet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus TorvaldsH

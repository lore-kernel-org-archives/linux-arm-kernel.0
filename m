From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 1 Apr 2015 14:13:12 +0200
Subject: [PATCH/RFC 1/5] clk: shmobile: rcar-gen2: Add CPG Clock Domain
 support
In-Reply-To: <3861934.bVCAbQmBJW@avalon>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
 <1426708017-28885-2-git-send-email-geert+renesas@glider.be>
 <3861934.bVCAbQmBJW@avalon>
Message-ID: <CAMuHMdWuVdOgk6RAzoUtskC3pzz3xs6HmGf5RyrAa3Rs-y56uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Mar 31, 2015 at 1:53 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 18 March 2015 20:46:53 Geert Uytterhoeven wrote:
>> Add Clock Domain support to the R-Car Gen2 Clock Pulse Generator (CPG)
>> driver using the generic PM Domain.  This allows to power-manage the
>> module clocks of SoC devices that are part of the CPG Clock Domain using
>> Runtime PM, or for system suspend/resume.
>>
>> SoC devices that are part of the CPG Clock Domain and can be
>> power-managed through their primary clock should be tagged in DT with a
>> proper "power-domains" property.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> There's one thing that bothers me: the implementation is tied to the CPG
> driver, but the code is quite generic. That feels a bit wrong, it would be
> nice to come up with a generic implementation. On the other hand, the
> platform-dependent part is the list of clocks to manage, specified implicitly
> through the "pm_clk_add(dev, NULL)" call. That list needs to be specified
> somewhere, and adding it to the CPG driver is likely the best solution we can
> have at the moment.

This clock management code is identical to the one in pm-rmobile.c.
We may consolidate in the future, if we have more PM Domain support (e.g.
for R-Car Gen2 SYSC). Let's see...

> I'm slightly worried that adding the power-domains property to the DT node
> will introduce backward compatibility issues if we later switch to a different
> way to specify the clocks to manage automatically. I have no specific example
> though.

Specifying the clocks is indeed the hard part. I use the primary clocks, as
that is compatible with what we did in the past in drivers/sh/pm_runtime.c.
I thought about using a special clock name instead, but that may conflict
with an existing driver-specific DT binding for clk-names, and may cause
problems if you have to specify the same clock twice with different clk-names.

> For those reasons,
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

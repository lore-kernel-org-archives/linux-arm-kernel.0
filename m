From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Dec 2011 11:40:43 +0000
Subject: [RFC PATCH] ARM: Fix the bug in dcache flush all API.
In-Reply-To: <20111216112640.GD30477@mudshark.cambridge.arm.com>
References: <1324026157-32628-1-git-send-email-r.sricharan@ti.com>
 <20111216103830.GA30477@mudshark.cambridge.arm.com>
 <CAJ7qFScn07xH2t_PSH2jSPG+4NLed7sptWy=UV8Whv=hKgdLRA@mail.gmail.com>
 <20111216105707.GC30477@mudshark.cambridge.arm.com>
 <20111216112640.GD30477@mudshark.cambridge.arm.com>
Message-ID: <20111216114043.GE30477@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 11:26:40AM +0000, Will Deacon wrote:
> So on a second look, I'm failing to see the problem you're describing. The
> thing that I reckon needs changing is this:
> 
> 
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index 07c4bc8..5ca3503 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -58,7 +58,7 @@ loop1:
>         isb                                     @ isb to sych the new cssr&csidr
>         mrc     p15, 1, r1, c0, c0, 0           @ read the new csidr
>         and     r2, r1, #7                      @ extract the length of the cache lines
> -       add     r2, r2, #4                      @ add 4 (line length offset)
> +       add     r2, r2, #2                      @ add 2 (line length offset)
>         ldr     r4, =0x3ff
>         ands    r4, r4, r1, lsr #3              @ find maximum number on the way size
>         clz     r5, r4                          @ find bit position of way size increment

Actually, this is alright as well. We have to do a conversion from words to
bytes so we just add 2 to the power.

Maybe the only thing that needs changing is the comments :)

Will

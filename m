From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 6 Feb 2018 09:20:43 +0100
Subject: [PATCH 0/4] tree-wide: fix comparison to bitshift when dealing
 with a mask
In-Reply-To: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
References: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
Message-ID: <CAMuHMdWnV17DCxr71k6n3w+5jPtQmeuPugr58xadq9U_qchJnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Feb 5, 2018 at 9:09 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> In one Renesas driver, I found a typo which turned an intended bit shift ('<<')
> into a comparison ('<'). Because this is a subtle issue, I looked tree wide for
> similar patterns. This small patch series is the outcome.
>
> Buildbot and checkpatch are happy. Only compile-tested. To be applied
> individually per sub-system, I think. I'd think only the net: amd: patch needs
> to be conisdered for stable, but I leave this to people who actually know this
> driver.
>
> CCing Dan. Maybe he has an idea how to add a test to smatch? In my setup, only
> cppcheck reported a 'coding style' issue with a low prio.

I found two more using "git grep 'define.*0x[0-9a-f]* < '":

drivers/net/can/m_can/m_can.c:#define RXFC_FWM_MASK     (0x7f < RXFC_FWM_SHIFT)
drivers/usb/gadget/udc/goku_udc.h:#define INT_EPnNAK(n)
(0x00100 < (n))         /* 0 < n < 4 */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

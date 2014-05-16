From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 16 May 2014 09:17:03 +0200
Subject: [PATCH/RFC] ARM: shmobile: Enable PM_RUNTIME in defconfig
In-Reply-To: <20140516020549.GB18137@verge.net.au>
References: <1400198682-7666-1-git-send-email-horms+renesas@verge.net.au>
 <20140516020549.GB18137@verge.net.au>
Message-ID: <CAMuHMdVEowWbMY+L1TuC4xxYvtGZiH5qYOjmd7-rt1e_=xEz1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, May 16, 2014 at 4:05 AM, Simon Horman <horms@verge.net.au> wrote:
> I realise this change was your idea but I'd like to confirm some details.
>
> My assumption is that it requires
>
> [PATCH v4] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI
>
> Is that indeed required?
> Are there other dependencies that are not in the next branch
> of my renesas tree?

Your assumption is wrong. The aforementioned patch is always needed in
the multi-platform case.

Please let me clarify:
drivers/sh/pm_runtime.c registers a bus notifier for platform devices, which
registers the default clock for automatic clock management by the PM core.
If CONFIG_PM_RUNTIME=y, the clock will be managed dynamically, based
on runtime requirements.
If CONFIG_PM_RUNTIME=n, the clock will be enabled at registration time.

So even if CONFIG_PM_RUNTIME=n, you need this patch, else the affected
clocks won't be enabled (if not already enabled by reset state or the boot
loader).

Note that some drivers (e.g. sh-sci) will still work fine without
drivers/sh/pm_runtime.c, as they manage their clocks themselves.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

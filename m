From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 11 Sep 2014 10:46:02 +0200
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC DT Updates for
 v3.18
In-Reply-To: <2746360.e5Qbnl0Vc0@wuerfel>
References: <cover.1410396013.git.horms+renesas@verge.net.au>
 <2746360.e5Qbnl0Vc0@wuerfel>
Message-ID: <CAMuHMdU30XE8A55m++W=Rf=0fVu3s07J=ki10bEuuDN4bgxqeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Sep 11, 2014 at 10:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> There is one new warning I got in the for-next branch after the last round
> of pull requests, in mackerel_defconfig:
>
> arch/arm/mach-shmobile/pm-sh7372.c:116:33: warning: 'sh7372_pm_domains' defined but not used [-Wunused-variable]
>  static struct rmobile_pm_domain sh7372_pm_domains[] = {
>                                  ^
>
> I haven't looked at it in detail, can you find out what caused it and
> send a fix with your next round?

That's due to sh7372_init_pm_domains() being protected by #ifdef CONFIG_PM,
while rmobile_init_domains() is a dummy macro if !CONFIG_PM_RMOBILE.

I think the first #ifdef should also test for CONFIG_PM_RMOBILE, to be
consistent.

However, I don't see the warning with my current tree, nor with next-20140910,
as both are selected with mackerel_defconfig, due to:

 config ARCH_RMOBILE
        bool
        select PM_RMOBILE if PM && !ARCH_SHMOBILE_MULTI

Perhaps this change hadn't trickled from Simon's tree into your tree, due
to following a different merge path?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

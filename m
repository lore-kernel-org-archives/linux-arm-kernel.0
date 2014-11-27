From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 27 Nov 2014 12:06:30 -0500 (EST)
Subject: [PATCH] ARM: exynos_defconfig: disable CONFIG_EXYNOS5420_MCPM;
 not stable
In-Reply-To: <CAM4voan5=UY=rp+5KPDGjN=RszBB5miCLDFukUXQ-3F6EN1HLw@mail.gmail.com>
References: <1414796382-5447-1-git-send-email-khilman@kernel.org>
 <000e01cffb39$5ef0a2d0$1cd1e870$@kernel.org>
 <7hegtaq26c.fsf@deeprootsystems.com>
 <CAMAWPa-mLAFL7v8hHA5R-eBzpMFK-E-xcvjoV8Bn6tTwgP53Uw@mail.gmail.com>
 <CAOesGMhvTDN4J6AdUDHKV0Sp4NT6a4QEMUDWOayQqhhD+C4acw@mail.gmail.com>
 <CAMAWPa-sz5jT9izEONVZR2Z4mzuivKaNHSgyR+eP13tWZ84hYw@mail.gmail.com>
 <CAOesGMgSkJ8xkBgN7OpuDzT=ehaAd6kvbx5_tC50x78pvpkTwg@mail.gmail.com>
 <CAOesGMh-7md4PdQX1Wvk0jO+87j+fxSvBnVD_osjNd2zQ4L43w@mail.gmail.com>
 <044101d00852$3f421420$bdc63c60$@kernel.org>
 <CAMAWPa-qk0DEmPNz5LZgJq9AuGhRxuY00XwxtEikt_vh-iozVg@mail.gmail.com>
 <CAM4voa==Ram0xXTL=SnKktyRt7VFphQxBJgcf9Yi9Zio0QctHw@mail.gmail.com>
 <7hvbm2ixmo.fsf@deeprootsystems.com>
 <CAM4voa=budowQ+vnCAQhWj95Hx+yBnRAaDrFrjkQa2ubjrRwUQ@mail.gmail.com>
 <7hmw7dg81l.fsf@deeprootsystems.com>
 <alpine.LFD.2.11.1411261314310.11690@knanqh.ubzr>
 <CAM4voan5=UY=rp+5KPDGjN=RszBB5miCLDFukUXQ-3F6EN1HLw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1411271204570.11690@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Nov 2014, Abhilash Kesavan wrote:

> Hi Kevin,
> 
> On Thu, Nov 27, 2014 at 12:11 AM, Nicolas Pitre
> <nicolas.pitre@linaro.org> wrote:
> > On Wed, 26 Nov 2014, Kevin Hilman wrote:
> >
> >> Abhilash Kesavan <kesavan.abhilash@gmail.com> writes:
> >>
> >> > Hi Kevin,
> >> >
> >> > On Wed, Nov 26, 2014 at 6:30 AM, Kevin Hilman <khilman@kernel.org> wrote:
> >> >> [...]
> >> >>
> >> >> More specifically, with only the loopback call to turn off CCI commented
> >> >> out, the imprecise aborts go away.
> >> >
> >> > I can't see how enabling snoops for the boot cluster is causing these
> >> > aborts. Perhaps as Krzysztof commented it has something to do with the
> >> > secure firmware/tz software on these boards ? Other than there does
> >> > not appear to be any difference between the working/non-working
> >> > setups.
> >>
> >> Perhaps the secure firmware is preventing the CCI to be enabled by the
> >> kernel, and that is causing the imprecise abort?
> >
> > That is well possible.
> >
> > Now...... if the bootloader/firmware does not let Linux deal with both
> > the CCI and caches then MCPM simply has no more purpose for this board.
> > The whole point of MCPM is actually to handle the CCI properly and the
> > most efficient way despite all the possible races and opportunities for
> > memory corruptions. And yes, this is a complex task.
> >
> > So there is actually two choices: the firmware let Linux take care of it
> > via the MCPM layer (easy), or the firmware has to implement it all
> > _properly_ (hard) behind an interface such as PSCI, at which point MCPM
> > should be configured out.
> >
> > If the firmware does not let Linux interact with the CCI _and_ does not
> > implement full MCPM-like services then the platform is broken and only a
> > firmware upgrade could fix that.  It might still be possible to boot all
> > CPUs through other means, but power management would then be severely
> > limited.
> 
> How about restricting the mcpm initialization to only known working
> boards like chromebooks and smdk. This would be better than disabling
> the config altogether from exynos_defconfig. The non-working boards
> would then default to platsmp. Assuming that the firmware handles all
> CCI/cache activities then platsmp may work for secondary core boot-up
> ?
> 
> Can you please apply the below diff and test the non-working boards
> with CONFIG_EXYNOS5420_MCPM enabled.

I'd much prefer if the CCI is non accessible on some board that the 
device tree file for that board be modified instead by marking the CCI 
as unavailable.


> 
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c
> b/arch/arm/mach-exynos/mcpm-exynos.c
> index b0d3c2e..34d77bb 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -316,8 +316,9 @@ static void __init exynos_cache_off(void)
>  }
> 
>  static const struct of_device_id exynos_dt_mcpm_match[] = {
> -       { .compatible = "samsung,exynos5420" },
> -       { .compatible = "samsung,exynos5800" },
> +       { .compatible = "samsung,smdk5420" },
> +       { .compatible = "google,pi" },
> +       { .compatible = "google,pit" },
>         {},
>  };
> 
> On a different note, I did not see any mainline support for Odroid
> Xu3, are you testing this board with a non-mainline kernel ?
> 
> Regards,
> Abhilash
> >
> >
> >
> > Nicolas
> 
> 

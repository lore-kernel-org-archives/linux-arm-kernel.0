From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 10:24:17 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable shmobile platforms
In-Reply-To: <CAMuHMdXXUrq3tsiaEym_uuoiYXNt66c5sm+1mSAfX6cHgMbEOQ@mail.gmail.com>
References: <1409234429-1916-1-git-send-email-geert+renesas@glider.be>
 <3598124.ze8sbSR9ui@wuerfel>
 <CAMuHMdXXUrq3tsiaEym_uuoiYXNt66c5sm+1mSAfX6cHgMbEOQ@mail.gmail.com>
Message-ID: <3848521.UcIm3L3emN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 30 August 2014 11:32:30 Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Fri, Aug 29, 2014 at 10:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > A related problem that I think is more significant is that
> > some platforms 'select' a particular driver and when you
> > disable the platform, that driver is suddenly removed from the
> > defconfig for all other platforms as well. This has bitten
> > us a few times in the past, and I'd really like to fix those
> > cases first.
> 
> Indeed. "select" is evil, and has a devastating effect on minimal
> defconfigs (lots of churn and nasty surprises like the one you mentioned).
> 
> So it actually makes more sense to derive multi_v7_defconfig
> from the individual platform's defconfigs.
> I also have a script for that, which I wrote to create m68k's multi_defconfig
> a long time ago:
> https://github.com/geertu/linux-scripts/blob/master/linux-config-merge

This looks like a very interesting method, and is similar to the "Kconfig
fragments" that a lot of people are using.

However I'm not sure we can replace the multi_v7_defconfig with it, the
main problem I see with that is that it can get unpredictable when
changes are done to one of the inputs. I'd rather keep the multi_v7_defconfig
in some form (possibly extend it to v6) and use fragments for some specialized
variation (v6-smp, v7, v7-lpae, ...).
 
> In the long run, I think creating defconfigs from DTS is the way to go.
> Extracting dependencies from the build system (both Makefile and
> the myriad of complex dependencies in Kconfig) are the biggest hurdles to
> solve.

Yes, this looks like very interesting work. We won't be able to use it
for all cases, in particular for distro kernels that are meant to run
on a large number of machines that don't all have dts files in the kernel,
but it should simplify the workflow for a lot of embedded use cases.

	Arnd

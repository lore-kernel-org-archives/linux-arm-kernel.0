From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 22:14:57 +0100
Subject: [PATCH 4/9] ARM: add CONFIG_PHYS_OFFSET default values
In-Reply-To: <20160219180725.GB19428@n2100.arm.linux.org.uk>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.20.1602191215140.13632@knanqh.ubzr>
 <20160219180725.GB19428@n2100.arm.linux.org.uk>
Message-ID: <3612170.sHbTTc5Sc9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 February 2016 18:07:25 Russell King - ARM Linux wrote:
> On Fri, Feb 19, 2016 at 12:31:02PM -0500, Nicolas Pitre wrote:
> > Yet, the only reason for a default here is to accommodate automatic 
> > build tests like randconfig, right?
> > 
> > If so then this should be "fixed" by having the config system provide 
> > built-in symbols that can be tested from kconfig files.  This way you 
> > could terminate the above list with:
> > 
> > 	default 0x00000000 if RANDCONFIG || ALLYESCONFIG
> > 
> > or the like.
> 
> I've suggested in the past that we have kconf read a seed file for
> these configurations.  kconf already has most of the required support
> for this, we just need to teach it where to read it from.  Maybe
> something like this.
> 
>  arch/arm/allrandom.config |  1 +
>  scripts/kconfig/conf.c    | 61 ++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 51 insertions(+), 11 deletions(-)

Interesting, I had never noticed that we had the infrastructure to have
separate presets for allno/allmod/allyes/...config by file name,
aside from the ${KCONFIG_ALLCONFIG}, I think your extension to make
it architecture specific is a very good idea, and it can solve a
couple of other problems as well, such as new toolchains barfing
on -march=armv3 and OABI support.

There is a bit of overlap with the Kconfig fragments, which are
defined in a similar way:

> diff --git a/arch/arm/allrandom.config b/arch/arm/allrandom.config
> index e69de29bb2d1..5a70ef5926f5 100644
> --- a/arch/arm/allrandom.config
> +++ b/arch/arm/allrandom.config
> @@ -0,0 +1 @@
> +CONFIG_PHYS_OFFSET=0

With the recently added Kconfig fragments support, you could do
(almost) the same thing by specifying

make randconfig allrandom.config

"almost", because

- The fragments use a search path including kernel/config/*.config
  and arch/*/configs/*.config, rather than arch/*/*.config
  I would prefer using the search path we have for the fragments now.

- The current implementation does not start out with the symbols
  from the fragment but instead applies the fragments one by one
  after the initial config, so the example above is the same as

	make randconfig
	make allrandom.config

  which does not have the same results. For this, I think starting
  with the fragment makes more sense, but that unfortunately requires
  changing the command line interface if we want to generalize it.

	Arnd

From: joel@jms.id.au (Joel Stanley)
Date: Fri, 22 Jul 2016 01:40:31 +0930
Subject: [PATCH] ARM: dont specify STACKPROTECTOR in defconfigs
In-Reply-To: <20160721151134.5803-1-paul.gortmaker@windriver.com>
References: <20160721151134.5803-1-paul.gortmaker@windriver.com>
Message-ID: <CACPK8XfRFPxr6NbaMBztNCrOnGUkFaAiE+op+Mxyqk7de4_2ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Fri, Jul 22, 2016 at 12:41 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> Note the output from the following:
>
>    $ git grep STACKPROTECTOR arch/arm/configs/
>    arch/arm/configs/aspeed_g4_defconfig:CONFIG_CC_STACKPROTECTOR_STRONG=y
>    arch/arm/configs/aspeed_g5_defconfig:CONFIG_CC_STACKPROTECTOR_STRONG=y
>    arch/arm/configs/bcm2835_defconfig:CONFIG_CC_STACKPROTECTOR_REGULAR=y
>    $
>
> Only three defconfigs specify a value.  And two of the three ask for
> the strong variant, which isn't supported by older toolchains.
>
> Due to the nature of ARM having more platform specific code than say
> x86, the allyesconfig and allmodconfig aren't as effective for build
> coverage.  So, in addition, I like to use a trivial script to walk all
> the defconfigs and build each one.
>
> However I will get false positives on unsupported stackprotector values
> with an older toolchain like gcc-4.6.3.  As in this instance I am just
> using the compiler as a glorified syntax checker on a machine where I
> build a bunch of other arch for the same reason, there is no real
> motivation to get a newer toolchain for improved optimization etc.

I'm happy to remove it from the Aspeed configurations as I'm not sure
why it was enabled in the first place.

However, I do not agree with the reasoning here. If you're building to
check syntax a modern GCC will certainly pick up on more than one from
four years ago.

> Since there are only three of them, and there is nothing about these
> settings that are board/platform specific, I propose we just eliminate
> the three existing instances and take the default.

This makes sense to me.

Acked-by: Joel Stanley <joel@jms.id.au>

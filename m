From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Dec 2012 16:42:05 -0800
Subject: [PATCH] ARM: EXYNOS: Fix compile error in dev-audio.c
In-Reply-To: <000701cdd9d3$3b6a6e10$b23f4a30$%choi@samsung.com>
References: <000701cdd9d3$3b6a6e10$b23f4a30$%choi@samsung.com>
Message-ID: <CAOesGMhgvsM7Fk-YpihjYM6h+xqK-ejBzPKEDypfdKEmHp6ZJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 12:15 AM, Jonghwan Choi <jhbird.choi@samsung.com> wrote:
> arch/arm/mach-exynos/dev-audio.c:58:4: error: unknown field 'src_clk'
> specified in initializer
> arch/arm/mach-exynos/dev-audio.c:58:4: warning: initialization makes integer
> from pointer without a cast [enabled by default]
> arch/arm/mach-exynos/dev-audio.c:58:4: warning: (near initialization for
> 'i2sv5_pdata.type.i2s.idma_addr') [enabled by default]
> arch/arm/mach-exynos/dev-audio.c:91:4: error: unknown field 'src_clk'
> specified in initializer
> arch/arm/mach-exynos/dev-audio.c:91:4: warning: initialization makes integer
> from pointer without a cast [enabled by default]
> arch/arm/mach-exynos/dev-audio.c:91:4: warning: (near initialization for
> 'i2sv3_pdata.type.i2s.idma_addr') [enabled by default]
>
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>

This only fixes one of many build errors caused by the i2s change:

      1 arch/arm/mach-s3c64xx/dev-audio.c:113:4: warning:
initialization makes integer from pointer without a cast [enabled by
default]
      1 arch/arm/mach-s3c64xx/dev-audio.c:113:4: warning: (near
initialization for 'i2sv4_pdata.type.i2s.idma_addr') [enabled by
default]
      1 arch/arm/mach-s3c64xx/dev-audio.c:69:4: warning:
initialization makes integer from pointer without a cast [enabled by
default]
      1 arch/arm/mach-s3c64xx/dev-audio.c:69:4: warning: (near
initialization for 'i2sv3_pdata.type.i2s.quirks') [enabled by default]
      1 arch/arm/mach-s5p64x0/dev-audio.c:115:4: warning:
initialization makes integer from pointer without a cast [enabled by
default]
      1 arch/arm/mach-s5p64x0/dev-audio.c:115:4: warning: (near
initialization for 's5p6450_i2s_pdata.type.i2s.quirks') [enabled by
default]
      1 arch/arm/mach-s5p64x0/dev-audio.c:48:4: warning:
initialization makes integer from pointer without a cast [enabled by
default]
      1 arch/arm/mach-s5p64x0/dev-audio.c:48:4: warning: (near
initialization for 's5p6440_i2s_pdata.type.i2s.idma_addr') [enabled by
default]
      1 arch/arm/mach-s5p64x0/dev-audio.c:96:4: warning:
initialization makes integer from pointer without a cast [enabled by
default]
      1 arch/arm/mach-s5p64x0/dev-audio.c:96:4: warning: (near
initialization for 's5p6450_i2s0_pdata.type.i2s.idma_addr') [enabled
by default]
      1 arch/arm/mach-s5pc100/dev-audio.c:53:4: warning:
initialization makes integer from pointer without a cast [enabled by
default]
      1 arch/arm/mach-s5pc100/dev-audio.c:53:4: warning: (near
initialization for 'i2sv5_pdata.type.i2s.idma_addr') [enabled by
default]
      1 arch/arm/mach-s5pc100/dev-audio.c:84:4: warning:
initialization makes integer from pointer without a cast [enabled by
default]
      1 arch/arm/mach-s5pc100/dev-audio.c:84:4: warning: (near
initialization for 'i2sv3_pdata.type.i2s.quirks') [enabled by default]
      1 arch/arm/mach-s5pv210/dev-audio.c:55:4: warning:
initialization makes integer from pointer without a cast [enabled by
default]
      1 arch/arm/mach-s5pv210/dev-audio.c:55:4: warning: (near
initialization for 'i2sv5_pdata.type.i2s.idma_addr') [enabled by
default]
      1 arch/arm/mach-s5pv210/dev-audio.c:87:4: warning:
initialization makes integer from pointer without a cast [enabled by
default]
      1 arch/arm/mach-s5pv210/dev-audio.c:87:4: warning: (near
initialization for 'i2sv3_pdata.type.i2s.quirks') [enabled by default]


Looks like the breakage was caused by the following commit:

commit 1974a042dd15f1f007a3a1a2dd7a23ca0e42c01d
Author:     Padmavathi Venna <padma.v@samsung.com>
AuthorDate: Wed Nov 28 16:17:48 2012 +0530
Commit:     Mark Brown <broonie@opensource.wolfsonmicro.com>
CommitDate: Wed Nov 28 19:18:00 2012 +0000

    ASoC: Samsung: Get I2S src_clk from clock alias id.

Padmavathi, you can't send out code that breaks all Samsung platforms
like this, even if there are patches out there that fixes it. Changes
have to be bisectable, which means that you can't break and unbreak
the build, least of all if you merge through different maintainers.
And you need to tell the other maintainer that there are dependent
patches, you just sent the above patch to Mark without any such
information.

Kukjin, I see that Padmavathi has posted a V3 series of patches to
remove all this from the dev-audio files on November 23. Are you ok
with us picking them up and sending ASAP?


-Olof

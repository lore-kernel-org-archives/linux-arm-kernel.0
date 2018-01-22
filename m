From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 22 Jan 2018 12:14:53 +0100
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v6_00=2F41=5D_ARM=3A_davinci=3A_convert_to_common?=
 =?UTF-8?Q?_clock_framework=E2=80=8B?=
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <CAMRc=MexJTMiD=URw1bv-qfGaTntZRXgfsSb_beYGkvO+LrpgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-20 18:13 GMT+01:00 David Lechner <david@lechnology.com>:
> This series converts mach-davinci to use the common clock framework.
>
> The series works like this, the first 19 patches create new clock drivers
> using the common clock framework. There are basically 3 groups of clocks -
> PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each have
> unique init data, which is the reason for so many patches.
>
> Then, starting with "ARM: da830: add new clock init using common clock",
> we get the mach code ready for the switch by adding the code needed for
> the new clock drivers and adding #ifndef CONFIG_COMMON_CLK around the
> legacy clocks so that we can switch easily between the old and the new.
>
> "ARM: davinci: switch to common clock framework" actually flips the switch
> to start using the new clock drivers. Then the next 8 patches remove all
> of the old clock code.
>
> The final three patches add device tree clock support to the one SoC that
> supports it.
>
> v6 changes (also see individual patches for details):
> - All of the device tree bindings are changed
> - All of the clock drivers are changed significantly
> - Fixed issues brought up during review of v5
> - "ARM: davinci: move davinci_clk_init() to init_time" is removed from this
>   series and submitted separately
>
> v5 changes:
> - Basically, this is an entirely new series
> - Patches are broken up into bite-sized pieces
> - Converted PSC clock driver to use regmap
> - Restored "force" flag for certain DA850 clocks
> - Added device tree bindings
> - Moved more of the clock init to drivers/clk
> - Fixed frequency scaling (maybe*)
>
> * I have frequency scaling using cpufreq-dt, so I know the clocks are doing
>   what they need to do to make this work, but I haven't figured out how to
>   test davinci-cpufreq driver yet. (Patches to make cpufreq-dt work will be
>   sent separately after this series has landed.)
>
> Dependencies:
>
> This series applies on top of linux-davinci/master plus the following patches:
> - [1] "clk: fix reentrancy of clk_enable() on UP systems" (in clk-next)
> - [2] "clk: add helper functions for managing clk_onecell_data"
> - [3] "clk: divider: read-only divider can propagate rate change"
> - [4],[5],[6],[7],[8],[9] series "ARM: davinci: common clock prep work"
>

Hi David,

I'm getting a splat[1] when trying to mount the rootfs over nfs on a da850-lcdk.

I'll try to figure out what's happening.

Best regards,
Bartosz Golaszewski

[1] https://pastebin.com/D94z8SAe

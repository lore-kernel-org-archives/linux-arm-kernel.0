From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 May 2017 21:32:36 +0200
Subject: Updating kernel.org cross compilers?
In-Reply-To: <20170510134019.GB19687@gate.crashing.org>
References: <92b5ff36-ad2b-10bc-de4f-4774babd9625@arm.com>
 <20170430052957.GJ19687@gate.crashing.org>
 <ee8a7f2c-976d-fe2a-55f9-ab8eebbf22eb@arm.com>
 <20170509221843.GZ19687@gate.crashing.org>
 <CAK8P3a38bCS2rSwtQzYROfVBQ549akQZKPUJhcwDrWPN4NA1+w@mail.gmail.com>
 <20170510134019.GB19687@gate.crashing.org>
Message-ID: <CAK8P3a2iw44SDdV0PrODWeROxuFL9e9JYVhnVc9bZuyXF482EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 3:40 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> Hi Arnd, long time no see,
>
> On Wed, May 10, 2017 at 09:58:13AM +0200, Arnd Bergmann wrote:
>> >> So in addition to GCC 7.1 I'd like to have at least GCC 6.3 around,
>> >> which builds kernels without warnings today.
>> >
>> > If you don't want warnings, turn off the warnings or just don't look at
>> > them...  or fix the problems?  Many of the new warnings point out actual
>> > problems.
>> >
>> > Many of those sprintf problems in the kernel have already been fixed.
>>
>> I've been using gcc-7.0 for a long time and fixed a lot of bugs it found,
>> along with more harmless warnings, but I had disabled a couple of
>> warning options when I first installed gcc-7 and ended up ignoring
>> those.
>>
>> The exact set of additional options I used is:
>>
>> -Wimplicit-fallthrough=0 -Wno-duplicate-decl-specifier
>> -Wno-int-in-bool-context -Wno-bool-operation -Wno-format-truncation
>> -Wno-format-overflow
>>
>> there were a couple of others that I sent kernel fixes for instead.
>> I should probably revisit that list and for each of them either
>> only enable it with "make W=1" or fix all known warnings.
>> In the long run, I'd actually hope to fix all W=1 warnings too
>> and enable them by default.
>
> Most of those usually point out actual problems (at least code that
> isn't as clear as it should be).  I do hate that first one though.

My point is that we have others in W=1 some of which are equally useful:
warning-1 := -Wextra -Wunused -Wno-unused-parameter
warning-1 += -Wmissing-declarations
warning-1 += -Wmissing-format-attribute
warning-1 += $(call cc-option, -Wmissing-prototypes)
warning-1 += -Wold-style-definition
warning-1 += $(call cc-option, -Wmissing-include-dirs)
warning-1 += $(call cc-option, -Wunused-but-set-variable)
warning-1 += $(call cc-option, -Wunused-const-variable)
warning-1 += $(call cc-disable-warning, missing-field-initializers)
warning-1 += $(call cc-disable-warning, sign-compare)

I've looked through arm and x86  gcc-7 allmodconfig builds (without
my longish fixup series) again and found these added warnings
compared to gcc-6.3.1 overall:

      2 -Werror=bool-operation
      4 -Werror=maybe-uninitialized
      1 -Werror=parentheses
      2 -Werror=stringop-overflow=
      2 -Werror=tautological-compare

I probably submitted patches for those in the past, will have
another look to see if I need to resubmit them, or if some
of them might be regressions.

   148 -Werror=duplicate-decl-specifier

Only a few files are affected, I can take care of fixing them all:

  |      1 arch/arm/mach-at91/pm.c
  |      1 arch/arm/mach-bcm/bcm_kona_smc.c
  |      1 arch/arm/mach-cns3xxx/core.c
  |      1 arch/arm/mach-omap2/prm_common.c
  |      1 arch/arm/mach-omap2/vc.c
  |      1 arch/arm/mach-spear/time.c
  |      2 drivers/input/keyboard/cros_ec_keyb.c
  |      4 sound/soc/codecs/rt5514.c
  |    136 sound/soc/codecs/rt5665.c

     89 -Werror=int-in-bool-context

This showed up in 26 files in allmodconfig alone. I had started on some
of them but given up at some point. I can certainly submit the ones
I did already, but probably won't have the patience to address all of them
myself.

     54 -Werror=format-overflow=

Same here.

    494 -Werror=format-truncation=

These are all over the place, in 187 files.

The last one in particular seems less useful than -Wformat-security
which we already disable (for all levels), and I'd rather have them both in
"make W=1". For -Wint-in-bool-context and -Wformat-overflow=
it's less obvious whether we should try to get them all fixed
quickly, using >100 patches or put them into W=1 along with
-Wformat-truncation.

      Arnd

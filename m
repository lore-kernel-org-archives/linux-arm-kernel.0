From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 02 Jan 2012 14:55:47 +0100
Subject: snowball does not compile on linux-next
In-Reply-To: <CACRpkdbn6H_s8oC3VdqH2CoCZcPkc+hYccLE1UQJZnqB5eSf3Q@mail.gmail.com>
References: <4F0199CF.2070806@linaro.org>
 <CACRpkdbn6H_s8oC3VdqH2CoCZcPkc+hYccLE1UQJZnqB5eSf3Q@mail.gmail.com>
Message-ID: <4F01B763.4040201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/02/2012 01:59 PM, Linus Walleij wrote:
> On Mon, Jan 2, 2012 at 12:49 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>
>> the kernel does not compile when
>> CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK is set.
>>
>> it fails with :
>>
>> CHK include/linux/version.h CHK
>> include/generated/utsrelease.h make[1]:
>> `include/generated/mach-types.h' is up to date. CALL
>> scripts/checksyscalls.sh CHK include/generated/compile.h CC
>> drivers/clocksource/clksrc-dbx500-prcmu.o
>> drivers/clocksource/clksrc-dbx500-prcmu.c:61: warning: type
>> defaults to ?int? in declaration of ?DEFINE_CLOCK_DATA?
>> drivers/clocksource/clksrc-dbx500-prcmu.c:61: warning: parameter
>> names (without types) in function declaration
>> drivers/clocksource/clksrc-dbx500-prcmu.c: In function
>> ?sched_clock?: drivers/clocksource/clksrc-dbx500-prcmu.c:72:
>> error: implicit declaration of function ?cyc_to_sched_clock?
>> drivers/clocksource/clksrc-dbx500-prcmu.c:72: error: ?cd?
>> undeclared (first use in this function)
>> drivers/clocksource/clksrc-dbx500-prcmu.c:72: error: (Each
>> undeclared identifier is reported only once
>> drivers/clocksource/clksrc-dbx500-prcmu.c:72: error: for each
>> function it appears in.)
>> drivers/clocksource/clksrc-dbx500-prcmu.c: In function
>> ?clksrc_dbx500_prcmu_update_sched_clock?:
>> drivers/clocksource/clksrc-dbx500-prcmu.c:78: error: implicit
>> declaration of function ?update_sched_clock?
>> drivers/clocksource/clksrc-dbx500-prcmu.c:78: error: ?cd?
>> undeclared (first use in this function)
>> drivers/clocksource/clksrc-dbx500-prcmu.c: In function
>> ?clksrc_dbx500_prcmu_init?:
>> drivers/clocksource/clksrc-dbx500-prcmu.c:100: error: implicit
>> declaration of function ?init_sched_clock?
>> drivers/clocksource/clksrc-dbx500-prcmu.c:100: error: ?cd?
>> undeclared (first use in this function) make[2]: ***
>> [drivers/clocksource/clksrc-dbx500-prcmu.o] Error 1 make[1]: ***
>> [drivers/clocksource] Error 2 make[1]: *** Waiting for unfinished
>> jobs.... make: *** [drivers] Error 2 make: *** Waiting for
>> unfinished jobs....
>>
>> Is it dead code ?
>
> No if it was dead it shouldn't get compiled.
>
> It' probably just some fallout from Marc's rewrite of the
> sched_clock() stuff, I'll see if I can cook a patch and send off to
> Marc.

Ok, thanks. I will test the patch you sent.

it seems also the commit :

commit c15def1cc30edeaa74a97205c936be82cdc86df6
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Thu Dec 15 13:38:40 2011 +0100

    ARM: ux500: remove support for early silicon revisions
 
    The DB8500 ED (Early Drop) and V1 are only available inside of
    ST-Ericsson or partners, we have actively replaced and scrapped
    these prototypes. All Nova products on the open market (such as
    the Snowball board) are based on V2 and later ASIC variants.
    So let us focus on supporting the silicon that will be used and
    delete this to get a clear overview.
 
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

removed the U8500_PRCMU_TCDM_BASE_V1 macro definition but it is still
used in drivers/mfd/db8500-prcmu.c

The compilation fails with:

drivers/mfd/db8500-prcmu.c: In function ?db8500_prcmu_early_init?:
drivers/mfd/db8500-prcmu.c:2107: error: ?U8500_PRCMU_TCDM_BASE_V1?
undeclared (first use in this function)
drivers/mfd/db8500-prcmu.c:2107: error: (Each undeclared identifier is
reported only once
drivers/mfd/db8500-prcmu.c:2107: error: for each function it appears in.)
make[2]: *** [drivers/mfd/db8500-prcmu.o] Error 1
make[1]: *** [drivers/mfd] Error 2
make[1]: *** Waiting for unfinished jobs....


- -- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPAbdjAAoJEAKBbMCpUGYAsBMH/34gi4X+ASaKC8CbJuXe1xHE
7Vp3SRctP+yNQdd4iI3ma9pDnOX9kLl2iuCty3aRy4rpH+hnzHkgKdmfKKRGzH32
FoffLeEIfnGYcC5T+PDO3wL0T1zim33Umo/wyl/CLrHrgV/dX7C1lqLwQ5TF6GI8
g9pQa7raPgNvRNv3gI8p/ult8dvJEplJkl+R3MXUddfCAn4wfL+y4xpliyOwMHhb
uw3ReHAsibmJe1eBD0qh+MvioDuxnHxTLek2eq+eZRUCoiT1gN24L51IGZjbrUlE
zgEW4O0+/Gok4vm7ZYHe1gVqvbkPtMx34mPkf4nCV6QhTihWi1Rq2J6CwqugLhE=
=xA0Z
-----END PGP SIGNATURE-----

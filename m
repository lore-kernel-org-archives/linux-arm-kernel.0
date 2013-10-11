From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Oct 2013 08:43:53 -0700
Subject: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
In-Reply-To: <CACRpkdYJNaiAAHhYatd6g5_wVt0QEUxOvsk6nQn9o=_i5zfWrA@mail.gmail.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost>
 <5256AA7F.8030005@ti.com> <20131010160018.GA29913@atomide.com>
 <CACRpkdaG-PQA39XSjKUgM9TyeD7srgm_8s+NazrDKJ0gmNLcwg@mail.gmail.com>
 <20131010162015.GC29913@atomide.com>
 <CACRpkdYF83ghUf60Wmrti53UJ1bWV30GW_P9GjWnsOcZHbsv+Q@mail.gmail.com>
 <5257BD3E.5000707@ti.com>
 <CACRpkdYJNaiAAHhYatd6g5_wVt0QEUxOvsk6nQn9o=_i5zfWrA@mail.gmail.com>
Message-ID: <20131011154352.GO29913@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [131011 03:40]:
> On Fri, Oct 11, 2013 at 10:56 AM, Roger Quadros <rogerq@ti.com> wrote:
> 
> > The register handling is fine. But how do we deal with resource handling?
> > e.g. the block that has the deep-core registers might need to be clocked or powered
> > before the registers can be accessed.
> 
> Yeah I saw this in the code there.
> 
> In this case it seems syscon-type regmap access can be used to
> read/write the registers, so maybe the pin controller also need to
>  get a handle on some clock etc?

Uhh, let's not go there.. The resource availability needs to be
handled transparently in regmap code and the reg provider hardware
module driver using runtime PM.

> The general idea is however that large monolitic "drivers" for a
> certain IO-range such as arch/arm/mach-omap2/prm3xxx.c
> doesn't scale - we saw this with the Ux500 PRCMU driver in
> mfd/* to the point that our patches to extend it were NACK:ed
> until we refactor it. This stuff in mach-omap2 is in the same bad
> design pattern, and need to get out of it.
> 
> The approach chosen for the Ux500 PRCMU was to distribute
> out the driver into the places where it's actually used, like the
> clock driver etc. The accessor functions to do some stuff over
> in the PRCMU was just adding a layer of cruft.

Yes I'm all in favor of having a minimal PRM core driver that manages
resources and provides register access services in a controlled way
to it's client drivers. As long as the emphasis is "in a controlled
way".

Regards,

Tony

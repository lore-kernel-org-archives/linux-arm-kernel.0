From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Apr 2018 14:32:29 +0200
Subject: [PATCH 1/2 v2] drm/pl111: Support the Versatile Express
In-Reply-To: <20180410095737.GF10254@e110455-lin.cambridge.arm.com>
References: <20180406141935.6801-1-linus.walleij@linaro.org>
 <20180410095737.GF10254@e110455-lin.cambridge.arm.com>
Message-ID: <CACRpkdb1toYJEaHDZ2QORt+qzN7imH9ugx3xvi1HASoZU0QSiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 11:57 AM, Liviu Dudau <liviu.dudau@arm.com> wrote:

> I need to do a bit of archeology to get my Versatile Express back
> to working order in order to test your patches, which might not
> happen this week or so, but I have some comments on your approach
> which I would like clarification on.

OK no hurries :)

> On Fri, Apr 06, 2018 at 04:19:34PM +0200, Linus Walleij wrote:
>>
>> The Versatile Express uses a special configuration controller
>> deeply embedded in the system motherboard FPGA to multiplex the
>> two to three (!) CLCD instances out to the single SiI9022
>> bridge.
>
> That configuration controller is already supported by the
> drivers/misc/vexpress-syscfg.c driver and the muxfpga node is present
> in arch/arm/boot/dts/vexpress-v2m-rs1.dtsi (and vexpress-v2m.dtsi for
> older CoreTiles that don't use the RS1 memory map).

Yes the code is using that driver through the public interface in
<linux/vexpress.h>, so it should be fine.

>> Set up an extra file with the logic to probe to the FPGA mux
>> register on the system controller bus, then parse the memory
>> range argument to figure out what path the CLCD signal is
>> actually taking, and set up the mux accordingly.
>
> I'm not sure you need all this extra code,

I think the commit message may be confusing.... I will try
to reword it.

> I would have thought that
> all you want is to use the regmap that you already have in order to
> switch the MUX to the correct input. The MUXFPGA in the DT is already
> setup to use function 7 (which is the function you need for FPGA), you
> just need a property in the PL111 node to tell you which "site" you are
> on (Motherboard, Daughterboard 1 or 2) and use the relevant value when
> setting the regmap.
>
> Info on what the correct values are are here:
> http://infocenter.arm.com/help/topic/com.arm.doc.dui0447j/CACDEFGH.html#CACCGJFF

Yes this is what I'm using, I am manipulating SYS_CFG_MUXFPGA
through the interface exposed in <linux/vexpress.h>.

>> If there is a CLCD instance on the core tile (the daughterboard
>> with the CPUs fitted) then that CLCD instance will take
>> precedence since it can address all memory.
>
> What does "take precedence" mean here? You mean prefer to switch the MUX
> to that source instead of using the MB? That should always be the
> default choice, as the MB CLCD is mostly for boot up info being
> displayed and it is known to have horrendous performance.

Yes, so that is what I am trying to do. If there is a CLCD on the
core tile (daughterboard as it its called in the manual), that one
should take precedence.

Unfortunately there is just one single vexpress core tile in the
upstream kernel that define a CLCD controller, the CA9 (4xA9)
that I am using. All the others just use the MB CLCD.

I am thinking there is some never finished DTS upstreaming
here that ought to happen so we use the core tile CLCD on some
other boards as well.

Yours,
Linus Walleij

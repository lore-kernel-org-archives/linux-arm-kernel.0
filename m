From: chunkeey@googlemail.com (Christian Lamparter)
Date: Tue, 10 May 2016 21:55:15 +0200
Subject: [PATCH v8 2/3] gpio: mmio: add DT support for memory-mapped GPIOs
In-Reply-To: <CACRpkdaeZ14hfz-gRetRcdj8NzzyqigV1ZtDSWAwveFxwAgt0w@mail.gmail.com>
References: <cover.1462543457.git.chunkeey@googlemail.com>
 <535f785bf6116c0fb6f46afbb77e6d4bd3ef5f60.1462543458.git.chunkeey@googlemail.com>
 <CACRpkdaeZ14hfz-gRetRcdj8NzzyqigV1ZtDSWAwveFxwAgt0w@mail.gmail.com>
Message-ID: <3359834.V76Y1cJiRU@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 10, 2016 02:08:45 PM Linus Walleij wrote:
> On Sun, May 8, 2016 at 3:08 PM, Christian Lamparter
> <chunkeey@googlemail.com> wrote:
> 
> > From: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
> >
> > This patch adds support for defining memory-mapped GPIOs which
> > are compatible with the existing gpio-mmio interface.
> 
> Overall very nice, just waiting for the next version.

K, will deliver. I noticed that you sent a mail in which you stated
that you applied the dt binding already. Can you update your devel
branch on git.kernel.org's linux-gpio? Then, I'll simply rebase my
series and sent the remaining two patches.
(unless you tell me otherwise).
 
> > The first user for this binding is "wd,mbl-gpio".
> 
> And that binding defines that we have a register named "dat".

Yeah, I had to remove all non wd related bits. But since this 
series was posted (over and over :D) on a public mailing-list
the original  "generic" linux-mmio binding is available for
everybody to perusal[0] and study. I think what we can make
would be something like a devicetree template out of it. This
way people can remove unused flags and regnames for their
compatible device tree binding. (But first: need to finish
that ppc-gpio.txt).

> > +       if (of_property_read_bool(dev->of_node, "no-output"))
> 
> And then this too.
> 
> Do we want these generic MMIO bindings (dat, no-output)
> in a special document like
> Documentation/devicetree/bindings/gpio/gpio-mmio.txt?
> 
> Going forward?
Ah, I was thinking about Documentation/gpio... Since there's no
way it would go in the devicetree/bindings without having a compatible?
(And there's technically none). As far as I know the problem here is not
that it would be impossible to do that (updating a .dts file is "easy"...),
but updating .dtb to a tiny flash-rom on the device might not be. So we
have to make every effort to preserve compatibility for those devices
(and old/incomplete/broken dtbs) as long as the device is supported.

About adding new device:
This will work in the following way: 
 1. new drives will need to supply their hardware-specific devicetree
    binding file to the dt maintainers (This "vendor,device.txt" file
    will be like the wd,mbl-gpio.txt - but modified for the hardware
    (this is where the template would be handy)

 2. Make a one-liner patch which adds a compatible string to
    gpio-mmio.c's bgpio_of_match table:

+	{ .compatible = "vendor,device", .data = bgpio_basic_mmio_parse_dt },

(Of course, not having parses for the "ngpio" property and the flags like
big-endian, reg-output-reg,set, unreadable-reg-dir, ... properties from
the get-go is sad, these can add back once a driver/binding needs it).

I think brcm63xx will be following shortly. So we can test the
procedure.
> This patch set mainly deals with refactorings, but in the
> long run we want to slim things down a bit and use standard
> bindings I think.
Well, to do that, I think we need to collect enough devices to
make it a real "class" of devices first.

Regards,
Christian

[0] <https://lkml.org/lkml/2016/4/28/921>

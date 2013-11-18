From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 18 Nov 2013 10:10:09 -0800
Subject: [PATCH v3 22/28] mtd: nand: pxa3xx: Introduce multiple page
 I/O support
In-Reply-To: <20131106113210.GB2616@localhost>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-23-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131105190432.GQ20061@ld-irv-0074.broadcom.com>
 <20131106011351.GH11759@localhost>
 <CAN8TOE_ZmcsvShKY273KQCaopJEXgtXVR1XY9pP5EKkUK+bUbA@mail.gmail.com>
 <20131106113210.GB2616@localhost>
Message-ID: <20131118181009.GZ9468@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

There's one question of yours that I think hasn't been addressed:

On Wed, Nov 06, 2013 at 08:32:11AM -0300, Ezequiel Garcia wrote:
> Having followed (part) of the OMAP DT ECC discussion, I'm thinking:
> wouldn't it be good to have an 'nand-ecc-strength' property in the DT?
> 
> It would match the ecc_strength_ds field. This way, the ECC mode
> selection is left to the driver and not to the user.
> On the other side, this can cause some severe incompatibilities
> unless such driver *always* make the *same* selection.

I'm not quite so sure about the whole question of ECC in device tree.
There seems to be 2 subtly different properties we might want to
capture:

1) What is the minimum ECC required for the flash?

2) What is the exact ECC layout/strength/type used for this flash?
   (i.e., what is the bootloader using?)

The first is quite generic: the property consists of a stength and step
size. (But this is also duplicated in ONFI, and our full-ID device
table.)

Still, I think a property for #1 could be useful, for those chips that
are not discoverable. And if we (you?) add it, it should be done at the
nand_base level, I think, so its binding is shared by all drivers.

I'm not quite sure how we identify the appropriate struct device_node
for nand_base to use, though. Maybe we should force drivers to
initialize a new mtd_info.of_node field? And then maybe this could also
be integrated into the 'ofpart' parser, which currently requires drivers
to pass a device_node via the mtd_part_parser_data struct?

Property #2 is very driver/hardware specific, and it may not be easy to
capture this information properly using the same set of properties for
all NAND drivers. For example, "BCH-8" is not the same on all systems;
and even on the same system a software BCH-X could potentially be very
different than (and incompatible with) a BCH-X as provided by hardware.
And different hardware provides wildly different choices regarding ECC,
so I'm not convinced that we could create a good generic binding for
describing #2.

But I think a property like #2 is necessary for many platforms that need
to eliminate the problem that you mention, where drivers must always
make the same selection. Essentially, we're assuming bootloader/driver
co-design, rather than properly communicating this information via a
shared data structure like device tree.

Now, it's another question as to whether we need a property for both #1
and #2. The latter would probably just override the former, but that
doesn't mean that the former is unnecessary...

Anyway, I'll stop having a conversation with myself now. If you think
something should be done, I'm willing to listen and help integrate a
solution.

Brian

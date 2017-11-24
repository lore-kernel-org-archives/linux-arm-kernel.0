From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 24 Nov 2017 14:31:23 +0100
Subject: [RFC PATCH 1/3] dt-bindings: pinctrl: sunxi: document new
 generic binding
In-Reply-To: <20efcf8f-85a5-3cad-a84b-434ee5cad68e@arm.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
 <20171113012523.2328-2-andre.przywara@arm.com>
 <CACRpkdbpfkM4odz425+4qyUCF5vqPWBQ=F5Yk7AtJL5SqXghpg@mail.gmail.com>
 <20171124105240.GB3792@ulmo>
 <20efcf8f-85a5-3cad-a84b-434ee5cad68e@arm.com>
Message-ID: <20171124133123.GA15999@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 12:04:12PM +0000, Andre Przywara wrote:
> Hi,
> 
> (adding linux-sunxi, which I forgot at the initial post).
> 
> On 24/11/17 10:52, Thierry Reding wrote:
> > On Fri, Nov 24, 2017 at 11:19:52AM +0100, Linus Walleij wrote:
> >> On Mon, Nov 13, 2017 at 2:25 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> >>
> >>> So far all the Allwinner pinctrl drivers provided a table in the
> >>> kernel to describe all the pins and the link between the pinctrl functions
> >>> names (strings) and their respective mux values (register values).
> >>>
> >>> Extend the binding to put those mappings in the DT, so that any SoC can
> >>> describe its pinctrl and GPIO data fully there instead of relying on
> >>> tables.
> >>> This uses a generic compatible name, to be prepended with an SoC
> >>> specific name in the node.
> > 
> > This seems backwards to me. I'm not sure if Rob has any hard rules on
> > this, but in the past I've seen a lot of drivers stick this kind of data
> > into drivers. I personally also prefer that approach because the data is
> > completely static and there's no way for any specific board to customize
> > it. So the tables are in fact implied completely by the SoC compatible
> > string.
> 
> But this is just *data*, and I believe it is actually package specific.
> We need the DT to describe the relation between devices and pins anyway,
> it's just that we use arbitrary strings today instead of the actual
> register value. This is what the generic pinmux property fixes.

Register values don't belong in a device tree. And it's totally fine to
have data in the kernel, too. We do it all the time.

> > Moving all of this data into device tree has a number of disadvantages:
> > 
> >   * Existing boards already use the static tables in the driver, and the
> >     device trees don't contain any data, so you can't get rid of any of
> >     the existing tables because it would break ABI.
> 
> Yes, my DeLorean is in the garage, so I can't really change this anymore
> ;-) But that doesn't mean we have to go on with this forever, I think.

ABI stability means that, yes, you have to keep maintaining the existing
tables forever, else old DTBs will stop working if you rip out the
static tables that drivers depend on.

> >   * Moving the table into the DT doesn't actually solve anything because
> >     the driver would have to validate the DT description to make sure it
> >     contains valid data. And in order to validate DT content, the driver
> >     would need a copy of the table anyway.
> 
> I don't get what the driver would need to validate? We rely on DT
> information to be correct anyway, otherwise your board just won't work.
> If the DT is wrong, you have much bigger problems.

Given that DT is an ABI you should treat it the same way as other ABIs.
You can't rely on the DT being correct. Rather you have to make sure to
validate it before you hand the content to hardware. If you allow direct
register access to your hardware via DT and don't validate, it becomes
really easy for people to exploit it.

This is not the same as saying we need to be able to fully validate all
aspects of device tree. We can't, because some information simply does
not exist outside of DT. However, I think it's a big mistake to trust a
user to fully know about all intricacies of a pinmux and not make any
mistake when writing the device tree. What if one of the settings causes
the board to go up in flames?

> Actually we gain something, because we only commit information that can
> actually be tested. Right now we have a lot of information which is
> copied from the manual, and nobody knows if pin H24 on the A10 is really
> PATA-CS1 or not. Plus we have bugs when creating the table, plus
> copy&paste bugs. I found some while grep-ing for patterns - will send
> fixes ASAP.

That's a different matter. If you've got bugs in the tables, then go fix
the tables. However the assumption here is that you've done at least a
minimum of testing and your driver didn't cause your board to go up in
flames. When patches were posted, people had the opportunity to review
the tables for correctness. However, if you put all of the flexibility
into DT, you also put all of the risk there. People may just make some
stupid mistake and cause physical damage to their hardware.

> In the moment all the table gives us is a mapping between a *string* and
> the respective mux register value (per pin), plus the number of pins in
> each bank. This can *easily* be put in the DT and should belong there.

Why? This is data that is implied by the compatible string and static
per SoC. There is no way you can change the mapping in DT. What does
need to go into DT is the configuration of the pinmux, that is, what
function is used for each pin on a given board.

> Actually I believe that the current binding is not correct, because it
> makes those mux strings a part of the binding, though this is not
> documented anywhere. A developer cannot take the binding and write a
> working driver or even a DT without looking at the code.
> Plus we already changed those names in the past (for instance commit
> bc0f566a98c4), basically breaking compatibility.

If you haven't documented the strings your binding is not complete.
That's a bug and should be fixed. Also, it is occasionally acceptable to
break compatibility (it's technically only breaking if somebody notices)
and fixing bugs in bindings has in the past been one of the exceptions
where breaking ABI was specifically allowed.

However, the kind of breakage we're talking about here is total. If you
rip out the static tables from your driver, you don't have any data to
replace the missing information and none of the driver will work. This
is different from the driver erroring out trying to configure a pin for
the NAND function because it couldn't match the name.

Also, device tree bindings are not documentation for how to write a
driver. They are not a replacement for hardware documentation. Nobody
should be expected to be able to write an OS driver solely based on a
device tree binding. Device tree bindings are more of a configuration
interface specification for OS drivers.

> > I don't think you're going to do yourself any favours by pushing this. I
> > also don't see the commit description give any reason why you want to
> > move the table into device tree. Do you see any advantages in doing so?
> 
> We stop adding tables with SoC specific *data* in the kernel *code*
> base. With being boolean Kconfig options, this gets added to every
> single-image kernel.

The kernel is full of data:

	$ objdump -h build/arm64/vmlinux
	[...]
	  1 .text         009c99c0  ffff000008081000  ffff000008081000  00011000  2**11
	                  CONTENTS, ALLOC, LOAD, READONLY, CODE
	  2 .rodata       00403bf8  ffff000008a50000  ffff000008a50000  009e0000  2**12
	                  CONTENTS, ALLOC, LOAD, DATA
	[...]

So that's about 40% of the kernel image. Code really is no good without
data to process.

> More important: those tables help Linux, but other DT consumers (*BSD,
> U-Boot) have to replicate them, which is just wrong, IMHO.

Yeah, I've heard this before. To be honest, I think these tables are the
kind of data that you should generate, and once you do that it becomes
extremely cheap to add the data to other DT consumers.

And let's face it: the really difficult part of adding pinmux support is
to write the driver (or subsystem if you don't have one yet). Adding the
data is really the easy part.

> I believe the kernel is a nice collection of really good code for
> complicated file systems, high performance network protocols and
> sophisticated memory management, among others. It shouldn't be a dumping
> ground for arbitrary, very SoC specific information. Cf. LinusT 2011.
> DT is out there to fix this, so we should do so.

Every driver is very SoC specific information. There's never been an
objection to having SoC specific drivers in the kernel. And back at the
time the discussion was as much about the development process and code
structure than it was about board files.

The majority of the improvements over the years have been achieved by
moving drivers out of arch/arm and moving board files to DT. The goal
was never to get rid of all data.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171124/cf82009f/attachment.sig>

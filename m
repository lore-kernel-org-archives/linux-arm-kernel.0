From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 1 Jun 2011 18:04:02 -0500
Subject: i.MX consolidation patches
In-Reply-To: <20110601210855.663A3CEFB4E@gemini.denx.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601210855.663A3CEFB4E@gemini.denx.de>
Message-ID: <BANLkTi=HqEBRzyU4_HXnNHTeOPL9vPW8PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2011 at 4:08 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Sascha Hauer,
>
> In message <20110601141847.GG23771@pengutronix.de> you wrote:
>>
>> > We probably should disable the uImage target when p2v patching is
>> > enabled to prevent people getting nasty surprises.
>> >
>>
>> Agreed. Here is a patch. I added Wolfgang Denk to Cc, maybe
>> he can prove me wrong.
>>
>> 8<----------------------------------------------------------
>> ARM: do not allow to build uImages with ARM_PATCH_PHYS_VIRT
>>
>> U-Boot uImages expect a load address and a entry point in
>> the image header. With CONFIG_ARM_PATCH_PHYS_VIRT these
>> become variable and thus can not be compiled into the uImage.
>
> Would it help if we interpret, for example, the values for load
> address and entry point not as physical addresses, but instead as
> offsets relative to the start of physical RAM?
>
> This would still require that all systems supported by a single image
> use the same offsets. ?Is this possible?

Been having this discussion on and off with various parties and we
determined that if U-Boot had a little
extra logic when parsing a uImage header it could perfectly validly
boot a zImage contained in a uImage
header.

In this case, just a load address in the uImage header of 0 (or some
other totally-impossible value like 0xffffffff
in case 0 is perfectly valid somewhere) and then just jump to the
entry point by deriving the value from the
header size - based on the fact that ARM images are PIC and the Linux
kernel always puts the entry point
at 0 offset - to the address of the uImage header + size of the uImage
header (which U-Boot knows already
from parsing the header).

Example: on the MX51 the entry point is usually set to 0x90008000 -
that's what Freescale put in their BSP
U-Boots and everyone has copied it.. There's a variable in our U-Boots
at least that is used in boot scripts to
ext/fat/whateverload it to 0x90007FC0. That 0x90007FC0 address to load
to is a nasty hack meant to match
the header size of a legacy uImage (therefore the first byte of the
payload will live at 0x90008000).

We can't support anything but a legacy image right now because of
that, and if we needed to support a new
style uImage with FDT, then this load address and entry point magic
would be totally wrong anyway requiring
both userspace script and kernel changes.

So the solution is

* Assuming all ARM kernels are PIC (guaranteed, right?)
* Assuming all ARM kernels start at entry point 0 (true for Image and zImage)
* Assuming there is a globally invalid magic value you can set in the
uImage header as load address (not sure)
* Assuming you can make sure U-Boot only does this for ARM,
kernel-type images and not ramdisks or so (true)

Set that magic value, U-Boot magically derives the correct entry point
as the first address of the payload,
and jumps to it?

I tested it.. works great but I don't have a wealth of ARM hardware to
TRULY confirm all the above.

Let's not kill off uImage generation just yet if we can just patch our
firmwares once and for all and let Linux
decide whether it sets the load address to a real address or a magic
value? Then all variants of kernel will
work for the boards, patching phys_to_virt or not.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.

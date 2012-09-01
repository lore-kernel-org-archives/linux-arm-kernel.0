From: robherring2@gmail.com (Rob Herring)
Date: Fri, 31 Aug 2012 19:48:42 -0500
Subject: [PATCH 1/6] ARM: move ARCH config definitions into mach dirs
In-Reply-To: <20120830192831.GD18957@n2100.arm.linux.org.uk>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
 <1346280600-29395-2-git-send-email-robherring2@gmail.com>
 <20120829233159.GS18957@n2100.arm.linux.org.uk> <503F845C.10406@gmail.com>
 <20120830164551.GY18957@n2100.arm.linux.org.uk> <503FB9E6.7020102@gmail.com>
 <20120830192831.GD18957@n2100.arm.linux.org.uk>
Message-ID: <50415B6A.5060601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2012 02:28 PM, Russell King - ARM Linux wrote:
> On Thu, Aug 30, 2012 at 02:07:18PM -0500, Rob Herring wrote:
>> On 08/30/2012 11:45 AM, Russell King - ARM Linux wrote:
>>> That also means we can start to think about moving the mach/debug-macros.S
>>> header elsewhere, remembering that this facility is shared between the
>>> decompressor for debugging and the kernel.
>>
>> I was thinking we could convert the phys and virt addresses to config
>> values and then the DEBUG_LL choices could just be "Use PL01x uart" and
>> "Use 8250 uart". This would cut down the number of debug-macro.S files
>> and choices.
>>
>> Using a fixed virtual address for all platforms might also help simplify
>> DEBUG_LL.
> 
> No it won't, that comment says you totally don't understand the feature
> you're playing with to me.

Or you don't understand what I meant.

> It's not only about virtual addresses, it's about physical addresses too,
> and we can't dictate that all hardware exposes a UART at any particular
> physical address.

We have 3 things to track for each platform: the type of uart, the
uart's phys address, and the virtual address we map it to. Obviously, we
can't get rid of the first 2, but we can align the virtual address to
the same 1MB section for DEBUG_LL on all platforms. Then we only have 2
differences to deal with. If we make the physical address a config
value, then we could unify all the addruart implementations (except
perhaps for the crazy stuff omap does). So something like this:

		.macro	addruart,rp,rv,tmp
		mov	\rv, #0xfe000000
		orr	\rv, \rv, #0x00d00000
		ldr	\rp, =CONFIG_DEBUG_LL_UART_ADDR
		lsl	\tmp, \rp, #12
		lsr	\tmp, \tmp, #12
		orr	\rv, \rv, \tmp
		.endm

Of course we'd have to shift around static mappings to free up whatever
address we use. I don't know if 0xfed00000 would be the best choice, but
that is just below were I put the PCI i/o mapping.

Rob

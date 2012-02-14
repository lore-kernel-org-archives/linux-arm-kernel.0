From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 20:54:24 -0600
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <201202140203.15360.arnd@arndb.de>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-14-git-send-email-robherring2@gmail.com>
 <20120213223653.GF25655@n2100.arm.linux.org.uk>
 <201202140203.15360.arnd@arndb.de>
Message-ID: <4F39CCE0.200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 02/13/2012 08:03 PM, Arnd Bergmann wrote:
> On Monday 13 February 2012, Russell King - ARM Linux wrote:
>> On Mon, Feb 13, 2012 at 03:43:26PM -0600, Rob Herring wrote:
>>> From: Rob Herring <rob.herring@calxeda.com>
>>>
>>> Add a kconfig option NEED_MACH_IO_H to conditionally include mach/io.h.
>>>
>>> Basing this on CONFIG_PCI and CONFIG_ISA doesn't quite work. Most ISA
>>> platforms don't need mach/io.h, but ebsa110 does.
>>
>> This is architecturally wrong.  If you have ISA, and your __io() macro
>> is essentially a 1:1 translation, you're asking for ISA drivers to
>> scribble on whatever is at virtual address 0-64K.  Too bad if that
>> happens to be where your CPU vectors are stored, you'll lose control
>> of the CPU in that case.
> 
> Right. I still think it should be conditional on PCI || ISA || PCMCIA,
> not introducing a new kconfig symbol, and the next step should be to
> unify the __io() implementations for the platforms that need them.

As we discussed at Connect, that was my original intent. However, there
are a couple of issues as NEED_MACH_IO_H is not exactly equivalent to
PCI || ISA || PCMCIA.

There are a few platforms which still need io.h for custom accessor
functions: rpc, ixp4xx, s3c2410, and ebsa110. Also, a few platforms that
only select ISA don't do any translation in __io(). These are sa1100,
clps711x, and pxa. My understanding is that is wrong.

If we use CONFIG_PCI, then we have to move over all PCI enabled
platforms at once. With a separate kconfig option, then we can move
platforms one by one. Some are legacy and we may not want to move. This
also helped with omap, but Tony has now fixed it.

>> So, I think this patch series moves things in the wrong direction.
> 
> I would very much like to see a lot of the series get merged as it
> brings us closer to the single zimage, but I agree we have to be
> careful not to add extra complexity (or bugs, for that matter).

It is at least clear which platforms are special now and we can figure
out how to handle them from here.

Rob

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Nov 2011 17:56:41 +0000
Subject: [PATCH 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <1321618850.24216.324.camel@hornet.cambridge.arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-5-git-send-email-pawel.moll@arm.com>
 <20111117153624.GR9581@n2100.arm.linux.org.uk>
 <1321618850.24216.324.camel@hornet.cambridge.arm.com>
Message-ID: <20111118175641.GJ9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 12:20:50PM +0000, Pawel Moll wrote:
> On Thu, 2011-11-17 at 15:36 +0000, Russell King - ARM Linux wrote:
> >  You do know that this
> > will probably cause uboot to load the uImage at 0x80008000 instead of
> > 0x60008000, and therefore we'll lose half the RAM on this board?
> 
> I missed that - I don't use uboot, so I don't build uImages.
> 
> As the ARCH_VEXPRESS_LEGACY will be no more (see my other response) I'll
> revert the order, so the _RS1 will enforce P2V, AUTO_ZRELADDR and change
> the zrealaddr-y & friends (as in: 0x6* when no _RS1, 0x8* when _RS1=y).
> Is there any other way of having single binary kernel booting from both
> 0x60008000 and 0x80008000?

Not with uboot - uboot has been broken for many years in regard of
being able to load kernel images inteligently - it has to be told
explicitly where to load the image in system memory, so if the uImage
is built for 0x80008000, uboot will load it at that address no matter
if there's RAM there or not.

That interacts with the P2V stuff and makes PHYS_OFFSET be 0x80000000
rather than 0x60000000 - and my guess is that it'll still pass in
memory information describing the RAM at 0x60000000 which may result
in the kernel failing to boot.

There's no way around this with uboot at the moment, and I don't
expect the uboots in the field already on devices to be updated to
solve this.

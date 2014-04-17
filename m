From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Apr 2014 22:35:02 +0100
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <CAL_JsqL65bXBh1_dcud6XaDqFBnY1L69dMXWeNHvFAvcDizzhQ@mail.gmail.com>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <CAL_Jsq+aYXTQCzCtxPnS=zhBCba6-mEz+kT-mHTDW602E0vbDw@mail.gmail.com>
 <alpine.LFD.2.11.1404171549480.980@knanqh.ubzr>
 <20140417201645.GU24070@n2100.arm.linux.org.uk>
 <CAL_JsqL65bXBh1_dcud6XaDqFBnY1L69dMXWeNHvFAvcDizzhQ@mail.gmail.com>
Message-ID: <20140417213502.GX24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 04:18:45PM -0500, Rob Herring wrote:
> The problem here is more than just the TEXT_OFFSET changed. From what
> I've heard, there are some QC chips which need much more reserved RAM
> than the 2MB discussed here. Changing the TEXT_OFFSET is a hack that
> doesn't scale.

You may think it's a hack, but we really can't get around this.  There
really are platforms out there where we must do this kind of stuff.  I
invite you next time you meet up to talk to Michal Simek.  There's no
way they can load the kernel at 32K into RAM.

> A simple issue is you are now wasting 2MB of low memory on every
> platform. Not such a big deal I guess. But what if more is needed?

Why do you think it's wasted in the general case?  Do you think the
first 16K is ignored by Linux?  All memory will be freed to the Linux
page allocator unless it has an explicit reservation in memblock.  So
the 2MB won't be wasted - it will be freed as before to the page
allocator.

> The zImage requires that the kernel be placed at a 128M aligned
> address plus TEXT_OFFSET. The v2p patching then requires the kernel to
> be located within the first 16MB of RAM. So the Image can only ever be
> placed at 0x8000 - 15.?MB from a 128MB aligned address. You can never
> have the first 16-127MB of RAM reserved.

Wrong.  You can have as much RAM as you want reserved, you just can't
manage it with Linux memory allocators if you go over 16MB.

Remember that the virtual address space PAGE_OFFSET...kernel corresponds
with PHYS_OFFSET...kernel.  So, if you have 16MB between PHYS_OFFSET and
the kernel, then you have 16MB between PAGE_OFFSET and the kernel.  Your
modules are looking very distant, and PCREL24 relocations become
troublesome.

> The only way to have reserved
> memory (in chucks of 16MB) is by loading an Image file directly
> instead. The bootloaders will know the start of RAM and any reserved
> memory size because they can simply parse DT.
> 
> Bootloaders are going to have to change for arm64 Image support
> anyway, so we should have an aligned solution here.

No.  You simply can't eliminate any of the above - each one has been
negotiated through quite an amount of discussion with relevant parties
and/or due to technical requirements and they just can't be magic'd
away.

Plus the ARM64 image format is different from our zImage format.  It
would make far *more* sense to align our Image format with our zImage
format so existing boot loaders which look for the zImage magic numbers
can boot plain Image files too.

Moreover, since we could *never* align zImage with the ARM64 format,
why on earth would we want to start using the ARM64 format for the
Image format?

If you say, we should just break the existing zImage format, my response
will be: who the hell are you to decide to break 20 odd years of boot
ABI in a way which *stops* platforms from booting on such a pathetic
whim.

No, this is *not* going to happen.  It is either the zImage format or
no special format at all.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

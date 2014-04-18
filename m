From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 18 Apr 2014 00:34:56 -0400 (EDT)
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <CAL_JsqKCGg25wrTq8SyXK3zebo+uJG61083K6--mJ9Fxek03XQ@mail.gmail.com>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <CAL_Jsq+aYXTQCzCtxPnS=zhBCba6-mEz+kT-mHTDW602E0vbDw@mail.gmail.com>
 <alpine.LFD.2.11.1404171549480.980@knanqh.ubzr>
 <20140417201645.GU24070@n2100.arm.linux.org.uk>
 <CAL_JsqL65bXBh1_dcud6XaDqFBnY1L69dMXWeNHvFAvcDizzhQ@mail.gmail.com>
 <20140417213502.GX24070@n2100.arm.linux.org.uk>
 <CAL_JsqKCGg25wrTq8SyXK3zebo+uJG61083K6--mJ9Fxek03XQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1404180019410.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Apr 2014, Rob Herring wrote:

> Here's a simple test of what I was trying to point out. I took a
> working kernel with TEXT_OFFSET of 0x8000 and booted it on QEMU using
> the "virt" machine which RAM normally starts at 0x40000000. Then
> varying the RAM base, I get these results:
> 
> 0x40000000 - boots
> 0x41000000 - no output because the decompressor will still put the
> Image at 0x40008000.

If you want this to work, you have to disable CONFIG_AUTO_ZRELADDR.

In practice there is no actual hardware with physical RAM not aligned to 
a 128MB boundary.  That's why this particular alignment was selected.

> 0x48000000 - boots
> 
> So without changing TEXT_OFFSET, you can only vary the PHYS_OFFSET in
> 128MB steps. For anything in between you have to use TEXT_OFFSET. Is
> that really the right solution?

What "solution" are you looking for?  I'm under the impression you're 
getting confused about what TEXT_OFFSET is for.

> I'm not suggesting to break anything or changing existing platforms,
> but how do we improve the Image format in a compatible way. If
> bootloaders want to support booting Image files or vmlinux directly,
> then we should support that including any compatible changes to make
> things work better.

And why would bootloaders want that?  Just to create confusion with 
the established boot protocol?

There is really not much to share between ARM32 and ARM64 bootloader 
implementation wise given the major platform initialization differences, 
so trying to consolidate the very little code to actually boot the image 
is rather futile.


Nicolas

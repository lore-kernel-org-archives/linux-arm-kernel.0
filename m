From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 22 Apr 2014 11:26:53 +0100
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <alpine.LFD.2.11.1404180019410.980@knanqh.ubzr>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <CAL_Jsq+aYXTQCzCtxPnS=zhBCba6-mEz+kT-mHTDW602E0vbDw@mail.gmail.com>
 <alpine.LFD.2.11.1404171549480.980@knanqh.ubzr>
 <20140417201645.GU24070@n2100.arm.linux.org.uk>
 <CAL_JsqL65bXBh1_dcud6XaDqFBnY1L69dMXWeNHvFAvcDizzhQ@mail.gmail.com>
 <20140417213502.GX24070@n2100.arm.linux.org.uk>
 <CAL_JsqKCGg25wrTq8SyXK3zebo+uJG61083K6--mJ9Fxek03XQ@mail.gmail.com>
 <alpine.LFD.2.11.1404180019410.980@knanqh.ubzr>
Message-ID: <535643ED.8030406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/14 05:34, Nicolas Pitre wrote:
>> I'm not suggesting to break anything or changing existing platforms,
>> > but how do we improve the Image format in a compatible way. If
>> > bootloaders want to support booting Image files or vmlinux directly,
>> > then we should support that including any compatible changes to make
>> > things work better.
> And why would bootloaders want that?  Just to create confusion with 
> the established boot protocol?

I'd say that they don't. My original concern was how the different
architectures negotiate if more than one arch wants a special text
offset, not how to write a correct bootloader.

The existing uImage files already provide sufficient information to load
the kernel regardless of the TEXT_OFFSET chosen by negotiation among the
enabled architectures.

The entry point is PAGE_OFFSET + TEXT_OFFSET and, although only
implicitly defined, the entry point cannot be set to any other value
without making a backward incompatible to arm/Booting:
    "The boot loader is expected to call the kernel image by jumping
    directly to the first instruction of the kernel image."

Therefore providing PAGE_OFFSET remains 1G aligned and the hardware
meets the not-unreasonably-stupid test (i.e. TEXT_OFFSET < 1G) then
deriving the right value for TEXT_OFFSET is a trivial mask operation on
the entry point.


Daniel.

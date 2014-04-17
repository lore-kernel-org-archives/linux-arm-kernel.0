From: robherring2@gmail.com (Rob Herring)
Date: Thu, 17 Apr 2014 16:18:45 -0500
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <20140417201645.GU24070@n2100.arm.linux.org.uk>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <CAL_Jsq+aYXTQCzCtxPnS=zhBCba6-mEz+kT-mHTDW602E0vbDw@mail.gmail.com>
 <alpine.LFD.2.11.1404171549480.980@knanqh.ubzr>
 <20140417201645.GU24070@n2100.arm.linux.org.uk>
Message-ID: <CAL_JsqL65bXBh1_dcud6XaDqFBnY1L69dMXWeNHvFAvcDizzhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 3:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 17, 2014 at 04:06:16PM -0400, Nicolas Pitre wrote:
>> On Thu, 17 Apr 2014, Rob Herring wrote:
>> > Better yet, we should adopt the arm64 Image header which has this and
>> > other fields for arm Image files. We're going to have to deal with raw
>> > Image (and Image.gz) in bootloaders for arm64, so we might as well
>> > align things.
>>
>> We could use the same header as ARM64 if we want to add more information
>> to the uncompressed kernel image.
>>
>> However I really don't want to encourage the proliferation of yet
>> another kernel image formats on ARM32.  We've had zImage for the last 20
>> years and that's what ARM32 bootloaders should support.  The
>> introduction of the uImage format caused enough pain already.
>>
>> Booting uncompressed kernel image on ARM32 may be useful for some
>> debugging setups.  I don't see other cases where it would be legitimate
>> to break existing practices.
>
> Me neither.  We even have good enough reasons (such as the issue in this
> thread to do with where the image should be placed) no longer support
> uncompressed images anymore.  (Yes, they'll still be generated because
> we need the input to compress them, but we should stop advertising them
> as a make target.)

The problem here is more than just the TEXT_OFFSET changed. From what
I've heard, there are some QC chips which need much more reserved RAM
than the 2MB discussed here. Changing the TEXT_OFFSET is a hack that
doesn't scale.

A simple issue is you are now wasting 2MB of low memory on every
platform. Not such a big deal I guess. But what if more is needed?

The zImage requires that the kernel be placed at a 128M aligned
address plus TEXT_OFFSET. The v2p patching then requires the kernel to
be located within the first 16MB of RAM. So the Image can only ever be
placed at 0x8000 - 15.?MB from a 128MB aligned address. You can never
have the first 16-127MB of RAM reserved. The only way to have reserved
memory (in chucks of 16MB) is by loading an Image file directly
instead. The bootloaders will know the start of RAM and any reserved
memory size because they can simply parse DT.

Bootloaders are going to have to change for arm64 Image support
anyway, so we should have an aligned solution here.

Rob

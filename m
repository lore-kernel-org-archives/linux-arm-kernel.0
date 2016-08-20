From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 20 Aug 2016 18:36:44 +0200
Subject: [PATCH 0/2] add interworking support to Thumb2 kernel
In-Reply-To: <20160820162317.GX1041@n2100.armlinux.org.uk>
References: <1471679131-3570-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160820162317.GX1041@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu8dwTsHmk7nH-_Ogn-B8S=gkftFPUeABq7hYDC+SSx0Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 August 2016 at 18:23, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Sat, Aug 20, 2016 at 09:45:29AM +0200, Ard Biesheuvel wrote:
>> In the core kernel, interworking is supported since vmlinux is a static
>> binary, and the linker takes care of fixing up the bl instructions and
>> emitting veneers if necessary. For modules, however, all function objects
>> must currently be in the same mode, since the kernel's module loader does
>> not handle interworking switches at all.
>
> I'm not sure what the usefulness of this is - you're effectively
> encouraging people to build modules with a different configuration
> from the main kernel, which is bad news.  Since it's the configuration
> which dictates whether the kernel (and modules) are built as ARM or
> as Thumb2, you'd have to use two different configurations, one for the
> main kernel and one for the modules.
>

No, that is not the point. The point is to lift the requirement that a
Thumb2 kernel must implement all its exported or modularised functions
in Thumb2, not only in the core kernel but also in modules themselves.
For example, the crypto modules I contributed contain .S core
implementations, and building those in Thumb2 requires tweaking the
implementations so that the assembler accepts it as Thumb2 code. There
are examples in the tree (sha1-v4 and aes-v4) where we had to add ugly
workarounds so that the code would build (and it was still broken for
a while). So in general, it would be preferable to have a single ARM
implementation for both modes. Also, it will become less likely for
the multi_v7_defconfig to break inadvertently due to the addition of
low level platform code with asm components that turn out not to build
in Thumb2.

So with these patches, it is no longer necessary for core helper
routines coded in assembler (or built in ARM mode for other reasons)
to go out of their way so that the assembler can turn them in both ARM
and Thumb2 code.

I think there may be a performance benefit in some cases as well,
although this is anecdotal hearsay. The primary benefit of Thumb2 is
code size, and multi_v7_defconfig is a couple of MBs smaller when
built in Thumb2. In any case, lifting the restriction only affects
configurations that set CONFIG_THUMB2_KERNEL globally, and THUMB2
modules can still only be loaded into a THUMB2 kernel (due to the
THUMB2 tag in the version string).

Oh, and the first patch is arguably a bugfix. An exported ARM function
will not be rejected atm, but called in Thumb2 mode.

-- 
Ard.

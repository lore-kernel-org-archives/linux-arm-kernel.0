From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Mar 2016 18:37:16 +0000
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <56EAF244.2090805@caviumnetworks.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <20160316100759.GA18387@arm.com> <56E95A4E.4050709@codeaurora.org>
 <20160316141802.GC13423@e104818-lin.cambridge.arm.com>
 <56E97B10.4050401@codeaurora.org>
 <20160317142716.GC11623@e104818-lin.cambridge.arm.com>
 <56EAF244.2090805@caviumnetworks.com>
Message-ID: <20160317183715.GE11623@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 11:07:00AM -0700, Andrew Pinski wrote:
> On 3/17/2016 7:27 AM, Catalin Marinas wrote:
> >On Wed, Mar 16, 2016 at 10:26:08AM -0500, Timur Tabi wrote:
> >>Catalin Marinas wrote:
> >>>Why do you need your own defconfig? If it's just on the short term until
> >>>all your code is upstream, that's fine, but this goes against the single
> >>>Image aim. I would like defconfig to cover all supported SoCs (and yes,
> >>>ACPI on by default once we deem it !EXPERT anymore), though at some
> >>>point we may need a server/mobile split (if the generated image is too
> >>>large, maybe more stuff being built as modules).
> >>Yes, that's exactly it.  Ours is an ACPI system, and so we have to have our
> >>own defconfig for now.  We're holding off on pushing our own defconfig
> >>changes (enabling drivers, etc) until ACPI is enabled in
> >>arch/arm64/configs/defconfig.
> >Is there anything that prevents you from providing a dtb/dts for this
> >SoC?
> 
> Note ThunderX's SOC have customers  where some are embedded users (uboot)
> and server users (UEFI).  The cores always have 128 byte cacheline size.  So
> please don't make this dependent on ACPI. 

Definitely not, this has nothing to do with ACPI or servers. My comment
on different defconfig was more about things like 64K pages vs 4K, if
the former ever prove useful in practice. Who knows, we may even see
ACPI for IoT ;) (with MS involvement in Raspberry Pi)

> Note the defconfig works correctly on T88.

We have two aspects to address: one is correctness and the other is
performance. But we bundle everything under L1_CACHE_BYTES which affects
platforms that don't have such large cache lines (actually, it may even
affect those that do; has anyone done actual benchmarks?)

As Will suggested, we could try to revert L1_CACHE_BYTES back to 64 and
make ARCH_DMA_MINALIGN run-time based on CWG for correctness. Would this
work on the Cavium hardware?

-- 
Catalin

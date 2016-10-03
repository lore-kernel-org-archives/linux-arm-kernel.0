From: olof@lixom.net (Olof Johansson)
Date: Sun, 2 Oct 2016 22:57:14 -0700
Subject: [PATCH v3 2/2] ARM64: dts: bcm: Use a symlink to R-Pi dtsi files
 from arch=arm
In-Reply-To: <1471516926-11466-2-git-send-email-ijc@hellion.org.uk>
References: <1471516926-11466-1-git-send-email-ijc@hellion.org.uk>
 <1471516926-11466-2-git-send-email-ijc@hellion.org.uk>
Message-ID: <20161003055714.GA12261@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 11:42:06AM +0100, Ian Campbell wrote:
> The ../../../arm... style cross-references added by commit 9d56c22a7861
> ("ARM: bcm2835: Add devicetree for the Raspberry Pi 3.") do not work in the
> context of the split device-tree repository[0] (where the directory
> structure differs). As with commit 8ee57b8182c4 ("ARM64: dts: vexpress: Use
> a symlink to vexpress-v2m-rs1.dtsi from arch=arm") use symlinks instead.
> 
> [0] https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/
> 
> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: arm at kernel.org
> ---
> v2: No more need for skeleton.dtsi since this was cleaned up in the previous
>     patch
> v3: Collected tags

Hi,

I still think this is fundamentally the wrong approach. We shouldn't have
created these file links in the first place.

I'd rather have something like this in our tree:

arch/arm64/boot/dts/include/arm -> ../../../../arm/boot/dts
arch/arm64/boot/dts/include/arm64 -> ../..
arch/arm/boot/dts/include/arm64 -> ../../../../arm64/boot/dts
arch/arm/boot/dts/include/arm -> ../..


That way you can include by using <arm/bcm2835-rpi.dtsi> instead.

You'll populate another (or the same) directory with links as appropriate
in your out-of-tree version of the DT contents.

No more symlinked files, and still a clear way of showing that you're
referencing contents out of the other architecture.

Considerably cleaner, isn't it?


-Olof

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Apr 2014 19:12:52 +0100
Subject: [Qemu-devel] Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <20140422175325.GD23955@obsidianresearch.com>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
 <alpine.LFD.2.11.1404161853530.980@knanqh.ubzr>
 <53501E87.6070307@codeaurora.org>
 <20140417203521.GB22411@obsidianresearch.com> <535681A4.1080402@monstr.eu>
 <20140422171141.GW24070@n2100.arm.linux.org.uk>
 <20140422175325.GD23955@obsidianresearch.com>
Message-ID: <20140422181252.GX24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 11:53:25AM -0600, Jason Gunthorpe wrote:
> On Tue, Apr 22, 2014 at 06:11:42PM +0100, Russell King - ARM Linux wrote:
> 
> > Put another way, if your platform is part of the multi-platform kernel
> > then you are *excluded* from being able to use this... unless you hack
> > the Kconfig, and then also provide a constant value for PHYS_OFFSET,
> > thereby _tying_ the kernel you built to a _single_ platform.
> 
> That is exactly right. To get a fixed LMA you must commit to a
> non-relocatable kernel image.
> 
> Realistically this patch would need to be accompanied by something
> that makes ARM_PATCH_PHYS_VIRT optional for multiplatform based on
> EXPERT or similar.
> 
> The best usecase seems to be to support ELF tooling for low level
> debugging activities, a non-relocatable image isn't a blocker for that
> case.

Let's not forget that if you want to debug, it's because you've hit a
problem in the kernel you're running.  To get an ELF image you can debug,
you have to turn ARM_PATCH_PHYS_VIRT off, which changes the generated
code - which can in itself cause bugs to hide themselves.

Unfortunately, those kinds of bugs are not as rare as you might think.

> Since the patch is a no-op if LOAD_OFFSET isn't set, is there a
> downside I don't see?

It leads people into thinking that we support booting an ELF file.
We don't.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

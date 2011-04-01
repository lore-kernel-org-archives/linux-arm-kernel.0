From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 31 Mar 2011 19:29:48 -0500
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
In-Reply-To: <20110331053805.GB3523@b20223-02.ap.freescale.net>
References: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
	<20110330073651.GR7285@pengutronix.de>
	<AANLkTikf63wTfM1z2cpV+GuK28y1wrT7UWvw4TanBj4R@mail.gmail.com>
	<20110331053805.GB3523@b20223-02.ap.freescale.net>
Message-ID: <AANLkTi=pmdJDRnsde8FSd-ey8=n=uBA2QnhswEzM0ofV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2011 at 12:38 AM, Richard Zhao
<richard.zhao@freescale.com> wrote:
> On Wed, Mar 30, 2011 at 05:23:12PM -0500, Matt Sealey wrote:
>> Sascha,
>>
>> Freescale has a driver. We have a driver since we're under NDA and
>> have the source.
>>
>> In any case, this is a nice patch, it will help actually us in adding
>> it to a fork of the mainline tree for customers. I don't think it goes
>> far enough though: Richard, why no gpu_resource so GSL can allocate
>> memory,
>
> Do you mean the resource gpu_reserved_mem? By default, if gpu_reserved_mem
> is zero, gpu driver will use dma_alloc_xx to alloc max 16M memory. I have
> not work out a good way to upstream the reserve memory code yet.

Yeah sorry I did mean like mxc_adjust_mem or whatever it was called in
the BSP, that tweaked the value. The code I see in that is fine, and
we have an in-house DRM/GEM mapper for a the GPU resource.

As long as the size is set, we don't need start/end except to align it
to the GPU MMU boundary which means making sure the address is aligned
to.. 32MB windows? I think that was all that was complicated about it.
It can be any size.

The reason we fiddled with DRM/GEM is because in the BSP, it allocated
32MB for IPU and 32-64MB for the GPU, but it wasn't effectively
sharing the memory between devices (and they are kind of one and the
same fundamental unit - GPU is useless without IPU, and it makes no
sense to allocate the framebuffer in a place the GPU can be protected
from accessing..)

I think that's the problem you'd have to try and solve, right?

>> and why not setup the Z430 while you're at it?
> z430 does not need any other setup.

Okay, but the GPU memory was conceptually shared here so I might
nitpick about the naming: on the BSP it was called gpu2d/gpu3d or just
gpu_whatever. This makes more sense.. since it is shared between the
GPUs (texture memory and Xorg offscreen for our Xorg C2D driver) and
potentially the IPU (framebuffer, Xorg offscreen for FSL's libz160
driver) for all we know we get to some not-yet-planned MX54 which has
a Z180 in it (unlikely but who knows :) and then the naming convention
is wrong too..

>> I have a serious problem with the way the "new"
>> "imx_add_this_and_that" platform devices are done. Why is there so
>> much done in little helper functions and defines?
> It's a way to make device create dynamic.

How was mx53_loco_init_device or mxc_init_device as a *function* less dynamic?

I think the only possible problem is that stuff ends up in an
undesirable ELF section in the kernel (.bss instead of .text) and
static data hangs around if it's not properly set as __initdata (which
99.9% of this is).

Have you checked our Linux BSP modification? We split subsystem init
into seperate functions, IOMUX are done in individual files for
individual peripherals. (actually in all technically this should be
done as absolutely soon after boot - in the firmware - as possible,
but we never got round to it and RMK hates trusting the bootloader so
we didn't think it'd mainline to never configure IOMUX peripherals).
This was before there was mainline support for MX51 hit in 2.6.35. It
works, We get all our RAM for static data back after init, the devices
are easier to configure per-board where there are differences, and the
MX and SB devices (and any MX51 board, Babbage is barely different) is
absolutely common ground.

I admire moving "mxc.h" from the BSPs into seperate per-device files,
but then having a single-file board data (board-$name.h with $name.c)
defeats the modularization concept at  the start - because it is "like
every other ARM platform", I think the reasoning was..

BTW while we're talking about this, has anyone solved the problem
where make headers_install doesn't populate include/asm-arm/mach
properly - plat-mxc and mach-mx5 go together (as does every other
mach-mx? cpu directory) but plat-mxc/include/mach stuff is never coped
in. This is I think a fundamental kernel flaw, and I think RMK said it
may be a distribution foible they should be fixing.. I dunno what the
solution is here, but it makes building external modules a complete
pain in the backside as you need to extract full Linux source and make
prepare before you can build a module. On a system with an 8GB SSD or
a development board with only a MicroSD card to boot from it's a bit
of a chore to do that.. this is why distributions even on x86 ship
linux-headers and use that for dkms etc. rather than linux-source.

Until that's solved the AMD GPU source may as well be built seperately
and at least Genesi will just maintain an external patch to enable it
(hooray for kernel forks, boo for not upstreaming).

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.

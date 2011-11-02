From: balbi@ti.com (Felipe Balbi)
Date: Wed, 2 Nov 2011 21:48:28 +0200
Subject: [PATCH] arm/tegra: add support for tegra30 interrupts
In-Reply-To: <20111102193947.GD12913@n2100.arm.linux.org.uk>
References: <1320248292-22736-1-git-send-email-pdeschrijver@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A46E5@HQMAIL01.nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A4758@HQMAIL01.nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A47A7@HQMAIL01.nvidia.com>
	<20111102192112.GC12913@n2100.arm.linux.org.uk>
	<20111102192625.GD14372@legolas.emea.dhcp.ti.com>
	<20111102193947.GD12913@n2100.arm.linux.org.uk>
Message-ID: <20111102194827.GF14372@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 02, 2011 at 07:39:47PM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 02, 2011 at 09:26:26PM +0200, Felipe Balbi wrote:
> > would it be better to just change the default value in
> > arm-generic/gpio.h to something very large ?
> > 
> > I mean, ideally that wouldn't be gpio_desc wouldn't be an array anyway
> > right ?
> 
> You'll excuse me if I take this slightly personally.
> 
> You really can't expect me to say that I'm fine with a 6K growth in
> kernel size for something that not every platform needs if there's
> been objections to maybe a 128 byte growth for including the V:P
> patching code in the kernel by default.
> 
> Either we care about memory usage or we don't.  If we don't, lets get
> rid of offering ARM_PATCH_PHYS_VIRT in any configuration and always
> build with the dynamic V:P stuff enabled for the trivial cases.  I
> mean:
> 
>  config ARM_PATCH_PHYS_VIRT
> -	bool "Patch physical to virtual translations at runtime" if EMBEDDED
> +	bool
> 	default y
> 	depends on !XIP_KERNEL && MMU
> 	depends on !ARCH_REALVIEW || !SPARSEMEM

you forgot to comment on the fact that gpio_desc shouldn't be held in an
array. Any comments ?

What I mean is that, just like irq_descs, we should be able to allocate
them dynamically. Maybe, just like irq_descs, hold them in a radix tree
and maybe even have a matching API "gpio_alloc_descs()".

It's a pain, anyway, to keep track of GPIO base numbers, specially on
complex boards where you have gpio controllers which are internal to the
SoC and several others connected via e.g. I2C.

Most PHY chips for several I/O have some extra GPIOs which are generally
unused or hacked around (see tusb6010.c for example).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111102/6b0e1ae1/attachment-0001.sig>

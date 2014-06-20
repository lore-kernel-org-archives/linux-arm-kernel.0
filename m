From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Jun 2014 09:55:43 +0100
Subject: [PATCHv3 3/4] arm64: Update the Image header
In-Reply-To: <1403174963-10730-4-git-send-email-mark.rutland@arm.com>
References: <1403174963-10730-1-git-send-email-mark.rutland@arm.com>
 <1403174963-10730-4-git-send-email-mark.rutland@arm.com>
Message-ID: <20140620085543.GH25104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 11:49:22AM +0100, Mark Rutland wrote:
> Currently the kernel Image is stripped of everything past the initial
> stack, and at runtime the memory is initialised and used by the kernel.
> This makes the effective minimum memory footprint of the kernel larger
> than the size of the loaded binary, though bootloaders have no mechanism
> to identify how large this minimum memory footprint is. This makes it
> difficult to choose safe locations to place both the kernel and other
> binaries required at boot (DTB, initrd, etc), such that the kernel won't
> clobber said binaries or other reserved memory during initialisation.

[...]

> +/*
> + * There aren't any ELF relocations we can use to endian-swap values known only
> + * at link time (e.g. the subtraction of two symbol addresses), so we must get
> + * the linker to endian-swap certain values before emitting them.
> + */
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +#define DATA_LE64(data)					\
> +	((((data) & 0x00000000000000ff) << 56) |	\
> +	 (((data) & 0x000000000000ff00) << 40) |	\

Are you sure that these shifts are valid without a UL prefix on the first
constant operand? I don't think the leading zeroes promote the mask to a
64-bit type, so you end up shifting greater than the width of the type.

I guess the compiler doesn't allocate (data & 0xff) into a w register?

Will

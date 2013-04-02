From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Apr 2013 10:09:34 +0000
Subject: [GIT PULL v2] Renesas ARM-based SoC board updates for v3.10
In-Reply-To: <CANqRtoSBUt+G-GwBZ01FmOwgm3vp0_GYXBckOdEp-46A6G_LnA@mail.gmail.com>
References: <1363659481-5922-1-git-send-email-horms+renesas@verge.net.au>
 <201303271137.45652.arnd@arndb.de>
 <CANqRtoSBUt+G-GwBZ01FmOwgm3vp0_GYXBckOdEp-46A6G_LnA@mail.gmail.com>
Message-ID: <201304021009.35161.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 April 2013, Magnus Damm wrote:
> On Wed, Mar 27, 2013 at 8:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> > Ok, I see. If you think it's not likely to be ready for 3.12, we might
> > need to discuss again whether there is another way of making the
> > common clk and the sh-clk code coexist. For instance, we could rename
> > all if the sh/shmobile specific clk functions and their users from
> > clk_* to shclk_*, and provide a thin wrapper around them that integrates
> > into common clk.
> 
> Yeah, I am not sure if it is likely that we will be able to convert
> all platforms at v3.12 timing.
> 
> I actually tried to let common clocks and sh-clk coexist when the
> common clock framework was under heavy development. I recall it being
> far from trivial.
> 
> One possible way to develop this could be to force the mach-shmobile
> "reference DT" implementations use common clocks and keep the old
> boards as-is. Then we can also make sure the "reference DT"
> implementations can be used as CONFIG_ARCH_MULTIPLATFORM. So if we
> only have "reference DT" code as MULTIPLATFORM and then finally kill
> off the old board code one by one.

Works for me, but wouldn't that mean that half the shmobile boards
become incompatible with the other half, forcing you to build two
separate kernels if you want to run on all the machines?

Maybe that's not a problem for you, since you tend to have per-soc
defconfigs  anyway, and it will only be temporary.

> Since we're on the topic of CONFIG_ARCH_MULTIPLATFORM, do you have any
> recommendatoin about LPAE?
> 
> Judging by the ARM_LPAE help text it seems that selecting ARM_LPAE
> will result in a kernel only working on LPAE hardware:
> 
> config ARM_LPAE
> [snip]
>           Say Y if you have an ARMv7 processor supporting the LPAE page
>           table format and you would like to access memory beyond the
>           4GB limit. The resulting kernel image will not run on
>           processors without the LPA extension.
> 
> With the above text it sounds to me like we should not to a "select
> ARM_LPAE" on each board in the case of CONFIG_ARCH_MULTIPLATFORM.

Correct.

> I sort of expect LPAE to behave similar to x86 PAE. At least the board
> DT file should describe all physical memory available and depending on
> kernel configuration (HIGHMEM=y/n, LPAE=y/n) we get different amounts
> of usable memory in the kernel. Then if LPAE should be selected or not
> is something that the distributions have to decide.

Yes. I believe all distros are planning to build one non-LPAE nd one
LPAE kernel. There will have to be a way to enable all LPAE-capable
platforms in Kconfig, but I don't know if that exists already.

Presumably, the LPAE kernel will also be using THUMB2 in the kernel,
while the non-LPAE kernel may get built with ARMv6 platform support
enabled, which rules out THUMB2.

Also, we could enable KVM support in the non-LPAE kernel, but since 
all KVM capable CPU cores (Cortex-A7 and Cortex-A15) so far also
come with LPAE, that's not even necessary.

You can always use #address-cells=<2> in the DT root node if that
helps, and you can also keep your peripherals using #address-cells=<1>
with an appropriate ranges property in the soc bus node.

	Arnd

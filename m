From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Jan 2012 11:17:03 +0100
Subject: [RFC PATCH] ARM: new architecture for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <20120116174039.GD32049@n2100.arm.linux.org.uk>
References: <1324480428-13344-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CADMYwHzE0HeBKjA55ApQo0k5AW8+Za3kT8u5HnMorXEk4PQxjA@mail.gmail.com>
 <20120116162933.GG14252@pengutronix.de>
 <20120116174039.GD32049@n2100.arm.linux.org.uk>
Message-ID: <20120117101703.GH14252@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

I'm glad you're replying though my tree was just intended to show a
prove of concept, not a tree ready to be merged.

On Mon, Jan 16, 2012 at 05:40:39PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 16, 2012 at 05:29:33PM +0100, Uwe Kleine-K?nig wrote:
> > On Wed, Dec 21, 2011 at 07:31:56PM +0200, Ohad Ben-Cohen wrote:
> > > Hi Uwe,
> > > 
> > > 2011/12/21 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > > > If you're interested in the details I can publish my tree I think.
> > > 
> > > Definitely interested - it could be very nice if you can publish that tree.
> > OK, it's online now at
> > 
> > 	http://git.pengutronix.de/?p=ukl/linux-2.6.git;a=shortlog;h=refs/heads/efm32
> > 	git://git.pengutronix.de/git/ukl/linux.git efm32
> > 
> > Please note that this is work in progress and has some rough edges. ...
> > but at least it boots on my machine.
> 
> Some of your patches seem weird, like this:
> 
>         for (i = 0; i < ARRAY_SIZE(cache_policies); i++) {
> -               int len = strlen(cache_policies[i].policy);
> -
> -               if (memcmp(p, cache_policies[i].policy, len) == 0) {
> +               if (strcmp(p, cache_policies[i].policy) == 0) {
> 
> Please compare the two, specifically how many bytes of the strings in
> each case are compared.  I think you'll find it's not an equivalent
> change, and you need to discard the patch.
OK, so you say it is intended that I can do

	early_cachepolicy("writebackyourmother");

with the same result as

	early_cachepolicy("writeback");

? Maybe a comment would be great to have in place then about
why this is done. I couldn't find a user apart from

	early_param("cachepolicy", early_cachepolicy);

and this parameter isn't described in
Documentation/kernel-parameters.txt.

I would understand if only strlen(p) bytes were checked which would
allow to shorten the parameter. (But then

	cachepolicy=

would have a meaning (though I didn't test -- I think it would select
uncached) which is strange.) All in all I put the patch there as a
reminder for me to ask if everything the function does is intended.

> This looks buggy:
> +#if defined(CONFIG_CPU_V7M)
> +       .macro  setmode, mode, reg
> +       .endm
> +#elif defined(CONFIG_THUMB2_KERNEL)
>         .macro  setmode, mode, reg
>         mov     \reg, #\mode
>         msr     cpsr_c, \reg
> 
> as it does nothing about the interrupt mask.
right, good catch.

> The VFP stuff - adding 'clean' which is kernel state to the _user_
> _exported_ VFP hardware structure is a bad idea.  So this needlessly
> causes a variation in the kernels userspace API.  Please find somewhere
> else to keep kernel internal state.  (As that patch comes from Catalin,
> then that comment is directed to Catalin.)
> 
> In "mtd/maps: uclinux: fix sparse warnings and coding style":
> 
> -struct map_info uclinux_ram_map = {
> +static struct map_info uclinux_ram_map = {
>         .name = "RAM",
> -       .phys = (unsigned long)&_ebss,
> -       .size = 0,
> +       .phys = (resource_size_t)&_ebss,
> +       .bankwidth = 4,
> 
> This doesn't match the description - it's a functional change.  Basic rule
> of kernel patch generation: functional changes must _never_ _ever_, not in
I stumbled about that, too, but a deeper look shows that

	.bankwidth = 4,

was introduced in place of the removed

	mapp->bankwidth = 4;

in uclinux_mtd_init(). I didn't check the details because it's not my
patch and I don't intend (yet) to mainline it myself. (Marc: hint hint!)

> a million years, be mixed with such patches.
> 
> +       *virt = (__force void *)(map->virt + from);
> 
> This says "wrong" to me loudly - by the mere fact that you're using __force.
> If you're having to do that, leave the sparse warning in place.  Sparse is
> _not_ a tool which must produce zero warnings for kernel code.  Sparse is
> an auditing tool, and as such there are valid reasons to ignore warnings.
> This is one of them.
> 
> No driver should ever use __force within its code or definitions.  That
> priviledge is reserved for stuff like arch code inside IO accessors where
> it really knows that it's safe.
> 
> In "ARM: new architecture for ..." I expected to find a new arch/*
> directory.  What you mean is "new platform" or "new machine" not
> "new architecture".  Maybe "new sub-architecture".  Good to see you're
> selecting NO_IOPORT here though.
Yeah, I learned NO_IOPORT from the first post of the "new architecture"
patch :-)

> config CPU_V7M
>         bool "Support ARMv7-M processors"
> -       depends on MACH_REALVIEW_EB && EXPERIMENTAL
> +       depends on (MACH_REALVIEW_EB && EXPERIMENTAL) || ARCH_EFM32
>         select THUMB2_KERNEL
>         select ARM_THUMB
>         select CPU_32v7M
> 
> Ok, so EFM32 may or may not have a V7M CPU.  Cool.  What does it have
> when it doesn't have a V7M CPU?  (Please fix it, like all the other CPU
> stuff in this file, so that the prompt appears for those which _may_
> have it, but it's selected by those which must _always_ have it.)
Yeah, this was pointed out in the review of my first post, too. Didn't
come around yet to fix that.
 
> Your code in arch/arm/mach-efm32/include/mach/system.h won't be called
> as of this merge window - that's something you should consider fixing.
yeah, I'm aware of this change and intend to update the base when
3.3-rc1 is out.
 
> In your serial driver, you really need to deal with which modes you
> can't set sanely: ask Alan Cox how to do this.  POSIX has a requirement
> that termios modes which can't be set should be reported back.  (eg,
> if you can only do one stop bit, don't blindly ignore the request for
> two stop bits.)
Ah, I thought CSTOPB means "use 1 stop bit" but it seems to request 2.
Will fix and send out a v3.

Thanks for your time
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

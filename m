From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 30 Mar 2011 17:23:12 -0500
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
In-Reply-To: <20110330073651.GR7285@pengutronix.de>
References: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
	<20110330073651.GR7285@pengutronix.de>
Message-ID: <AANLkTikf63wTfM1z2cpV+GuK28y1wrT7UWvw4TanBj4R@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha,

Freescale has a driver. We have a driver since we're under NDA and
have the source.

If you want it and want to boot Ubuntu on a Smartbook or Smarttop, we
can give you a package that will run on our kernel and load the GPU
module if present (we actually ship it as a module built inside the
kernel, it's not external and it's dual BSD/GPL licensed). Regardless
of where you've not seen it, it does exist. I want this code in there
- on the basis that we have a consumer product that ships and needs
it, and this is going to be a dependency for OpenGL, OpenVG, and
things on top like Flash which may depend on that.

I dunno if I am in the "path" for this since I have the source code
for the driver for the kernel (it's on opensource.freescale.com/git in
drivers/mxc/amd-gpu somewhere after the 09.12 BSP ) and for the
userspace (it's NDA code) I don't believe there's any hard and fast
policy that says the kernel cannot have drivers referenced that are
not part of the mainline stack, otherwise no external module using USB
or any other pluggable module built externally, which Linus does not
disapprove of, would never be allowed to build against the kernel.

What's the harm in allowing a reference for a reserved memory space or
IRQ for an SoC module to be instantiated in the kernel? Without
reserving the memory space, you can't set up the GPU in any fashion
since it in all technically needs to be configured to only be able to
talk to this reserved resource to allocate texture memory. You kind of
want it to be set up right. The setup is an opensource driver that
only didn't get into mainline because the DRM guys (wrongly) expect
that any kernel source code linked via ioctl or syscall to userspace
makes the userspace a derivative work, and didn't want to go there
(Linus has specifically stated very recently this is completely
false).

.. so Richard can pick one of these as I heartily approve of this
being in there if it goes in.

Acked-by: Matt Sealey <matt@genesi-usa.com>
Signed-off-by: Matt Sealey <matt@genesi-usa.com>

Of course the real solution is make the driver for the IPU, GPU etc.
into a DRM/GEM intead of
weird-framebuffer-and-crazy-resource-allocation, but that wouldn't fix
the DRM guys whining.

In any case, this is a nice patch, it will help actually us in adding
it to a fork of the mainline tree for customers. I don't think it goes
far enough though: Richard, why no gpu_resource so GSL can allocate
memory, and why not setup the Z430 while you're at it? And the sole
nitpick, Uwe noticed that the argument passed as an "soc id" to the
imx_mxc_gpu_entry_3d_2d "function".

I have a serious problem with the way the "new"
"imx_add_this_and_that" platform devices are done. Why is there so
much done in little helper functions and defines?

The "old" way where you had a static definition for one chip, then
overwrote the data if cpu_is_mx53() was true, was better and more
flexible and doesn't need these hacks. The platform definitions don't
change, and if you're going to create a define for it, why not a REAL
function that can set up the data instead of it taking an argument?
Are we really considering that in the case of initializing the board,
inlining it by using #define this_helper_function is far more useful
than bool this_helper_function(args) (or void
this_helper_function(void))? That somehow doing it in an undebuggable
optimized chain of garbage you have to pick apart inside a
disassembler, is more fun than just following function calls and
having a *real useful* backtrace on an oops instead of
"mx51_efikamx_init()" and an offset?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.



On Wed, Mar 30, 2011 at 2:36 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Mar 30, 2011 at 02:05:28PM +0800, Richard Zhao wrote:
>> From: Richard Zhao <richard.zhao@linaro.org>
>>
>> Add mxc_gpu devices for imx35/50/51/53, so external gpu driver module built
>> for the kernel can work.
>
> Why do we need this? I have never seen a driver for this.
>
> Sascha
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

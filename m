From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Feb 2013 12:37:55 +0800
Subject: [PATCH] kbuild: create an "include chroot" for DT bindings
In-Reply-To: <1361394356-19385-1-git-send-email-swarren@wwwdotorg.org>
References: <1361394356-19385-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130221043751.GB17738@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 02:05:56PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The recent dtc+cpp support allows header files and C pre-processor
> defines/macros to be used when compiling device tree files. These
> headers will typically define various constants that are part of the
> device tree bindings.
> 
> The original patch which set up the dtc+cpp include path only considered
> using those headers from device tree files. However, they are also
> useful for kernel code which needs to interpret the device tree.
> 
> In both the DT files and the kernel, I'd like to include the DT-related
> headers in the same way, for example, <dt-bindings/gpio/tegra-gpio.h>.
> That will simplify any text which discusses the DT header locations.
> 
> Creating a <dt-bindings/> for kernel source to use is as simple as
> placing files into include/dt-bindings/.
> 
> However, when compiling DT files, the include path should be restricted
> so that only the dt-bindings path is available; arbitrary kernel headers
> shouldn't be exposed. For this reason, create a specific include
> directory for use by dtc+cpp, and symlink dt-bindings from there to the
> actual location of include/dt-bindings/. For want of a better location,
> place this "include chroot" into the existing dts/ directory.
> 
> arch/*/boot/dts/include/dt-bindings -> ../../../../../dt-bindings

../../../../../include/dt-bindings

And, I would expect only the headers that will actually be referenced
by kernel should go into include/dt-bindings.  There is no point to
put headers that will not be included by kernel but only by dts files
into there, and instead arch/arm/boot/dts/include should just be good
enough for them.  With this agreed ...

> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> Cc: Hiroshi Doyu <hdoyu@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> You can find an example of how this would be used at
> git://nv-tegra.nvidia.com/user/swarren/linux-2.6 linux-next_common
> (note: there's a bunch of other cruft in that branch too)
> 
>  arch/arm/boot/dts/include/dt-bindings |    1 +
>  scripts/Makefile.lib                  |    3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  create mode 120000 arch/arm/boot/dts/include/dt-bindings
> 
> diff --git a/arch/arm/boot/dts/include/dt-bindings b/arch/arm/boot/dts/include/dt-bindings
> new file mode 120000
> index 0000000..08c00e4
> --- /dev/null
> +++ b/arch/arm/boot/dts/include/dt-bindings
> @@ -0,0 +1 @@
> +../../../../../include/dt-bindings
> \ No newline at end of file
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 07125e6..d6c5036 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -157,8 +157,7 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
>  ld_flags       = $(LDFLAGS) $(ldflags-y)
>  
>  dtc_cpp_flags  = -Wp,-MD,$(depfile) -nostdinc                            \
> -		 -I$(srctree)/arch/$(SRCARCH)/boot/dts                   \
> -		 -I$(srctree)/arch/$(SRCARCH)/include/dts                \
> +		 -I$(srctree)/arch/$(SRCARCH)/boot/dts/include           \
>  		 -undef -D__DTS__
>  
>  # Finds the multi-part object the current object will be linked into
> -- 
> 1.7.10.4
> 

From: npiggin@gmail.com (Nicholas Piggin)
Date: Sat, 18 Nov 2017 13:21:39 +1000
Subject: [v2,12/18] kbuild: add support for clang LTO
In-Reply-To: <20171115213428.22559-13-samitolvanen@google.com>
References: <20171115213428.22559-13-samitolvanen@google.com>
Message-ID: <20171118132139.58ac5e4c@roar.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Nov 2017 13:34:22 -0800
Sami Tolvanen <samitolvanen@google.com> wrote:

> This change adds the configuration option CONFIG_LTO_CLANG, and
> build system support for clang's Link Time Optimization (LTO). In
> preparation for LTO support for other compilers, potentially common
> parts of the changes are gated behind CONFIG_LTO instead.
> 
> With -flto, instead of object files, clang produces LLVM bitcode,
> which is compiled into a native object at link time, allowing the
> final binary to be optimized globally. For more details, see:
> 
>   https://llvm.org/docs/LinkTimeOptimization.html
> 
> While the kernel normally uses GNU ld for linking, LLVM supports LTO
> only with lld or GNU gold linkers. This patch set assumes gold will
> be used with the LLVMgold plug-in to perform the LTO link step. Due
> to potential incompatibilities with GNU ld, this change also adds
> LDFINAL_vmlinux for using a different linker for the vmlinux_link
> step, and defaults to using GNU ld.
> 
> Assuming LLVMgold.so is in LD_LIBRARY_PATH and CONFIG_LTO_CLANG has
> been selected, an LTO kernel can be built simply by running make
> CC=clang. Recommended versions are >= 5.0 for clang, and >= 2.27 for
> binutils.

Do you have any kind of numbers for this, out of curiosity? Binary
size, performance, build time?

Also

> @@ -585,6 +585,7 @@ config CC_STACKPROTECTOR_STRONG
>  endchoice
>  
>  config THIN_ARCHIVES
> +	depends on !LTO_CLANG
>  	def_bool y
>  	help
>  	  Select this if the architecture wants to use thin archives

Why is this needed? It would have been nice to get rid of the
!THIN_ARCHIVES option if you can make the patches work with the
thin archives paths.

Thanks,
Nick

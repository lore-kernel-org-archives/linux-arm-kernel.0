From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Nov 2017 11:58:11 +0000
Subject: [PATCH v2 18/18] arm64: select ARCH_SUPPORTS_LTO_CLANG
In-Reply-To: <20171115213428.22559-19-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-19-samitolvanen@google.com>
Message-ID: <20171116115810.GH9361@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sami,

On Wed, Nov 15, 2017 at 01:34:28PM -0800, Sami Tolvanen wrote:
> Allow CONFIG_LTO_CLANG to be enabled for the architecture.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3a70f763e18a..58504327b9f6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -40,6 +40,7 @@ config ARM64
>  	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPT
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select ARCH_USE_QUEUED_RWLOCKS
> +	select ARCH_SUPPORTS_LTO_CLANG

I'll be honest with you: I'm absolutely terrified about enabling this.
How much testing has this seen?

The main thing that worries me is that this gives the toolchain a lot
more freedom to break dependency ordering with RCU, leading to subtle
concurrency issues that would actually break on arm64. Specifically,
I'm worried about value analysis that could potentially convert an
address dependency into a control dependency. Right now, the C standard
isn't on our side here and we're relying on the compiler not doing this
kind of thing. Can we continue to rely on that in the face of LTO?

Will

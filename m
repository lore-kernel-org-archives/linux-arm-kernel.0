From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Apr 2018 13:56:54 +0100
Subject: [PATCH] boot-wrapper-aarch64: Do not hardcode TEXT_LIMIT
In-Reply-To: <1524661564-8789-1-git-send-email-suzuki.poulose@arm.com>
References: <1524661564-8789-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180426125654.4t7qcz7nfq2oxhzk@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 02:06:04PM +0100, Suzuki K Poulose wrote:
> We hard code TEXT_LIMIT to check for image overflow, assuming the memory
> is always at 0x80000000, which may not always be true. Instead use the
> offset from the PHYS_OFFSET, which is actually dependent on the DT.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Applied, thanks!

Mark.

> ---
>  Makefile.am | 4 ++--
>  model.lds.S | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 49cfa84..6940a99 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -75,11 +75,11 @@ endif
>  if KERNEL_32
>  MBOX_OFFSET	:= 0x7ff8
>  KERNEL_OFFSET	:= 0x8000
> -TEXT_LIMIT	:= 0x80003000
> +TEXT_LIMIT	:= 0x3000
>  else
>  MBOX_OFFSET	:= 0xfff8
>  KERNEL_OFFSET	:= 0x80000
> -TEXT_LIMIT	:= 0x80080000
> +TEXT_LIMIT	:= 0x80000
>  endif
>  
>  LD_SCRIPT	:= model.lds.S
> diff --git a/model.lds.S b/model.lds.S
> index 511f552..370ff56 100644
> --- a/model.lds.S
> +++ b/model.lds.S
> @@ -76,5 +76,5 @@ SECTIONS
>  		QUAD(0x0)
>  	}
>  
> -	ASSERT(etext <= TEXT_LIMIT, ".text overflow!")
> +	ASSERT(etext <= (PHYS_OFFSET + TEXT_LIMIT), ".text overflow!")
>  }
> -- 
> 2.7.4
> 

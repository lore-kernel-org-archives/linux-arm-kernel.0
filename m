From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 2 Aug 2018 11:52:17 +0100
Subject: [PATCH 2/6] ARM: vfp: use __copy_from_user() when restoring VFP
 state
In-Reply-To: <E1fctOq-0005us-Ar@rmk-PC.armlinux.org.uk>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
 <E1fctOq-0005us-Ar@rmk-PC.armlinux.org.uk>
Message-ID: <a2e8fb09-28c9-51cb-ce2a-081eb1a80820@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 10/07/18 15:13, Russell King wrote:
> Use __copy_from_user() rather than __get_user_err() for individual
> members when restoring VFP state.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>   arch/arm/include/asm/thread_info.h |  2 +-
>   arch/arm/kernel/signal.c           | 20 ++++++++------------
>   arch/arm/vfp/vfpmodule.c           | 16 +++++++---------
>   3 files changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index e71cc35de163..341f6eb9b8be 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -123,7 +123,7 @@ struct user_vfp_exc;
>   
>   extern int vfp_preserve_user_clear_hwstate(struct user_vfp __user *,
>   					   struct user_vfp_exc __user *);
> -extern int vfp_restore_user_hwstate(struct user_vfp __user *,
> +extern int vfp_restore_user_hwstate(struct user_vfp *,
>   				    struct user_vfp_exc __user *);


Just a small nit. With this patch, shouldn't the struct user_vfp_exc 
argument lose the __user tag for this function?

Cheers,

-- 
Julien Thierry

From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Sun, 19 Feb 2017 02:58:09 +0100
Subject: [PATCH] arm64: traps: Mark __le16, __le32, __user variables
 properly
In-Reply-To: <20170217165112.17512-1-stephen.boyd@linaro.org>
References: <20170217165112.17512-1-stephen.boyd@linaro.org>
Message-ID: <20170219015808.2vc2kvpde7nlrey4@macbook.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 08:51:12AM -0800, Stephen Boyd wrote:
> Sparse complains a bit on this file about endian issues and
> __user casting:
> 
> arch/arm64/kernel/traps.c:87:37: warning: incorrect type in argument 1 (different address spaces)
> arch/arm64/kernel/traps.c:87:37:    expected void const volatile [noderef] <asn:1>*<noident>
> arch/arm64/kernel/traps.c:87:37:    got unsigned long *<noident>
> arch/arm64/kernel/traps.c:116:23: warning: incorrect type in argument 1 (different address spaces)
> arch/arm64/kernel/traps.c:116:23:    expected void const volatile [noderef] <asn:1>*<noident>
> arch/arm64/kernel/traps.c:116:23:    got unsigned int [usertype] *

The fact that __get_user() can and is used for both __kernel & __user pointers
defeat any sensible annotation. The proper way would be to have a special
version of __get_user() which would ignore the __user part of the pointer,
something like "__get_user_but_accept_any_pointer()" ...


> arch/arm64/kernel/traps.c:346:25: warning: cast to restricted __le16
> arch/arm64/kernel/traps.c:352:34: warning: cast to restricted __le16
> arch/arm64/kernel/traps.c:359:25: warning: cast to restricted __le32

Your patch looked correct to me for those.
 
> Mark the types appropriately, and force the cast in get_user()
> when assigning to 0 so sparse doesn't complain.
I didn't looked deeply at this one but I don't think it is needed.
Care to give more details?


> Noticed while making other changes to this file. There are other issues still
> about marking symbols static, but I'm not sure we want to introduce another
> header file for the asmlinkage functions?
Probably not, indeed.

> arch/arm64/kernel/traps.c:567:10: warning: Initializer entry defined twice
> arch/arm64/kernel/traps.c:568:10:   also defined here
This one I find strange. Can you tell which are those two entries?

 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 46da3ea638bb..2f5b4ae98ee0 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -287,7 +287,7 @@ do {									\
>  	might_fault();							\
>  	access_ok(VERIFY_READ, __p, sizeof(*__p)) ?			\
>  		__get_user((x), __p) :					\
> -		((x) = 0, -EFAULT);					\
> +		((x) = (__force __typeof__(*(ptr)))0, -EFAULT);		\
>  })

As said above, this one is dubious.


Luc Van Oostenryck

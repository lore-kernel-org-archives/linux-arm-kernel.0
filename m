From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 May 2013 15:59:01 +0200
Subject: [PATCH v2 07/10] powerpc: uaccess s/might_sleep/might_fault/
In-Reply-To: <2aa6c3da21a28120126732b5e0b4ecd6cba8ca3b.1368702323.git.mst@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <2aa6c3da21a28120126732b5e0b4ecd6cba8ca3b.1368702323.git.mst@redhat.com>
Message-ID: <201305221559.01806.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 May 2013, Michael S. Tsirkin wrote:
> @@ -178,7 +178,7 @@ do {                                                                \
>         long __pu_err;                                          \
>         __typeof__(*(ptr)) __user *__pu_addr = (ptr);           \
>         if (!is_kernel_addr((unsigned long)__pu_addr))          \
> -               might_sleep();                                  \
> +               might_fault();                                  \
>         __chk_user_ptr(ptr);                                    \
>         __put_user_size((x), __pu_addr, (size), __pu_err);      \
>         __pu_err;                                               \
> 

Another observation:

	if (!is_kernel_addr((unsigned long)__pu_addr))
		might_sleep();

is almost the same as

	might_fault();

except that it does not call might_lock_read().

The version above may have been put there intentionally and correctly, but
if you want to replace it with might_fault(), you should remove the
"if ()" condition.

	Arnd

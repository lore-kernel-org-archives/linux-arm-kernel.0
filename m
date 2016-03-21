From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Mar 2016 10:43:48 +0100
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <mvmoaa8dwre.fsf@hawking.suse.de>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <20160318154918.GA1595@yury-N73SV> <mvmoaa8dwre.fsf@hawking.suse.de>
Message-ID: <6653982.FK62mVSCZO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 March 2016 10:07:49 Andreas Schwab wrote:
> This patch may fix a few LTP tests.
> 

Thanks for analyzing.

> diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/fcntl.h b/sysdeps/unix/sysv/linux/aarch64/bits/fcntl.h
> index 3631903..d1010db 100644
> --- a/sysdeps/unix/sysv/linux/aarch64/bits/fcntl.h
> +++ b/sysdeps/unix/sysv/linux/aarch64/bits/fcntl.h
> @@ -25,18 +25,29 @@
>  #define __O_NOFOLLOW	0100000
>  #define __O_DIRECT	0200000
>  
> -#define __O_LARGEFILE	0
> +#ifdef __ILP32__
> +# define __O_LARGEFILE	0400000
> +#else
> +# define __O_LARGEFILE	0
> +#endif
>  

I guess this means I screwed up when I said I'd merged the kernel patch
that Yury did to fix it, sorry about that.

We need the patch to make all new architecture in the kernel default to
O_LARGEFILE, and not do this in user space. I'd suggest now to keep the
patches as part of the ILP32 series after all, to make sure they are
merged at the point when they are needed.

> +#ifndef __ILP32__
>  # define F_GETLK64	5
>  # define F_SETLK64	6
>  # define F_SETLKW64	7
> +#endif
>  
>  struct flock
>    {
>      short int l_type;	/* Type of lock: F_RDLCK, F_WRLCK, or F_UNLCK.	*/
>      short int l_whence;	/* Where `l_start' is relative to (like `lseek').  */
> +#ifndef __USE_FILE_OFFSET64
>      __off_t l_start;	/* Offset where the lock begins.  */
>      __off_t l_len;	/* Size of the locked area; zero means until EOF.  */
> +#else
> +    __off64_t l_start;	/* Offset where the lock begins.  */
> +    __off64_t l_len;	/* Size of the locked area; zero means until EOF.  */
> +#endif
>      __pid_t l_pid;	/* Process holding the lock.  */
>    };

This looks like there is another bug as well, but I think this is in
libc, not in the kernel. I'm sure we had discussed this at some point
but I forgot what the outcome was. Defining 'struct flock' to have a
32-bit l_start and l_len member cannot be right if the kernel only
supports 64-bit offsets.

My guess is that the libc should either not define __off_t at all for
ILP32, and always use __off64_t in struct flock, or __off_t should
be defined as __kernel_loff_t a.k.a. long long so the #ifdef can be
avoided.

What exactly do you need to define F_GETLK64 for on LP64?

	Arnd

From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 21 Mar 2016 21:40:12 +0300
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <mvmoaa8dwre.fsf@hawking.suse.de>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <56AB3805.1040308@huawei.com> <20160129170929.GA3543@yury-N73SV>
 <56AC38F1.2030608@huawei.com> <20160218223506.GA7816@yury-N73SV>
 <mvm8u29ukqw.fsf@hawking.suse.de>
 <20160225202855.GD16123@yury-N73SV> <56EBD84D.2060009@huawei.com>
 <20160318154918.GA1595@yury-N73SV>
 <mvmoaa8dwre.fsf@hawking.suse.de>
Message-ID: <20160321184012.GA26563@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 10:07:49AM +0100, Andreas Schwab wrote:
> This patch may fix a few LTP tests.
> 
> Andreas.
> 
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
>  
> -- 
> 2.7.3
> 
> -- 
> Andreas Schwab, SUSE Labs, schwab at suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."

Hi Andreas,

Thank you for your patch. It seems like it fixed a couple of tests.
I applied it to the library branch. Current list of fails is like this:
float_bessel                   FAIL       137
float_exp_log                  FAIL       137
float_iperb                    FAIL       137
float_power                    FAIL       137
float_trigo                    FAIL       137
pipeio_3                       FAIL       5
abort01                        FAIL       2
clone02                        FAIL       4
kill10                         FAIL       2
kill11                         FAIL       2
mmap16                         FAIL       6
nftw01                         FAIL       1
nftw6401                       FAIL       1
open12                         FAIL       2
pathconf01                     FAIL       1
profil01                       FAIL       1
rename11                       FAIL       2
rmdir02                        FAIL       2
umount2_01                     FAIL       2
umount2_02                     FAIL       2
umount2_03                     FAIL       2
utime06                        FAIL       2
mtest06                        FAIL       11

Yury.

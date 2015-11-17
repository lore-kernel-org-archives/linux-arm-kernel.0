From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 23:14:25 +0100
Subject: [PATCH v6 06/19] arm64:ilp32: share signal structures between
 ILP32 and LP64 ABIs
In-Reply-To: <1447795019-30176-7-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-7-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <5805597.NtPXVqS0W3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 November 2015 00:16:46 Yury Norov wrote:
> 
> +/* For ILP32, sigset should be the same size fields as LP64 so use
> +   unsigned long long. */
> +#ifdef __ILP32__
> +#define __SIGSET_INNER_TYPE __extension__ unsigned long long
> +#define _NSIG_BPW 64
> +
> +# ifdef __AARCH64EB__
> +#  define __SIGNAL_INNER(type, field)          \
> +       __extension__ struct {                  \
> +               int __pad_##field;              \
> +               type field;                     \
> +       } __attribute__((aligned(8)))
> +# else
> +#  define __SIGNAL_INNER(type, field)          \
> +       __extension__ struct {                  \
> +               type field;                     \
> +               int __pad_##field;              \
> +       } __attribute__((aligned(8)))
> +# endif
> +
> +# define __SIGACTION_HANDLER(field)            \
> +       __SIGNAL_INNER(__sighandler_t, field)
> +
> +#define __SIGACTION_FLAGS(field)               \
> +       __extension__ unsigned long long field
> +
> +#define __SIGACTION_RESTORER(field)            \
> +       __SIGNAL_INNER(__sigrestore_t, field)
> +
> +#endif

Ah, I missed that in the comments for patch 14. I would think that
it makes sense to share siginfo_t with the 64-bit version, when the
normal compat_siginfo_t doesn't work, but I see no point in
changing compat_sigset_t: There is nothing architecture specific
in that, so you can just use the arm32 version of that, which simplifies
both the kernel and libc sides.

	Arnd

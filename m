From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Dec 2011 21:33:16 +0000
Subject: [PATCHv5] atomic: add *_dec_not_zero
In-Reply-To: <1323013369-29691-1-git-send-email-sven@narfation.org>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
Message-ID: <20111204213316.GB14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 04, 2011 at 04:42:49PM +0100, Sven Eckelmann wrote:
> diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/tile/include/asm/atomic_32.h b/arch/tile/include/asm/atomic_32.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> diff --git a/arch/tile/include/asm/atomic_64.h b/arch/tile/include/asm/atomic_64.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)

I think this is rather silly - all these definitions are very similar to
each other.  Is there really no way to put this into include/linux/atomic.h,
maybe as something like:

#ifndef atomic64_dec_not_zero
#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
#endif

and avoid having to add essentially the same definition to 12 individual
files?

Architectures which want to override it can do by the following:

#define atomic64_dec_not_zero		atomic64_dec_not_zero

which won't have any effect on C nor asm code.

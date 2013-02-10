From: oleg@redhat.com (Oleg Nesterov)
Date: Sun, 10 Feb 2013 19:42:09 +0100
Subject: [PATCH v5 05/45] percpu_rwlock: Make percpu-rwlocks IRQ-safe,
 optimally
In-Reply-To: <20130122073400.13822.52336.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073400.13822.52336.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130210184209.GA3041@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

only one cosmetic nit...

On 01/22, Srivatsa S. Bhat wrote:
>
> +#define READER_PRESENT		(1UL << 16)
> +#define READER_REFCNT_MASK	(READER_PRESENT - 1)
> +
>  #define reader_uses_percpu_refcnt(pcpu_rwlock, cpu)			\
>  		(ACCESS_ONCE(per_cpu(*((pcpu_rwlock)->reader_refcnt), cpu)))
>
>  #define reader_nested_percpu(pcpu_rwlock)				\
> -			(__this_cpu_read(*((pcpu_rwlock)->reader_refcnt)) > 1)
> +	(__this_cpu_read(*((pcpu_rwlock)->reader_refcnt)) & READER_REFCNT_MASK)
>
>  #define writer_active(pcpu_rwlock)					\
>  			(__this_cpu_read(*((pcpu_rwlock)->writer_signal)))

I think this all can go to lib/percpu-rwlock.c. Nobody needs to know
these implementation details.

Oleg.

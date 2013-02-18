From: walken@google.com (Michel Lespinasse)
Date: Mon, 18 Feb 2013 23:51:41 +0800
Subject: [PATCH v6 07/46] percpu_rwlock: Allow writers to be readers, and
 add lockdep annotations
In-Reply-To: <20130218123913.26245.7713.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123913.26245.7713.stgit@srivatsabhat.in.ibm.com>
Message-ID: <CANN689Ec4g7jMapv8ChAEom+gEDQ8RDVLa07CKwJ==YO+MUUrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 8:39 PM, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> @@ -200,6 +217,16 @@ void percpu_write_lock_irqsave(struct percpu_rwlock *pcpu_rwlock,
>
>         smp_mb(); /* Complete the wait-for-readers, before taking the lock */
>         write_lock_irqsave(&pcpu_rwlock->global_rwlock, *flags);
> +
> +       /*
> +        * It is desirable to allow the writer to acquire the percpu-rwlock
> +        * for read (if necessary), without deadlocking or getting complaints
> +        * from lockdep. To achieve that, just increment the reader_refcnt of
> +        * this CPU - that way, any attempt by the writer to acquire the
> +        * percpu-rwlock for read, will get treated as a case of nested percpu
> +        * reader, which is safe, from a locking perspective.
> +        */
> +       this_cpu_inc(pcpu_rwlock->rw_state->reader_refcnt);

I find this quite disgusting, but once again this may be because I
don't like unfair recursive rwlocks.

In my opinion, the alternative of explicitly not taking the read lock
when one already has the write lock sounds *much* nicer.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.

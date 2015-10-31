From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 31 Oct 2015 17:30:49 +0100
Subject: [PATCH] arm: spinlock: const qualify read-only functions
In-Reply-To: <1446079665-25366-1-git-send-email-icoolidge@google.com>
References: <1446079665-25366-1-git-send-email-icoolidge@google.com>
Message-ID: <CAKv+Gu_XL0mB25=PdNBfkaCB6XAWodKUd9Q+moTOfuZqfRGzYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 October 2015 at 01:47, Ian Coolidge <icoolidge@google.com> wrote:
> This allows assert_spin_locked() to be used against
> spinlocks that are const qualified.
>
> Signed-off-by: Ian Coolidge <icoolidge@google.com>
> ---
>  arch/arm/include/asm/spinlock.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
> index 0fa4184..3512d2d 100644
> --- a/arch/arm/include/asm/spinlock.h
> +++ b/arch/arm/include/asm/spinlock.h
> @@ -113,17 +113,17 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
>         dsb_sev();
>  }
>
> -static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> +static inline int arch_spin_value_unlocked(const arch_spinlock_t lock)

In this case, 'lock' is passed by value, so there is really no point
in constifying it.

>  {
>         return lock.tickets.owner == lock.tickets.next;
>  }
>
> -static inline int arch_spin_is_locked(arch_spinlock_t *lock)
> +static inline int arch_spin_is_locked(const arch_spinlock_t *lock)
>  {
>         return !arch_spin_value_unlocked(READ_ONCE(*lock));
>  }
>
> -static inline int arch_spin_is_contended(arch_spinlock_t *lock)
> +static inline int arch_spin_is_contended(const arch_spinlock_t *lock)
>  {
>         struct __raw_tickets tickets = READ_ONCE(lock->tickets);
>         return (tickets.next - tickets.owner) > 1;

For these remaining cases, the 'const' only enforces that these
functions may not change the state of the lock. I think this is of
limited value for single-line static inline functions such as these.

Could you explain your use case? Do you have code that only has access
to constified references to arch_spinlock_t instances?

-- 
Ard.

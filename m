From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Mar 2012 14:40:01 +0000
Subject: spinlock_t and tagged memory block size
In-Reply-To: <CABcrWnUQ_4-nrZkt_zw5VC=cYJBfmaPsU7ktjMf2=xk7+=PArQ@mail.gmail.com>
References: <CABcrWnUQ_4-nrZkt_zw5VC=cYJBfmaPsU7ktjMf2=xk7+=PArQ@mail.gmail.com>
Message-ID: <CAHkRjk4mu-LCEscGN_mN0R1J7LHsTUFNx519qnjt1tNuL4dnfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 March 2012 11:44, Rui Sousa <rui.p.m.sousa@gmail.com> wrote:
> Cortex-A9 architecture defines the minimum size of tagged memory block
> (used on load/store exclusives) to be 2^3 = 8bytes (Cortex A9 r2p2,
> Technical Reference Manual, page 4-8).
> However, the spinlock_t structure size (if preemption and spinlock
> debug options are all disabled) is only 4bytes.
> AFAICS, this will break spinlocks if two spinlocks are linked next to
> each other. Am I right, or did I miss something?

It won't break, only that if two CPUs try to acquire the different
locks at the same time, only one will succeed the first time, the
other will need to go through the LDREX/STREX loop once more.

-- 
Catalin

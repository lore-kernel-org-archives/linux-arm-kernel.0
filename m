From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Sep 2011 17:53:38 +0100
Subject: [PATCH] Optimize multi-CPU tlb flushing a little more
In-Reply-To: <20110823110602.GG19622@n2100.arm.linux.org.uk>
References: <20110823110602.GG19622@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk5ZdgFY2TyGOj9jqGnwJw3zyQp7HtrQKL9MTvE_6uJ-Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 August 2011 12:06, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> The compiler does not conditionalize the assembly instructions for
> the tlb operations, which leads to sub-optimal code being generated
> when building a kernel for multiple CPUs.
>
> We can tweak things fairly simply as the code fragment below shows:
>
> ? ?17f8: ? ? ? e3120001 ? ? ? ?tst ? ? r2, #1 ?; 0x1
> ...
> ? ?1800: ? ? ? 0a000000 ? ? ? ?beq ? ? 1808 <handle_pte_fault+0x194>
> ? ?1804: ? ? ? ee061f10 ? ? ? ?mcr ? ? 15, 0, r1, cr6, cr0, {0}
> ? ?1808: ? ? ? e3120004 ? ? ? ?tst ? ? r2, #4 ?; 0x4
> ? ?180c: ? ? ? 0a000000 ? ? ? ?beq ? ? 1814 <handle_pte_fault+0x1a0>
> ? ?1810: ? ? ? ee081f36 ? ? ? ?mcr ? ? 15, 0, r1, cr8, cr6, {1}
> becomes:
> ? ?17f0: ? ? ? e3120001 ? ? ? ?tst ? ? r2, #1 ?; 0x1
> ? ?17f4: ? ? ? 1e063f10 ? ? ? ?mcrne ? 15, 0, r3, cr6, cr0, {0}
> ? ?17f8: ? ? ? e3120004 ? ? ? ?tst ? ? r2, #4 ?; 0x4
> ? ?17fc: ? ? ? 1e083f36 ? ? ? ?mcrne ? 15, 0, r3, cr8, cr6, {1}

We need to be careful in this area if a conditional TLB operation is
not supported by the hardware. Conditional undefined instructions may
trigger an undef abort even if the condition fails (though I think
that's the case only on a Qualcomm implementation, but you never know
in the future).

IIUC, with your patch we could get some conditional inner shareable
TLB maintenance on a UP implementation which doesn't have such
operation.

-- 
Catalin

From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 11 Sep 2015 16:56:27 +0200
Subject: [PATCH 2/2] ARM: domains: add memory dependencies to
 get_domain/set_domain
In-Reply-To: <E1ZaL45-0003fs-1k@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Fri, 11 Sep 2015 10:56:17 +0100")
References: <20150911095438.GL21084@n2100.arm.linux.org.uk>
 <E1ZaL45-0003fs-1k@rmk-PC.arm.linux.org.uk>
Message-ID: <87si6lt36s.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> We need to have memory dependencies on get_domain/set_domain to avoid
> the compiler over-optimising these inline assembly instructions.
>
> Loads/stores must not be reordered across a set_domain(), so introduce
> a compiler barrier for that assembly.
>
> The value of get_domain() must not be cached across a set_domain(), but
> we still want to allow the compiler to optimise it away.  Introduce a
> dependency on current_thread_info()->cpu_domain to avoid this; the new
> memory clobber in set_domain() should therefore cause the compiler to
> re-load this.  The other advantage of using this is we should have its
> address in the register set already, or very soon after at most call
> sites.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

The test is failing without these 2 patches, while with them, an unaligned
access is fixed, and the generated code looks good :
     7ac:       ee13cf10        mrc     15, 0, ip, cr3, cr0, {0}
     7b0:       e3cc300c        bic     r3, ip, #12
     7b4:       e58dc014        str     ip, [sp, #20]
     7b8:       e3833004        orr     r3, r3, #4
     7bc:       ee033f10        mcr     15, 0, r3, cr3, cr0, {0}

Cheers.

--
Robert

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Feb 2016 12:21:53 +0000
Subject: [PATCH v2] arm64: add alignment fault hanling
In-Reply-To: <56C300AD.8070505@arm.com>
References: <329817481.954581455597874663.JavaMail.weblogic@epmlwas08c>
 <20160216103104.GC14509@arm.com> <56C300AD.8070505@arm.com>
Message-ID: <20160216122153.GD19413@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 10:57:49AM +0000, Robin Murphy wrote:
> On 16/02/16 10:31, Will Deacon wrote:
> >On Tue, Feb 16, 2016 at 04:44:35AM +0000, EunTaik Lee wrote:
> >>Userspace memory is mapped as below:
> >>F2A7F000--F2A7FFFF Normal Memory
> >>F2A80000--F2A80FFF Device nGnRnE
> >>
> >>And that userspace application makes a system call
> >>as below:
> >>
> >>-009 |do_strncpy_from_user(inline)
> >>-009 |strncpy_from_user()
> >>-010 |getname_flags()
> >>-011 |user_path_at_empty()
> >>-012 |user_path_at()
> >>-013 |SYSC_faccessat(inline)
> >>-013 |sys_faccessat()
> >>-014 |__sys_trace(asm)
> >>  --> |exception
> >>
> >>The string spans from 0xF2A7FFC1 to 0xF2A7FFFB.
> >>
> >>When do_strncpy_from_user() reads the last (unsigned long)
> >>value, the alignement fault is triggered. The 8 byte
> >>from 0xF2A7FFC1 spans to the next page that is mapped as
> >>Device nGnRnE, which does not allow an unaligned access,
> >>causes the abort.
> >>
> >>The instruction which caused the alignment fault is registered
> >>in the fixup table but the exception handler does not reach there.
> >>
> >>This patch registers a alignment fault handler and fixes up the
> >>pc if appropriate.
> >
> >As discussed with Catalin previously, we should solve this by adding a
> >guard page rather than handling the fault.

I don't think we can trivially add this without implementing an arm64
specific arch_get_unmapped_area().

> ...especially since we may not even get a fault. See "Crossing a page
> boundary with different memory types or Shareability attributes" in the
> UNPREDICTABLE spec (K1.2.10 in the latest ARMv8 ARM).

While this is CONSTRAINED UNPREDICTABLE, it still doesn't sound good. If
you end up with such adjacent mappings in user space, you can claim it's
the user's responsibility not to do unpredictable accesses across such
boundary. But in this case, it's the kernel do_strncpy_from_user()
assuming that it can freely go across boundaries and patch the fault
afterwards.

Still digging into this but I think we have a bug.

-- 
Catalin

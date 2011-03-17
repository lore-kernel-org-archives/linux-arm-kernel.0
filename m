From: ratbert.chuang@gmail.com (Po-Yu Chuang)
Date: Thu, 17 Mar 2011 17:18:00 +0800
Subject: [PATCH v2] arm: cmpxchg syscall should data abort if page not
	write
In-Reply-To: <1300169637-1628-1-git-send-email-ratbert.chuang@gmail.com>
References: <1300098516-1601-1-git-send-email-ratbert.chuang@gmail.com>
	<1300169637-1628-1-git-send-email-ratbert.chuang@gmail.com>
Message-ID: <AANLkTimOakgzK9LB6g8ibEZ_rr9=ZJw+4aS5Xz3F=J7Z@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King,

On Tue, Mar 15, 2011 at 2:13 PM, Po-Yu Chuang <ratbert.chuang@gmail.com> wrote:
>
> From: Po-Yu Chuang <ratbert@faraday-tech.com>
>
> If the page to cmpxchg is user mode read only (not write),
> we should simulate a data abort first.
>
> Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
> ---
> v2:
> remove !pte_young() check
>
> ?arch/arm/kernel/traps.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 446aee9..eac7c05 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -563,7 +563,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
> ? ? ? ? ? ? ? ?if (!pmd_present(*pmd))
> ? ? ? ? ? ? ? ? ? ? ? ?goto bad_access;
> ? ? ? ? ? ? ? ?pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> - ? ? ? ? ? ? ? if (!pte_present(*pte) || !pte_dirty(*pte)) {
> + ? ? ? ? ? ? ? if (!pte_present(*pte) || !pte_write(*pte) || !pte_dirty(*pte)) {
> ? ? ? ? ? ? ? ? ? ? ? ?pte_unmap_unlock(pte, ptl);
> ? ? ? ? ? ? ? ? ? ? ? ?goto bad_access;
> ? ? ? ? ? ? ? ?}
> --
> 1.6.3.3
>

I think maybe I should describe more details of the problem.
Here is the story.

There is a lock with value 0. After fork(), the page containing the lock
becomes user mode read only for COW later. Process 0 writes 1 to
the lock with cmpxchg syscall. This write should cause COW.
The value of lock of Process 0 should become 1 and the value of lock
of Porcess 1 should still be 0 in the COWed page.

(CORRECT)

P0:lock=0
P0:fork
P0:cmpxchg -> COW
P0:lock=1	P1:lock=0

However, because cmpxchg syscall did not check user mode read only,
it wrote 1 to the lock value directly. After returning to user mode,
Process 0 wrote another variable, say foo, on the same page and
caused COW. The value of lock of Process 1 became 1 which is
incorrect.

(INCORRECT)

P0:lock=0
P0:fork
P0:cmpxchg
P0:lock=1
P0:foo=123 -> COW
P0:lock=1	P1:lock=1

best regards,
Po-Yu Chuang

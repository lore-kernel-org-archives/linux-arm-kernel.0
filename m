From: consul.kautuk@gmail.com (Kautuk Consul)
Date: Sun, 25 Mar 2012 00:07:53 -0400
Subject: [PATCH 1/1] arm: fault.c: correct how the tsk->[maj|min]_flt gets
 incremented
In-Reply-To: <1332261057-2399-1-git-send-email-consul.kautuk@gmail.com>
References: <1332261057-2399-1-git-send-email-consul.kautuk@gmail.com>
Message-ID: <CAFPAmTRiYm-kauXjJAek=VWB=6TEhNo0M6-F7VA4YV8snqiP4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

did anyone get an opportunity to review this change ?


On Tue, Mar 20, 2012 at 12:30 PM, Kautuk Consul <consul.kautuk@gmail.com> wrote:
> commit 8878a539ff19a43cf3729e7562cd528f490246ae was done by me
> to make the page fault handler retryable as well as interruptible.
>
> Due to this commit, there is a mistake in the way in which
> tsk->[maj|min]_flt counter gets incremented for VM_FAULT_ERROR:
> If VM_FAULT_ERROR is returned in the fault flags by handle_mm_fault,
> then either maj_flt or min_flt will get incremented. This is wrong
> as in the case of a VM_FAULT_ERROR we need to be skip ahead to the
> error handling code in do_page_fault.
>
> Added a check after the call to __do_page_fault() to check for
> (fault & VM_FAULT_ERROR).
>
> Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>
> ---
> ?arch/arm/mm/fault.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index bb7eac3..ec8c88b 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -318,7 +318,7 @@ retry:
> ? ? ? ? */
>
> ? ? ? ?perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> - ? ? ? if (flags & FAULT_FLAG_ALLOW_RETRY) {
> + ? ? ? if (!(fault & VM_FAULT_ERROR) && (flags & FAULT_FLAG_ALLOW_RETRY)) {
> ? ? ? ? ? ? ? ?if (fault & VM_FAULT_MAJOR) {
> ? ? ? ? ? ? ? ? ? ? ? ?tsk->maj_flt++;
> ? ? ? ? ? ? ? ? ? ? ? ?perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> --
> 1.7.5.4
>

From: robherring2@gmail.com (Rob Herring)
Date: Wed, 31 Jul 2013 23:03:46 -0500
Subject: [PATCH v2] ARM: Do not run dummy_flush_tlb_a15_erratum() on
 non-Cortex-A15
In-Reply-To: <1374581199-8277-1-git-send-email-festevam@gmail.com>
References: <1374581199-8277-1-git-send-email-festevam@gmail.com>
Message-ID: <CAL_JsqLY5_biGDFFJpP_a_=WwAnVZT2CxiKvgw7=1mjBvp6znA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 7:06 AM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Commit 93dc688 (ARM: 7684/1: errata: Workaround for Cortex-A15 erratum 798181
> (TLBI/DSB operations)) causes the following undefined instruction error on a
> mx53 (Cortex-A8):
>
> Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> CPU: 0 PID: 275 Comm: modprobe Not tainted 3.11.0-rc2-next-20130722-00009-g9b0f371 #881
> task: df46cc00 ti: df48e000 task.ti: df48e000
> PC is at check_and_switch_context+0x17c/0x4d0
> LR is at check_and_switch_context+0xdc/0x4d0
>
> This problem happens because check_and_switch_context() calls
> dummy_flush_tlb_a15_erratum() without checking if we are really running on a
> Cortex-A15 or not.
>
> To avoid this issue, only call dummy_flush_tlb_a15_erratum() inside
> check_and_switch_context() if erratum_a15_798181() returns true, which means
> that we are really running on a Cortex-A15.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Add 'if (erratum_a15_798181())' inside check_and_switch_context()
>
>  arch/arm/include/asm/tlbflush.h | 16 ++++++++++++++++
>  arch/arm/kernel/smp_tlb.c       | 17 -----------------
>  arch/arm/mm/context.c           |  3 ++-
>  3 files changed, 18 insertions(+), 18 deletions(-)

Russell,

I just submitted my patch for 798181 ECO fix handling to the patch
system today. Then I noticed this patch in your fixes branch. This is
going to cause some churn as my patch needs to move the core version
check back to a .c file.

I don't know if you are okay with rebasing your fixes branch or not.
If my patch is applied first, then this issue can be handled by just
replacing dummy_flush_tlb_a15_erratum call in context.c a call to
erratum_a15_798181.

Rob

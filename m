From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 31 May 2011 13:31:02 +0800
Subject: [PATCH] pxa: correct icip irq handling
In-Reply-To: <1306618093-6572-1-git-send-email-dbaryshkov@gmail.com>
References: <1306618093-6572-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <BANLkTimG2bKvQ4u_Hq=dyJ56GL1Z4oBrug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 29, 2011 at 5:28 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> IRQ handling on PXA25x is broken if PXA_HAVE_ISA_IRQS is enabled (then
> all PXA irqs are shifted to start from 16, but icip_handle_irq doesn't
> work in this case. Use PXA_IRQ to correct IRQ numbers in icip_handle_irq.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Applied. Unfortunately, Russell didn't seem to have pulled, so we may need
further address the issues he pointed out.

> ---
> ?arch/arm/mach-pxa/irq.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index 858e287..d9cab3b 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -141,7 +141,7 @@ asmlinkage void __exception_irq_entry icip_handle_irq(struct pt_regs *regs)
> ? ? ? ? ? ? ? ?if (mask == 0)
> ? ? ? ? ? ? ? ? ? ? ? ?break;
>
> - ? ? ? ? ? ? ? asm_do_IRQ(fls(mask) - 1, regs);
> + ? ? ? ? ? ? ? asm_do_IRQ(PXA_IRQ(fls(mask) - 1), regs);
> ? ? ? ?} while (1);
> ?}
>
> --
> 1.7.4.4
>
>

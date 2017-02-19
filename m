From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 19 Feb 2017 08:22:23 +0000
Subject: [PATCH 10/20] ARM: hyp-stub: Use r1 for the soft-restart address
In-Reply-To: <20170217154429.5000-11-marc.zyngier@arm.com>
References: <20170217154429.5000-1-marc.zyngier@arm.com>
 <20170217154429.5000-11-marc.zyngier@arm.com>
Message-ID: <CAKv+Gu-u9Y4EPDs0M1od=Sq2_7HoZxRSd+RFi4sEXrvWFXiszQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 February 2017 at 15:44, Marc Zyngier <marc.zyngier@arm.com> wrote:
> It is not really obvious why the restart address should be in r3
> when communicated to the hyp-stub. r1 should be perfectly adequate,
> and consistent with the rest of the code.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kernel/hyp-stub.S | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
> index 8301db963d83..8fa521bd63d2 100644
> --- a/arch/arm/kernel/hyp-stub.S
> +++ b/arch/arm/kernel/hyp-stub.S
> @@ -214,7 +214,7 @@ __hyp_stub_do_trap:
>
>  1:     teq     r0, #HVC_SOFT_RESTART
>         bne     1f
> -       bx      r3
> +       bx      r1
>
>  1:     mov     r0, #-1
>
> @@ -258,10 +258,8 @@ ENTRY(__hyp_set_vectors)
>  ENDPROC(__hyp_set_vectors)
>
>  ENTRY(__hyp_soft_restart)
> -       mov     r3, r0
>         mov     r0, #HVC_SOFT_RESTART
>         __HVC(0)
> -       mov     r0, r3
>         ret     lr
>  ENDPROC(__hyp_soft_restart)
>

/me confused. How does the address end up in r1?

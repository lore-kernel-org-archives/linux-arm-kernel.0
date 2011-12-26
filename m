From: eric.miao@linaro.org (Eric Miao)
Date: Mon, 26 Dec 2011 15:25:06 +0800
Subject: [PATCH] ARM: imx6q: resume PL310 only when CACHE_L2X0 defined
In-Reply-To: <20111226021727.GN8240@S2100-06.ap.freescale.net>
References: <1324526101-7140-1-git-send-email-eric.miao@linaro.org>
 <20111226021727.GN8240@S2100-06.ap.freescale.net>
Message-ID: <CAMPhdO9F1g08g5ETSFg6proOX=TrLfYU0FtrAT3sYpajemHQFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2011 at 10:17 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Thu, Dec 22, 2011 at 11:55:01AM +0800, Eric Miao wrote:
>> Original patch from Lothar Wa?mann, this patch fixes a building error
>> when CONFIG_CACHE_L2X0 is not defined.
>>
>> Cc: Lothar Wa?mann <lw@karo-electronics.de>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Eric Miao <eric.miao@linaro.org>
>> ---
>> ?arch/arm/mach-imx/head-v7.S | ? 13 +++++++++----
>> ?1 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
>> index a59cae7..cec23a8 100644
>> --- a/arch/arm/mach-imx/head-v7.S
>> +++ b/arch/arm/mach-imx/head-v7.S
>> @@ -80,6 +80,7 @@ ENDPROC(v7_secondary_startup)
>> ? ? ? .data
>> ? ? ? .align
>>
>> +#ifdef CONFIG_CACHE_L2X0
>> ? ? ? .macro ?pl310_resume
>> ? ? ? ldr ? ? r2, phys_l2x0_saved_regs
>> ? ? ? ldr ? ? r0, [r2, #L2X0_R_PHY_BASE] ? ? ?@ get physical base of l2x0
>> @@ -89,13 +90,17 @@ ENDPROC(v7_secondary_startup)
>> ? ? ? str ? ? r1, [r0, #L2X0_CTRL] ? ? ? ? ? ?@ re-enable L2
>> ? ? ? .endm
>>
>> + ? ? .globl ?phys_l2x0_saved_regs
>> +phys_l2x0_saved_regs:
>> + ? ? ? ?.long ? 0
>> +#else
>> + ? ? .macro ?pl310_resume
>> + ? ? .endm
>> +#endif
>> +
>> ?ENTRY(v7_cpu_resume)
>> ? ? ? bl ? ? ?v7_invalidate_l1
>> ? ? ? pl310_resume
>> ? ? ? b ? ? ? cpu_resume
>> ?ENDPROC(v7_cpu_resume)
>> -
>> - ? ? .globl ?phys_l2x0_saved_regs
>> -phys_l2x0_saved_regs:
>> - ? ? ? ?.long ? 0
>> ?#endif
>> --
>> 1.7.5.4
>>
> The following change on pm-imx6q.c needs to amended, otherwise we will see
>
> ?LD ? ? ?.tmp_vmlinux1
> arch/arm/mach-imx/built-in.o: In function `imx6q_pm_init':
> arch/arm/mach-imx/pm-imx6q.c:70: undefined reference to `phys_l2x0_saved_regs'
> arch/arm/mach-imx/pm-imx6q.c:70: undefined reference to `l2x0_saved_regs'
>
> I fixed it up and queued for 3.3. ?Thanks.
>
> Regards,
> Shawn
>
> 8<----
> diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
> index f20f191..f7b0c2b 100644
> --- a/arch/arm/mach-imx/pm-imx6q.c
> +++ b/arch/arm/mach-imx/pm-imx6q.c
> @@ -64,7 +64,9 @@ void __init imx6q_pm_init(void)
> ? ? ? ? * address of the data structure used by l2x0 core to save registers,
> ? ? ? ? * and later restore the necessary ones in imx6q resume entry.
> ? ? ? ? */
> +#ifdef CONFIG_CACHE_L2X0
> ? ? ? ?phys_l2x0_saved_regs = __pa(&l2x0_saved_regs);
> +#endif

Ok, thanks.

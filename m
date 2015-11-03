From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Nov 2015 09:45:25 +0100
Subject: [RESEND PATCH] ARM: errata: Workaround for Cortex-A12 erratum
 818325
In-Reply-To: <1446538209-13490-2-git-send-email-wxt@rock-chips.com>
References: <1446538209-13490-1-git-send-email-wxt@rock-chips.com>
 <1446538209-13490-2-git-send-email-wxt@rock-chips.com>
Message-ID: <7094999.meGITi6gTu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 November 2015 16:10:09 Caesar Wang wrote:
> 
> +       /* Cortex-A12 Errata */
> +       ldr     r10, =0x00000c0d                @ Cortex-A12 primary part number
> +       teq     r0, r10
> +       bne     5f
> +#ifdef CONFIG_ARM_ERRATA_818325
> +       teq     r6, #0x00                       @ present in r0p0
> +       teqne   r6, #0x01                       @ present in r0p1-00lac0-rc11
> +       mrceq   p15, 0, r10, c15, c0, 1         @ read diagnostic register
> +       orreq   r10, r10, #1 << 12              @ set bit #12
> +       mcreq   p15, 0, r10, c15, c0, 1         @ write diagnostic register
> +       isb
> +#endif
>         /* Cortex-A15 Errata */
> 

Does this still build? You seem to have lost the '5:' label.

	Arnd

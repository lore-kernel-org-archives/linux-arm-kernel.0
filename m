From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 23 Jul 2013 16:08:43 +0200
Subject: [PATCH v2] arm: Fix deferred mm switch on VIVT processors
In-Reply-To: <1374252329-5345-1-git-send-email-catalin.marinas@arm.com>
References: <1374252329-5345-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <51EE8E6B.7070801@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2013 06:45 PM, Catalin Marinas wrote:
> As of commit b9d4d42ad9 (ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
> pre-ARMv6 CPUs), the mm switching on VIVT processors is done in the
> finish_arch_post_lock_switch() function to avoid whole cache flushing
> with interrupts disabled. The need for deferred mm switch is stored as a
> thread flag (TIF_SWITCH_MM). However, with preemption enabled, we can
> have another thread switch before finish_arch_post_lock_switch(). If the
> new thread has the same mm as the previous 'next' thread, the scheduler
> will not call switch_mm() and the TIF_SWITCH_MM flag won't be set for
> the new thread.
> 
> This patch moves the switch pending flag to the mm_context_t structure
> since this is specific to the mm rather than thread.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: <stable@vger.kernel.org> # 3.5+

Tested-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/ab545a0c/attachment.sig>

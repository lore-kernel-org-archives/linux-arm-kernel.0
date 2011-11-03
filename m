From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Nov 2011 09:12:45 +0000
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <20111101163817.GR19187@n2100.arm.linux.org.uk>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<20111101163817.GR19187@n2100.arm.linux.org.uk>
Message-ID: <20111103091245.GI12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2011 at 04:38:17PM +0000, Russell King - ARM Linux wrote:
> Can someone please check whether this code:
> 
> /* Hook for arm_pm_restart to ensure we execute the reset code
>  * with the caches enabled. It seems at least the S3C2440 has a problem
>  * resetting if there is bus activity interrupted by the reset.
>  */
> static void s3c24xx_pm_restart(char mode, const char *cmd)
> {
>         if (mode != 's') {
>                 unsigned long flags;
> 
>                 local_irq_save(flags);
>                 __cpuc_flush_kern_all();
>                 __cpuc_flush_user_all();
> 
>                 arch_reset(mode, cmd);
>                 local_irq_restore(flags);
>         }
> 
>         /* fallback, or unhandled */
>         arm_machine_restart(mode, cmd);
> }
> 
> will be broken by any of these patches - and more importantly whether
> this code can simply be deleted with these five patches applied.

Okay, I'm going to delete the above and hope for the best; I'm taking
the lack of reply as meaning that no one in the Samsung community is
that interested in this code.

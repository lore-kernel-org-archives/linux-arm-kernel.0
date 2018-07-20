From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Fri, 20 Jul 2018 15:40:27 +0900
Subject: [PATCH] arm64: fix for restoring console loglevel after handling
 traps
In-Reply-To: <20180720062609.2haxhf23zyouoxmh@salmiak>
References: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
 <1531993734-1463-2-git-send-email-hari.vyas@broadcom.com>
 <20180719100140.GA424@jagdpanzerIV>
 <CAM5rFu_N-=26LddRy1mO010h9yLcGuKqK6=y+h=h3-HbfEP+FQ@mail.gmail.com>
 <20180719103916.g763zmsm7wnngwop@lakrids.cambridge.arm.com>
 <CAM5rFu-MFbH_2Pohmjydy232Rpt7_E84-K=e67wAu3iQzvTLiA@mail.gmail.com>
 <20180720062609.2haxhf23zyouoxmh@salmiak>
Message-ID: <20180720064027.GA3901@jagdpanzerIV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (07/20/18 07:26), Mark Rutland wrote:
> > >
> > This die() is called from so many places i.e. entry.S shows so many ways i.e
> > el1_sync_invalid,irq,fiq_invalid,error_invalid.

[..]

> Indeed, but *none* of these should fire unless something has gone wrong already.

[..]

Agreed.

I see that all those arm64/kernel/entry.S el0_sync_invalid,
el0_irq_invalid, el0_fiq_invalid, and so on, invoke inv_entry macro
which calls into bad_mode, which ends up in panic() anyway:

asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
{
	console_verbose();

	pr_crit("Bad mode in %s handler detected on CPU%d, code 0x%08x -- %s\n",
		handler[reason], smp_processor_id(), esr,
		esr_get_class_string(esr));

	die("Oops - bad mode", regs, 0);
	local_daif_mask();
	panic("bad mode");
}

bad_mode is always fatal.

When the kernel becomes suicidal and wants to die() we better have
verbose consoles. So, no, I don't think I'm buying the patch.

	-ss

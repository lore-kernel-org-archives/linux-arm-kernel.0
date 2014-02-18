From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Feb 2014 14:10:31 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <87vbxhrmea.fsf@natisbad.org>
References: <87eh4dot61.fsf@natisbad.org> <87sissopaf.fsf@natisbad.org>
 <20140114170719.GA12126@xanatos> <87bnzekz5l.fsf@natisbad.org>
 <063D6719AE5E284EB5DD2968C1650D6D45C5AB@AcuExch.aculab.com>
 <87mwix5anm.fsf@natisbad.org> <20140116185044.GC18392@xanatos>
 <87fvon2khn.fsf@natisbad.org> <87zjmvau23.fsf@nemi.mork.no>
 <20140117205432.GB5618@xanatos> <87vbxhrmea.fsf@natisbad.org>
Message-ID: <20140218141031.255bd1ba@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnaud Ebalard,

On Sat, 18 Jan 2014 22:49:17 +0100, Arnaud Ebalard wrote:

> I started suspecting the introduction of MSI support in Marvell PCIe
> host controller driver (FL1009 is on the PCIe bus) and compiled a
> a 3.13.0-rc8 w/ CONFIG_PCI_MSI disabled (it was enabled in all my
> previous tests): I did not manage to reproduce the issue with this
> kernel. As a side note, commits 5b4deb6526bd, 31f614edb726 and
> 627dfcc249e2 are
> 
> ATM, I do not know if the problem is related to a bug in introduced MSI
> support or some weird incompatibility of that functionality with the
> FL1009 which would require some quirk in XHCI stack.
> 
> Thomas, I took a look at the changes but I am not familiar w/ how MSI
> work. You may have an idea on what is going on here.

I finally got some idea: your kernel 3.13-rc7 lacks a very important
fix we did in the irqchip driver MSI handling. You really need to have
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/irqchip/irq-armada-370-xp.c?id=c7f7bd4a136e4b02dd2a66bf95aec545bd93e8db
applied to get proper MSI behavior. Without this patch, there is a race
condition, and some MSI interrupts might be lost.

This commit was merged in v3.14-rc2, and backported to 3.13 and
previous stable releases.

Can you test after applying this commit?

> ps: Thomas, this is completely unrelated but the code below caught my
> eye at the beginning of a hunk in 31f614edb726. When CONFIG_PCI_MSI is
> disabled, why is irqnr now compared to 1 instead of 0?

This is not important. IRQs 0 and 1 are reserved for doorbells, which
are only used for IPI (IRQ 0) and MSI (IRQ 1). Therefore, doing
irq_find_mapping() for either IRQ 0 or IRQ 1 is not useful.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

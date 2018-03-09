From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Fri, 9 Mar 2018 11:33:55 +0100
Subject: [PATCH] arm64: kdump: fix interrupt handling done during
 machine_crash_shutdown
In-Reply-To: <9a709b76-1b45-8250-9d8e-adbad59a43cc@arm.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
 <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com>
 <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
 <9a709b76-1b45-8250-9d8e-adbad59a43cc@arm.com>
Message-ID: <CAH76GKPOX6J=mKV89pjp+f_K7=1aS_SaGfy_nCN5jLDNM4r9aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Not using EOImode==1 is definitely an oddity (at least on the host), but
> that doesn't mean it shouldn't work.
>
> The reason the thing is hanging is that although we correctly deactivate
> the interrupt, nothing performs the priority drop. Your write to EOI
> helps in the sense that it guarantees that both priority drop and
> deactivate are done with the same operation, but that's not something
> we'd want to expose.
>
> My preferred approach would be to nuke the active priority registers at
> boot time, as the CPUs come up. I'll try to write something this week.

I've made a PoC which performs priority drop at boot time as you
suggested and it works with both GICv2 and GICv3 but I see some
problem:
It seems that the only way to drop the priority is to perform write to
EOI register (the GIC_RPR is RO). According to GIC documentation a
write to EOI register must correspond to the most recent valid read
from IAR. The problem is that the interrupt was already acked in the
'original' kernel, so reading GICC_IAR in crashdump kernel returns
spurious interrupt and it seems that there is no way to figure out
appropriate irqnr for EOI write. Nevertheless I've observed that
choosing random irqnr for EOI write works fine (maybe because all
interrupts in Linux uses the same priority?).

Here is the PoC (not ready for submission only for further
discussion): https://pastebin.com/gLYNuRiZ

Looking forward to your feedback.

Thank you in advance,
Grzegorz

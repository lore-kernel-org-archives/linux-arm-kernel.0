From: briannorris@chromium.org (Brian Norris)
Date: Tue, 22 Aug 2017 18:57:15 -0700
Subject: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
In-Reply-To: <599CDB37.3070307@rock-chips.com>
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
 <20170818170107.GA119461@google.com>
 <20170818181416.GF6008@atomide.com>
 <5997486D.4040803@rock-chips.com>
 <20170822172653.GJ6008@atomide.com>
 <599CDB37.3070307@rock-chips.com>
Message-ID: <20170823015714.GA129497@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

On Wed, Aug 23, 2017 at 09:32:39AM +0800, Jeffy Chen wrote:
> and for eage irq, maybe we should enable it right after(or before)
> the driver activate wake function(for example activate WOWLAN or
> WOLAN), otherwise would it be possible to miss some irqs(triggered
> before we actually enable the wake irq)?

I already mentioned this: for the PCI case, the specification explicitly
says that the WAKE# pin must remain asserted until the system wakes and
resets the link. So we don't have this problem.

But it is probably still useful to make sure there's a well-defined
point at which these interrupts are armed, so that if a device driver
does care, it can account for that. Just before suspend_noirq (as it is
today) is probably fine, so if there's some device-level handling that
needs to happen before we get to suspend (but after the wakeirq is
armed), it can go in the device or bus {suspend,resume}_noirq callbacks.

Brian

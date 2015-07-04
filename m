From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Jul 2015 09:26:23 +0100
Subject: [PATCH v2 2/2] irqchip: dw-apb-ictl: add irq_set_affinity support
In-Reply-To: <1435987170-3962-3-git-send-email-jszhang@marvell.com>
References: <1435987170-3962-1-git-send-email-jszhang@marvell.com>
 <1435987170-3962-3-git-send-email-jszhang@marvell.com>
Message-ID: <20150704082623.GA7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 04, 2015 at 01:19:30PM +0800, Jisheng Zhang wrote:
> On Marvell Berlin SoCs, the cpu's local timer is shutdown when the cpu
> goes to a deep idle state, then the timer framework will be notified to
> use a broadcast timer instead. The broadcast timer uses dw-apb-ictl as
> interrupt chip, this patch adds irq_set_affinity support so that the
> going to deep idle state cpu can set the interrupt affinity of the
> broadcast interrupt to avoid unnecessary wakeups and IPIs.

NAK to this patch.

The real question is - if CPU0 is the CPU going offline, why is it
still receiving _any_ interrupts - all interrupts should be migrated
off it, including the chained interrupts.

Sounds like there's a bug in the migration code which needs further
investigation, rather than hacking around the problem by introducing
lots of driver code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jul 2015 15:12:12 +0100
Subject: [PATCH] ARM: psci: keystone: remove keystone_smp_ops code if
 psci is supported
In-Reply-To: <1435752784-30639-1-git-send-email-vitalya@ti.com>
References: <1435752784-30639-1-git-send-email-vitalya@ti.com>
Message-ID: <20150701141211.GK7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 08:13:03AM -0400, Vitaly Andrianov wrote:
> If we enable psci support we don't need keystone_smp_ops anymore.
> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>

However, this is not necessary.  If you look at arch/arm/kernel/setup.c,
it contains this:

        psci_init();
#ifdef CONFIG_SMP
        if (is_smp()) {
                if (!mdesc->smp_init || !mdesc->smp_init()) {
                        if (psci_smp_available())
                                smp_set_ops(&psci_smp_ops);
                        else if (mdesc->smp)
                                smp_set_ops(mdesc->smp);
                }
                smp_init_cpus();
                smp_build_mpidr_hash();
        }
#endif

So, the platforms' SMP ops won't be used even if they're provided
when PSCI is available.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

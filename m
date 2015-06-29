From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Jun 2015 22:28:14 +0100
Subject: [PATCH] keystone: adds cpu_die implementation
In-Reply-To: <559191E0.4080808@ti.com>
References: <1435600352-32733-1-git-send-email-vitalya@ti.com>
 <20150629175223.GC19863@leverpostej> <559191E0.4080808@ti.com>
Message-ID: <20150629212814.GE7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 02:43:44PM -0400, Vitaly Andrianov wrote:
> 
> 
> On 06/29/2015 01:52 PM, Mark Rutland wrote:
> >On Mon, Jun 29, 2015 at 06:52:32PM +0100, Vitaly Andrianov wrote:
> >>This commit add cpu_die implementation
> >>
> >>Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> >>---
> >>
> >>The discussion of the "keystone: psci: adds cpu_die implementation" commit
> >>shows that if PCSI is enabled platform code doesn't need that implementation
> >>at all. Having PSCI commands in DTB should be sufficient. Unfortunately
> >>Keystone with LPAE enable requires some additional development.
> >
> >I don't follow.
> >
> >What do you need to implement for LPAE?
> Hi Mark,
> 
> The Keystone platform needs to set ttbr1 when it boots secondary core.
> It is done in the keystone_smp_secondary_initmem(), which is
> .smp_secondary_init member of the keystone_smp_ops. I couldn't find a way
> how I can add similar function to psci_smp_ops.

TTBR1 will be set by generic code.  You don't need to do anything special
now that my fixes for TI's horrid physical address space switch are in.
(you may remember, you tested the patches...)

secondary_startup now loads r4/r5 with the 64-bit physical swapper page
table address, and r8 contains the _pfn_ of the swapper_pg_dir.

It then calls through to (eventually) __v7_setup, which passes these
registers through to the v7_ttb_setup asm macro - r4 as ttbr0l, r5 as
ttbr0h, and r8 as ttbr1.

v7_ttb_setup converts the PFN to a physical address and programs it
into TTBR1.  TTBR0 is set directly from r4/r5 in generic code paths in
head.S::__enable_mmu.

There is no need to do any messing around when starting up a secondary
core on Keystone2.  In fact, my patches that I pointed you at a few
months ago ripped out all that code.  The entire keystone2 platsmp.c
file now contains only this code:

static int keystone_smp_boot_secondary(unsigned int cpu,
                                                struct task_struct *idle)
{
        unsigned long start = virt_to_idmap(&secondary_startup);
        int error;

        pr_debug("keystone-smp: booting cpu %d, vector %08lx\n",
                 cpu, start);

        error = keystone_cpu_smc(KEYSTONE_MON_CPU_UP_IDX, cpu, start);
        if (error)
                pr_err("CPU %d bringup failed with %d\n", cpu, error);

        return error;
}

struct smp_operations keystone_smp_ops __initdata = {
        .smp_boot_secondary     = keystone_smp_boot_secondary,
};

which is a lot simpler than it was.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 14:47:51 +0000
Subject: [PATCH 3/3] ARM: SAMSUNG: Add idle support
In-Reply-To: <20100112141853.GC18532@trinity.fluff.org>
References: <1263203072-29282-1-git-send-email-kgene.kim@samsung.com>
	<20100111100253.GA30556@n2100.arm.linux.org.uk>
	<20100112000606.GR3738@trinity.fluff.org>
	<20100112101226.GA27771@n2100.arm.linux.org.uk>
	<20100112141853.GC18532@trinity.fluff.org>
Message-ID: <20100112144751.GG27771@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 02:18:53PM +0000, Ben Dooks wrote:
> So basically i've got to copy the default_idle() and the necessary cpu code
> for each of the cpus that are supported? I'd much rather just do it once
> and have a pointer to the bits that change thanks.

No - default_idle is just:

static void default_idle(void)
{
        if (!need_resched())
                arch_idle();
        local_irq_enable();
}

Rather than indirecting arch_idle(), hook into pm_idle instead, and have:

	if (!need_resched()) {
		your_idle_code_which_may_be_a_call_to_cpu_idle();
	}
	local_irq_enable();

in each of your idle methods instead, completely ignoring arch_idle().

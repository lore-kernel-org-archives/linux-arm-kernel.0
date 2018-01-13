From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 13 Jan 2018 12:00:31 +0000
Subject: [PATCH v6 11/16] firmware: arm_sdei: Add support for CPU and
 system power states
In-Reply-To: <20180108172226.GC2530@red-moon>
References: <20180108153818.22743-1-james.morse@arm.com>
 <20180108153818.22743-12-james.morse@arm.com>
 <20180108172226.GC2530@red-moon>
Message-ID: <20180113120031.5m6eykwzqnioyb33@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 05:22:26PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Jan 08, 2018 at 03:38:13PM +0000, James Morse wrote:
> 
> [...]
> 
> > +/* When entering idle, mask/unmask events for this cpu */
> 
> Just mentioning (since I know you know), this notifier is called also
> through syscore_ops so it is not just idle (CPUidle or Suspend-to-idle).
> 
> > +static int sdei_pm_notifier(struct notifier_block *nb, unsigned long action,
> > +			    void *data)
> > +{
> > +	int rv;
> > +
> > +	switch (action) {
> > +	case CPU_PM_ENTER:
> > +		rv = sdei_mask_local_cpu();
> > +		break;
> > +	case CPU_PM_EXIT:
> > +		rv = sdei_unmask_local_cpu();
> 
> You should handle CPU_PM_ENTER_FAILED here for correctness,
> in case the notifier chain fails.

So, just to confirm, the CPU_PM_ENTER_FAILED case goes together with
CPU_PM_EXIT so that we unmask the SDE again for the CPU.

-- 
Catalin

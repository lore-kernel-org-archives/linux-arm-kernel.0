From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 19 Jun 2018 15:46:35 +0100
Subject: [PATCH v3] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is
 observed before enabling
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A69F37935@G01JPEXMBKW03>
References: <1521683929-15644-1-git-send-email-shankerd@codeaurora.org>
 <d1161c2d-e16d-14e6-5450-be26d348100d@arm.com>
 <8087e009-4eca-ab92-cbca-23ccfb3fafac@codeaurora.org>
 <86o9jf174o.wl-marc.zyngier@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69F37935@G01JPEXMBKW03>
Message-ID: <86tvpy7s1g.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lei,

On Tue, 19 Jun 2018 15:14:27 +0100,
"Zhang, Lei" <zhang.lei@jp.fujitsu.com> wrote:
> 
> Hi shankerd, Marc
> 
> I have one question.
> 
> Does it means after GICR_CTLR.EnableLPI has been written to 1, 
> if the bit GICR_CTLR.EnableLPI becomes RES1, we can't use LPIs?
> Because its_cpu_init_lpis and its_cpu_init_collections will not be called. 

There are two issues:

- If EnableLPI is already set to 1, your redistributors are already
  potentially corrupting the memory by writing to the pending
  tables. Your system is now potentially unstable (single bit
  corruption, depending on what the ITS outputs).

- If EnableLPI has become RES1, you cannot even turn it off to
  reprogram things so that the property and pending tables are under
  your control.

At that stage, your system is in a very bad shape, and LPIs are the
least of your problems.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.

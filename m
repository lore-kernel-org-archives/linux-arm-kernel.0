From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 8 Feb 2016 11:55:52 +0000
Subject: [PATCH v4 07/13] arm64: Change cpu_resume() to enable mmu early
 then access sleep_sp by va
In-Reply-To: <56B859D9.3080601@arm.com>
References: <1453977766-20907-1-git-send-email-james.morse@arm.com>
 <1453977766-20907-8-git-send-email-james.morse@arm.com>
 <20160205162617.GD31547@red-moon> <56B859D9.3080601@arm.com>
Message-ID: <20160208115552.GA5471@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 09:03:21AM +0000, James Morse wrote:
> Hi Lorenzo,
> 
> On 05/02/16 16:26, Lorenzo Pieralisi wrote:
> >> cpu_do_{suspend,resume} could be further reduced to not restore: cpacr_el1,
> >> mdscr_el1, tcr_el1, vbar_el1 and sctlr_el1, all of which are set by
> >> __cpu_setup(). However these values all contain res0 bits that may be used
> >> to enable future features.
> > 
> > This patch is a very nice clean-up, a comment below.
> > 
> > I think that for registers like tcr_el1 and sctlr_el1 we should define
> > a restore mask (to avoid overwriting bits set-up by __cpu_setup), eg
> > current code that restores the tcr_el1 seems wrong to me, see below.
> 
> Presumably this should be two masks, one to find RES0 bits that are
> set, and are assumed to have some new meaning, and another to find
> RES1 bits that have been cleared.

For the time being, it is ok to just fix t0sz restore which means
that either you avoid overwriting tcr_el1.t0sz in cpu_do_resume()
or you force the t0sz value field to be whatever value is already
present in the register (ie set-up in __cpu_setup through
tcr_set_idmap_t0sz) and finally set it to correct the default value
in __cpu_suspend_exit() using the correct procedure:

- set reserved ttbr0
- flush tlb
- cpu_set_default_tcr_t0sz

Thanks,
Lorenzo

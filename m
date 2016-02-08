From: james.morse@arm.com (James Morse)
Date: Mon, 08 Feb 2016 09:03:21 +0000
Subject: [PATCH v4 07/13] arm64: Change cpu_resume() to enable mmu early
 then access sleep_sp by va
In-Reply-To: <20160205162617.GD31547@red-moon>
References: <1453977766-20907-1-git-send-email-james.morse@arm.com>
 <1453977766-20907-8-git-send-email-james.morse@arm.com>
 <20160205162617.GD31547@red-moon>
Message-ID: <56B859D9.3080601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 05/02/16 16:26, Lorenzo Pieralisi wrote:
>> cpu_do_{suspend,resume} could be further reduced to not restore: cpacr_el1,
>> mdscr_el1, tcr_el1, vbar_el1 and sctlr_el1, all of which are set by
>> __cpu_setup(). However these values all contain res0 bits that may be used
>> to enable future features.
> 
> This patch is a very nice clean-up, a comment below.
> 
> I think that for registers like tcr_el1 and sctlr_el1 we should define
> a restore mask (to avoid overwriting bits set-up by __cpu_setup), eg
> current code that restores the tcr_el1 seems wrong to me, see below.

Presumably this should be two masks, one to find RES0 bits that are set, and are
assumed to have some new meaning, and another to find RES1 bits that have been
cleared.


>> -	cpu_set_reserved_ttbr0();
>> -	local_flush_tlb_all();
>> -	cpu_set_default_tcr_t0sz();
> 
> You remove the code above since you restore tcr_el1 in cpu_do_resume(),
> but this is not the way it should be done, ie the restore should be done
> with the code sequence above otherwise it is not safe.

You're right - __cpu_setup() sets a guaranteed-incompatible t0sz value.
I removed it because all this now gets executed from the swapper page tables,
not the idmap, but there is more to it than that.


Thanks,

James

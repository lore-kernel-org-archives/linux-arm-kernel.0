From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Apr 2011 16:32:05 +0100
Subject: [RESEND][PATCH] ARM: memmap: only free allocated memmap
	entries when using SPARSEMEM
In-Reply-To: <1302267726-18521-1-git-send-email-will.deacon@arm.com>
References: <1302267726-18521-1-git-send-email-will.deacon@arm.com>
Message-ID: <1303313525.11314.7.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-08 at 14:02 +0100, Will Deacon wrote:
> The SPARSEMEM code allocates memmap entries only for sections which are
> present (i.e. those which contain some valid memory). The membank checks
> in free_unused_memmap do not take this into account and can incorrectly
> attempt to free memory which is not allocated, resulting in a BUG() in
> the bootmem code.
> 
> However, if memory is configured as follows:
> 
>     |<----section---->|<----hole---->|<----section---->|
>     +--------+--------+--------------+--------+--------+
>     | bank 0 | unused |              | bank 1 | unused |
>     +--------+--------+--------------+--------+--------+
> 
> where a bank only occupies part of a section, the memmap allocated for
> the remainder of the section *can* be freed.
> 
> This patch modifies the checks in free_unused_memmap so that only valid
> memmap entries are considered for removal.
> 
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---

Russell - are you happy for me to post this to the patch system (minus
the CC)?

Thanks,

Will

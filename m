From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 Jun 2011 14:04:35 +0100
Subject: [PATCH] ARM: mm: ensure TTBR0 is restored when changing ASID on
	rollover
In-Reply-To: <1307443118-11573-1-git-send-email-will.deacon@arm.com>
References: <1307443118-11573-1-git-send-email-will.deacon@arm.com>
Message-ID: <BANLkTimnqrMtdvicvvwCwPRqQjZSTSXhFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 June 2011 11:38, Will Deacon <will.deacon@arm.com> wrote:
> In 52af9c6c ("ARM: 6943/1: mm: use TTBR1 instead of reserved context ID")
> I updated the ASID rollover code to use only the kernel page tables
> whilst updating the ASID.
>
> Unfortunately, the code to restore the user page tables was part of a
> later patch which isn't yet in mainline, so this leaves the code
> quite broken.

IOW, after an ASID roll-over on SMP, the cross-called reset_context()
function sets TTBR0 to swapper_pg_dir but never sets it back to the
one of the currently running process. So interrupted user space
processes would fault when returning from an ASID roll-over event
happening on a different CPU.

> This patch fixes the issue by calling cpu_switch_mm to change the ASID
> which has the side-effect of setting up TTBR0 to point to the user
> tables.
>
> Reported-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

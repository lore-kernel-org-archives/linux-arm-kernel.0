From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Jul 2010 10:12:10 +0100
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v6)
In-Reply-To: <20100719180136.20305.7333.stgit@e200687-lin>
References: <20100719180136.20305.7333.stgit@e200687-lin>
Message-ID: <1279617130.29006.9.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-07-19 at 19:02 +0100, Leif Lindholm wrote:
> The SWP instruction was deprecated in the ARMv6 architecture, superseded
> by the LDREX/STREX family of instructions for
> load-linked/store-conditional operations. The ARMv7 multiprocessing
> extensions mandate that SWP/SWPB instructions are treated as undefined
> from reset, with the ability to enable them through the System Control
> Register SW bit.
> 
> This patch adds the alternative solution to emulate the SWP and SWPB
> instructions using LDREX/STREX sequences, and log statistics to
> /proc/cpu/swp_emulation.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@arm.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> ---
> 
> This patch depends on Catalin Marinas' "Remove the domain switching on
> ARMv6k/v7 CPUs" patch for setting access privileges to kernel
> read-only when user read-only.

Since this patch depends on my domains one, I'll also merge it in my
public tree until the domains patch is accepted.

Just for clarification - the reason it depends on my domains patch is
because of the permission change for read-only user mappings (from
kernel read/write to kernel read-only so that we get COW during SWP
emulation).

An alternative would be to extract the permission settings part from my
domains patch and merge it separately but I really don't think it's
worth the effort as we need the domains patch in the kernel.

In the meantime:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

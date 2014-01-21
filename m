From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jan 2014 10:45:21 +0100
Subject: [PATCH v2 01/15] ARM: Introduce atomic MMIO modify
In-Reply-To: <1390295561-3466-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <3512865.jTEvHVvFLA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 January 2014 06:12:27 Ezequiel Garcia wrote:
> Some SoC have MMIO regions that are shared across orthogonal
> subsystems. This commit implements a possible solution for the
> thread-safe access of such regions through a spinlock-protected API.
> 
> Concurrent access is protected with a single spinlock for the
> entire MMIO address space. While this protects shared-registers,
> it also serializes access to unrelated/unshared registers.
> 
> We add relaxed and non-relaxed variants, by using writel_relaxed and writel,
> respectively. The rationale for this is that some users may not require
> register write completion but only thread-safe access to a register.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

You add the new atomic mmio interfaces in an ARM global header file,
but at the same time make them ARM-only. I'm not opposed to having
interfaces like that, but I'm not convinced they are actually needed
for this case and if we go there, it needs to be done more carefully
and should be available for all architectures so that portable drivers
can use them.

It also seems to duplicate functionality that is already present in
regmap-mmio.

	Arnd

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2009 11:48:36 +0000
Subject: [PATCH 1/2] ARM: Implemented support for VFP PM context saving
In-Reply-To: <1259059024-23719-2-git-send-email-tero.kristo@nokia.com>
References: <1259059024-23719-1-git-send-email-tero.kristo@nokia.com>
	<1259059024-23719-2-git-send-email-tero.kristo@nokia.com>
Message-ID: <20091124114836.GA10510@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 12:37:03PM +0200, Tero Kristo wrote:
> In some ARM architectures, like OMAP3, the VFP context can be lost during
> dynamic sleep cycle. For this purpose, there is now a function
> vfp_pm_save_context() that should be called before the VFP is assumed to
> lose context. Next VFP trap will then restore context automatically.
> 
> We need to have the last_VFP_context[cpu] cleared after the save in idle,
> else the restore would fail to restore when it sees that the last_VFP_context
> is same as the current threads vfp_state. This happens when the same
> process/thread traps an exception post idle.
> 
> Main work for this patch was done by Peter and Rajendra. Some cleanup and
> optimization by Tero.

Why not re-use vfp_pm_suspend() ?  Haven't you shown that vfp_pm_suspend
may be buggy since it doesn't save in the VFP-disabled case?

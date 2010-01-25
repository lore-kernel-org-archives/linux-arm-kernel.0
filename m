From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Jan 2010 16:40:09 +0000
Subject: [RFC 17/18] arm: mm: Add SW emulation for ARM domain manager
	feature
In-Reply-To: <1263250057-26692-18-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-18-git-send-email-dwalker@codeaurora.org>
Message-ID: <1264437609.6275.110.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Mon, 2010-01-11 at 22:47 +0000, Daniel Walker wrote:
> Do not set domain manager bits in cp15 dacr.  Emulate using SW.  Add
> kernel hooks to handle domain changes, permission faults, and context
> switches.

In case you were not aware, there's a patch around (I think since 2007)
that removes the domain switching entirely from the kernel (given that
they have been deprecated for some time and may disappear completely in
the future):

http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005616.html

It doesn't require handling domain faults and works on SMP as well.
Another advantage is that we can re-implement functions like
copy_from_user etc. only using LDR/LDM rather than LDRT with some
performance improvements.

Of course, being my patch, I'm pushing for it :-) but I think longer
term is a better approach that the domains emulation. Any thoughts on
this?

> --- /dev/null
> +++ b/Documentation/arm/msm/emulate_domain_manager.txt
[...]
> +Software description
> +====================
> +
> +In order to disable domain manager mode the equivalent HW functionality must
> +be emulated in SW.  Any attempts to enable domain manager mode, must be
> +intercepted.
> +
> +Because domain manager mode is not enabled, permissions for the
> +associated domain will remain restricted.  Permission faults will be generated.
> +The permission faults will be intercepted.  The faulted pages/sections will
> +be modified to grant full access and execute permissions.
> +
> +The modified page tables must be restored when exiting domain manager mode.

BTW, on the current (unpatched) kernel, what happens if after a
set_fs(KERNEL_DS) call the kernel is preempted and a user space
application executed? Does it gain access to the kernel pages? Something
like this may affect your patches as well.

Thanks.

-- 
Catalin

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 07 May 2013 09:55:41 +0100
Subject: [RFC PATCH V2] ARM: EXYNOS: Fix hotplug when CPUs boot in HYP mode
In-Reply-To: <CAHuqX+HUWcX_sTXKCjSQ9pR1K8obLc+T7vYK_zTn_gqO8ULPVQ@mail.gmail.com>
References: <1367905910-30913-1-git-send-email-giridhar.m@samsung.com>
 <CAHuqX+HUWcX_sTXKCjSQ9pR1K8obLc+T7vYK_zTn_gqO8ULPVQ@mail.gmail.com>
Message-ID: <5188C18D.10103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/13 06:54, Giridhar Maruthy wrote:
> This patch is a modification from the Christoffer Dall's u-boot
> patch. This is required to put the secondary processors in hyp
> mode during cpu hotplug when u-boot is no longer alive.
> 
> Marc Zyngier suggested this logic to go into firmware or, u-boot
> putting a trampoline code into a page /memreserve/d by DT. But
> this seemed to have a problem. Once the cpu is hotplugged in
> runtime, the control is in ROM code and waits for event.
> Kernel provides a return address in kernel to which the processor
> jumps once it gets an event. If the control branches to the
> trampoline code here, this trampoline code has no kernel return
> address.
> 
> Someone with better logic or better placement of this logic
> elsewhere is welcome.

What prevents you from writing the kernel address in the memreserved
page? Some obvious location, like the last word of the page? You only
have to do it once (from the boot CPU, for example).

Or did I miss something else?

	M.
-- 
Jazz is not dead. It just smells funny...

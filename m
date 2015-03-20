From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Mar 2015 19:48:38 +0000
Subject: [PATCH 0/6] arm64 kexec kernel patches V8
In-Reply-To: <cover.1426793116.git.geoff@infradead.org>
References: <cover.1426793116.git.geoff@infradead.org>
Message-ID: <20150320194838.GD24455@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 08:35:27PM +0000, Geoff Levand wrote:
> Hi All,

Hi Geoff,

As a heads-up, I'm not going to have the chanec to review this until
after the FW summit next week.

[...]

> KVM
> ---
> 
> PROBLEM: KVM acquires hypervisor resources on startup, but does not free those
> resources on shutdown, so the first stage kernel cannot be shutdown properly
> when using kexec.
> 
> WORK-AROUND: Build the first stage kernel with CONFIG_KVM=n, or apply KVM bug
> fix patches from [1].
> 
> FIX: Takahiro Akashi has preliminary patches to fix the KVM shutdown problem.  I
> have those in my master branch at [1].  KVM + kexec works properly with that
> branch.  Patches neeeded:
> 
>  arm64: kvm: add a cpu tear-down function
>  arm64: kexec: fix kvm issue
>  arm64/kvm: Remove !KEXEC Kconfig dependency
>  arm64/kexec: Enable kexec in the arm64 defconfig

These (or some descendents thereof) are going to be a prerequisite for
kexec.

> /memreserve/
> ----------
> 
> PROBLEM: Device tree /memreserve/ entries are not available in
> /proc/device-tree.  For systems that have /memreserve/ entries and use
> /proc/device-tree during kexec, the second stage kernel will use the reserved
> regions and the system will become unstable.
> 
> WORK-AROUND: Enable the kernel config option CONFIG_SYSFS=y to expose a binary
> device tree to user space at /sys/firmware/fdt that includes /memreserve/
> entries OR pass a user specified DTB using the kexec --dtb option.
> 
> FIX: This is expected behavior.  To maximize user support, rework device tree
> definitions to not use /memreserve/ entries.

I'd say that requiring CONFIG_SYSFS is the real fix here. That's a
kernel change that maximises compatibility with DTBs (which we don't
really have control over).

I hope that the tools warn somehow if they cannot see the fdt.

Mark.

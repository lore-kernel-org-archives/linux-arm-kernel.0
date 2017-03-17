From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Mar 2017 11:53:21 +0000
Subject: [PATCH 1/2] arm: Fix cache inconsistency when using fixmap
In-Reply-To: <20170316132958.22227-1-tixy@linaro.org>
References: <20170316132958.22227-1-tixy@linaro.org>
Message-ID: <20170317115321.GB21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 01:29:57PM +0000, Jon Medhurst wrote:
> To cope with the variety in ARM architectures and configurations, the
> pagetable attributes for kernel memory are generated at runtime to match
> the system the kernel finds itself on. This calculated value is stored
> in pgprot_kernel.
> 
> However, when early fixmap support was added for arm (commit
> a5f4c561b3b1) the attributes used for mappings were hard coded because
> pgprot_kernel is not set up early enough. Unfortunately, the values used
> didn't include the 'shareable' attribute which means that for later
> non-early fixmap use, when multiple CPUs are running, any cache entries
> allocated for fixmap memory aren't kept consistent between CPUs. This
> can result in different CPUs seeing different memory contents.

This also likely causes unpredictable behaviour (aliased attributes).

> This issue was discovered on a dual cluster system by failures with
> kprobes, which uses fixmap to modify the kernel image if
> CONFIG_DEBUG_RODATA is enabled. It will also affect kgdb and jump_labels
> which also make use of the same code to modify the kernel, and any other
> uses of fixmap after secondary CPUs are brought online.
> 
> To fix this issue, and to help avoid other potential problems where
> pagetable attributes are incorrect, we change the fixmap code to use the
> same generated value in pgprot_kernel that the rest of the kernel uses,
> and only fall back to a hard coded value if this isn't set - which will
> be early on in boot before other CPUs are brought online.

I'm not happy with this - if we need to create early fixmaps, then
we need to know the correct attributes to use, so let's move the
attribute initialisation earlier.  This solution feels too much like
hacking around the problem.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

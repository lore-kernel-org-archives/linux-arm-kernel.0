From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 17 Sep 2015 00:43:30 +0800
Subject: Regression by 01f779f4862b ("irqchip/GIC: Don't deactivate
 interrupts forwarded to a guest")
In-Reply-To: <20150917003202.498ff83c@xhacker>
References: <20150917003202.498ff83c@xhacker>
Message-ID: <20150917004330.208ec1c6@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Thu, 17 Sep 2015 00:32:02 +0800
Jisheng Zhang <jszhang@marvell.com> wrote:

> Hi Marc,
> 
> Commit 01f779f4862b ("irqchip/GIC: Don't deactivate interrupts forwarded to a
> guest") causes a regression on Marvell BG4CT SoC. In this SoC, there's only one

The regression phenomenon is all cascaded irq can't be handled correctly.

Thanks,
Jisheng

> GIC, the secondary irq controller is Synopsys DW iCtl:
> drivers/irqchip/irq-dw-apb-ictl.c
> 
> So cascading_gic_irq() should return true on Marvell BG4CT SoC, but it returns
> false. The logic in cascading_gic_irq() doesn't take cascaded irq controller
> which is provided by non-gic controllers.
> 
> bisect log is as following:
> 
> git bisect start
> # bad: [865ca084fdc68cd9b658da4b098008278da8fed3] ia64: Enable userfaultfd and membarrier system calls
> git bisect bad 865ca084fdc68cd9b658da4b098008278da8fed3
> # good: [f377ea88b862bf7151be96d276f4cb740f8e1c41] Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux
> git bisect good f377ea88b862bf7151be96d276f4cb740f8e1c41
> # bad: [3af6e98f25d1f68b9c36beee330342944a4e0048] Merge tag 'platform-drivers-x86-v4.3-1' of git://git.infradead.org/users/dvhart/linux-platform-drivers-x86
> git bisect bad 3af6e98f25d1f68b9c36beee330342944a4e0048
> # good: [bd779669945ed9982890da789ad32e3bd0d41f14] Merge tag 'for-linus-4.3-merge-window-part-1' of git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs
> git bisect good bd779669945ed9982890da789ad32e3bd0d41f14
> # bad: [6f0a2fc1feb19bd142961a39dc118e7e55418b3f] Merge branch 'nmi' of git://ftp.arm.linux.org.uk/~rmk/linux-arm
> git bisect bad 6f0a2fc1feb19bd142961a39dc118e7e55418b3f
> # good: [77a78806c7df8d414c33031a1ca5121876910c4f] Merge tag 'xfs-for-linus-4.3' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs
> git bisect good 77a78806c7df8d414c33031a1ca5121876910c4f
> # good: [0762ed2ced40bfe648378ef0e1635cf4d3a6fb76] NFSv4.1/flexfiles: Allow coalescing of new layout segments and existing ones
> git bisect good 0762ed2ced40bfe648378ef0e1635cf4d3a6fb76
> # good: [0762ed2ced40bfe648378ef0e1635cf4d3a6fb76] NFSv4.1/flexfiles: Allow coalescing of new layout segments and existing ones
> git bisect good 0762ed2ced40bfe648378ef0e1635cf4d3a6fb76
> # good: [1c8cc72d57f321bfccadf4f7b38b94ba287928bc] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
> git bisect good 1c8cc72d57f321bfccadf4f7b38b94ba287928bc
> # good: [a11f4f0a4e18b4bdc7d5e36438711e038b7a1f74] xen: xensyms support
> git bisect good a11f4f0a4e18b4bdc7d5e36438711e038b7a1f74
> # good: [626d7508664c4bc8e67f496da4387ecd0c410b8c] xen: switch extra memory accounting to use pfns
> git bisect good 626d7508664c4bc8e67f496da4387ecd0c410b8c
> # bad: [4a6ac3044f1504fe4521efa7334095c9c9ceecfd] irqchip/GIC: Fix EOImode setting for non-DT/ACPI systems
> git bisect bad 4a6ac3044f1504fe4521efa7334095c9c9ceecfd
> # good: [530bf353e4eb06bcba5078390c949650cd26a7c7] irqchip/GICv3: Don't deactivate interrupts forwarded to a guest
> git bisect good 530bf353e4eb06bcba5078390c949650cd26a7c7
> # bad: [01f779f4862b53810ba4eb247f57bd1ad31d1c18] irqchip/GIC: Don't deactivate interrupts forwarded to a guest
> git bisect bad 01f779f4862b53810ba4eb247f57bd1ad31d1c18
> # good: [0b996fd35957a30568cddbce05b917c1897966e0] irqchip/GIC: Convert to EOImode == 1
> git bisect good 0b996fd35957a30568cddbce05b917c1897966e0
> # first bad commit: [01f779f4862b53810ba4eb247f57bd1ad31d1c18] irqchip/GIC: Don't deactivate interrupts forwarded to a guest
> 
> Thanks,
> Jisheng
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

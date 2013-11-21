From: ignatov.a@samsung.com (Alexey Ignatov)
Date: Thu, 21 Nov 2013 09:35:34 +0000 (UTC)
Subject: [PATCH 5/5] arm: Enable IRQs before attempting to read user space
 in =?utf-8?b?X191bmRfdXNy?=
References: <1377689664-27614-1-git-send-email-catalin.marinas@arm.com>
 <1377689664-27614-6-git-send-email-catalin.marinas@arm.com>
Message-ID: <loom.20131121T102616-386@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas <at> arm.com> writes:

> The Undef abort handler in the kernel reads the undefined instruction
> from user space. If the page table was modified from another CPU, the
> user access could fail and do_page_fault() will be executed with
> interrupts disabled. This can potentially deadlock on ARM11MPCore or on
> Cortex-A15 with erratum 798181 workaround enabled (both implying IPI for
> TLB maintenance with page table lock held).
> 
> This patch enables the IRQs in __und_usr before attempting to read the
> instruction from user space.

This patch moves enable_irq call from do_fpe directly to __und_usr handler,
but __und_svc handler also calls do_fpe (via call_fpe), so now this codepath
runs with disabled irqs. This behavior change doesn't look good for me.

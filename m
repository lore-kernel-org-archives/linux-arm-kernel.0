From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 17:38:08 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <54FF2986.6020503@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
 <54FF2986.6020503@list.ru>
Message-ID: <20150310173807.GU8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 08:27:34PM +0300, Stas Sergeev wrote:
> Please also find the same crash here:
> http://lists.linaro.org/pipermail/kernel-build-reports/2014-June/003872.html

Hmm, looks like from the exynos5420-arndale-octa failure in that, we
don't dump the page table entries.  We should do.  Sorry about my
previous mail.

If you can reproduce this, please do so with this patch so that we
can get the page table entries associated with the problem.  Thanks.

 arch/arm/mm/fault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index a982dc3190df..6333d9c17875 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -552,6 +552,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
 		inf->name, fsr, addr);
+	show_pte(current->mm, addr);
 
 	info.si_signo = inf->sig;
 	info.si_errno = 0;


-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

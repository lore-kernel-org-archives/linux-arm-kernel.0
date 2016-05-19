From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 19 May 2016 13:50:40 +0100
Subject: [PATCH] arm64: cpuinfo: add AArch64 & elf platform for app
 compatibility
In-Reply-To: <573D9E40.4000705@hisilicon.com>
References: <1463625873-60016-1-git-send-email-saberlily.xia@hisilicon.com>
 <20160519104925.GL22378@e104818-lin.cambridge.arm.com>
 <573D9E40.4000705@hisilicon.com>
Message-ID: <20160519125039.GN22378@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2016 at 07:06:40PM +0800, Xiaqing (A) wrote:
> 
> 
> ? 2016/5/19 18:49, Catalin Marinas ??:
> >On Thu, May 19, 2016 at 10:44:33AM +0800, x00195127 wrote:
> >>we find that some apps will read cpuinfo when start up,
> >>they need the string  as follows:
> >>"Processor       : AArch64 Processor rev 0 (aarch64)"
> >>
> >>Then thay could load the corresponding libs. But now
> >>arm64 platform's cpuinfo don't has this now, so
> >>we need add this.
> >
> >I have the same question as Martinez: what are those apps? If they are
> >64-bit apps, they can always assume AArch64 processor.
> 
> Those are 32-bit apps, and those apps are very popular in our country.

32-bit apps checking for "AArch64" is a really silly idea. What do they
do with this information?

I'm rather inclined to merge this patch:

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 3808470486f3..623d7d291dd6 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -127,7 +127,8 @@ static int c_show(struct seq_file *m, void *v)
 		 * software which does already (at least for 32-bit).
 		 */
 		seq_puts(m, "Features\t:");
-		if (personality(current->personality) == PER_LINUX32) {
+		if (is_compat_task() ||
+		    personality(current->personality) == PER_LINUX32) {
 #ifdef CONFIG_COMPAT
 			for (j = 0; compat_hwcap_str[j]; j++)
 				if (compat_elf_hwcap & (1 << j))

As discussed here:

http://article.gmane.org/gmane.linux.kernel/2209217

-- 
Catalin

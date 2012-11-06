From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Nov 2012 11:18:19 -0800
Subject: [GIT PULL] Calxeda ECX-2000 support
In-Reply-To: <50917936.2030405@gmail.com>
References: <50917936.2030405@gmail.com>
Message-ID: <20121106191819.GA11353@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 02:17:10PM -0500, Rob Herring wrote:
> Arnd, Olof,
> 
> Please pull support for Calxeda ECX-2000 SOC.
> 
> There will be a trivial conflict with the GIC move to drivers/irqchip once
> that goes in. 
> 
> Rob
> 
> The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:
> 
>   Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)
> 
> are available in the git repository at:
> 
>   git://sources.calxeda.com/kernel/linux.git tags/calxeda-ecx-2000
> 
> for you to fetch changes up to e095c0d122c09efabe7d4136ce77f72c636c4879:
> 
>   ARM: highbank: Add initial ECX-2000 support (2012-10-31 13:47:01 -0500)
> 

The addition of include of core.h in sysregs.h gives me a build error on
multi_v7_defconfig due to missing guard ifdefs. I've added the following
patch on top of your branch.


commit 9186cea8283b0d235719e82607a1aec81db7ab8d
Author:     Olof Johansson <olof@lixom.net>
AuthorDate: Tue Nov 6 11:09:10 2012 -0800
Commit:     Olof Johansson <olof@lixom.net>
CommitDate: Tue Nov 6 11:09:10 2012 -0800

    ARM: highbank: add ifdef guards to core.h
    
    Fixes build error due to multiple includes:
    
    In file included from arch/arm/mach-highbank/sysregs.h:23:0,
    from arch/arm/mach-highbank/system.c:20:
    arch/arm/mach-highbank/core.h:8:91: error: redefinition of 'highbank_lluart_map_io'
    In file included from arch/arm/mach-highbank/system.c:19:0:
    arch/arm/mach-highbank/core.h:8:91: note: previous definition of 'highbank_lluart_map_io' was here
    
    Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/arm/mach-highbank/core.h b/arch/arm/mach-highbank/core.h
index 286ec82..068c687 100644
--- a/arch/arm/mach-highbank/core.h
+++ b/arch/arm/mach-highbank/core.h
@@ -1,3 +1,6 @@
+#ifndef __HIGHBANK_CORE_H
+#define __HIGHBANK_CORE_H
+
 extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
 extern void highbank_clocks_init(void);
 extern void highbank_restart(char, const char *);
@@ -18,3 +21,5 @@ extern void highbank_smc1(int fn, int arg);
 extern void highbank_cpu_die(unsigned int cpu);
 
 extern struct smp_operations highbank_smp_ops;
+
+#endif

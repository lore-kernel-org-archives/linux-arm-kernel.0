From: rgb@redhat.com (Richard Guy Briggs)
Date: Tue, 4 Feb 2014 11:25:04 -0500
Subject: [PATCH v2 1/6] audit: Enable arm64 support
In-Reply-To: <20140203160659.GA19292@madcap2.tricolour.ca>
References: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
 <1389946399-4525-2-git-send-email-takahiro.akashi@linaro.org>
 <20140123141808.GD27520@arm.com> <52E5EAC1.2070306@linaro.org>
 <20140129202127.GA24068@madcap2.tricolour.ca>
 <20140129223652.GA13702@madcap2.tricolour.ca>
 <52EF304F.80202@linaro.org>
 <20140203160659.GA19292@madcap2.tricolour.ca>
Message-ID: <20140204162504.GA18507@madcap2.tricolour.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/02/03, Richard Guy Briggs wrote:
> On 14/02/03, AKASHI Takahiro wrote:
> > Richard,
> 
> Takahiro,

Takahiro,

> > On 01/30/2014 07:36 AM, Richard Guy Briggs wrote:
> > >On 14/01/29, Richard Guy Briggs wrote:
> > >>On 14/01/27, AKASHI Takahiro wrote:
> > >>>[To audit maintainers]
> > >>>
> > >>>On 01/23/2014 11:18 PM, Catalin Marinas wrote:
> > >>>>On Fri, Jan 17, 2014 at 08:13:14AM +0000, AKASHI Takahiro wrote:
> > >>>>>--- a/include/uapi/linux/audit.h
> > >>>>>+++ b/include/uapi/linux/audit.h
> > >>>>>@@ -327,6 +327,8 @@ enum {
> > >>>>>  /* distinguish syscall tables */
> > >>>>>  #define __AUDIT_ARCH_64BIT 0x80000000
> > >>>>>  #define __AUDIT_ARCH_LE	   0x40000000
> > >>>>>+#define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> > >>>>>+#define AUDIT_ARCH_AARCH64EB	(EM_AARCH64|__AUDIT_ARCH_64BIT)
> > >>>>>  #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> > >>>>>  #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
> > >>>>>  #define AUDIT_ARCH_ARMEB	(EM_ARM)
> > >>>>>diff --git a/init/Kconfig b/init/Kconfig
> > >>>>>index 79383d3..3aae602 100644
> > >>>>>--- a/init/Kconfig
> > >>>>>+++ b/init/Kconfig
> > >>>>>@@ -284,7 +284,7 @@ config AUDIT
> > >>>>>
> > >>>>>  config AUDITSYSCALL
> > >>>>>  	bool "Enable system-call auditing support"
> > >>>>>-	depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT))
> > >>>>>+	depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT) || ARM64)
> > >>>>
> > >>>>The usual comment for such changes: could you please clean this up and
> > >>>>just use something like "depends on HAVE_ARCH_AUDITSYSCALL"?
> > >>>
> > >>>Do you agree to this change?
> > >>>
> > >>>If so, I can create a patch, but have some concerns:
> > >>>1) I can't verify it on other architectures than (arm &) arm64.
> > >>>2) Some architectures (microblaze, mips, openrisc) are not listed here, but
> > >>>    their ptrace.c have a call to audit_syscall_entry/exit().
> > >>>    (audit_syscall_entry/exit are null if !AUDITSYSCALL, though)
> > >>
> > >>I can try: ppc s390 x86_64 ppc64 i686 s390x
> > >
> > >These arches above all pass compile and basic tests with the following patches applied:
> > >
> > >	audit: correct a type mismatch in audit_syscall_exit() pending (already upstream)
> > >
> > >	audit: Modify a set of system calls in audit class definitions (already upstream)
> > >
> > >	[PATCH v3] audit: Add generic compat syscall support
> > >
> > >	[PATCH v2] audit: Enable arm64 support
> > >	[PATCH v2] arm64: Add regs_return_value() in syscall.h
> > >	[PATCH v2] arm64: Add audit support
> > >	[PATCH v2] arm64: audit: Add 32-bit (compat) syscall support
> > >	[PATCH v2] arm64: audit: Add makefile rule to create unistd_32.h for compat syscalls
> > >	[PATCH v2] arm64: audit: Add audit hook in ptrace/syscall_trace
> > 
> > I think that you missed Catalin's suggestion.
> 
> I didn't miss his suggestions.  I think they are a good way to go, but I
> wanted to make a test at referrable point in time to validate the work
> to that point and to avoid introducing errors by mis-interpreting ideas
> that were not yet fully-formed patches.
> 
> > Please use the patch I will post after this message and try it again, please?
> 
> I was certainly intending to do so.

I have tested the new sets from Catalin and you and everything passes ok.

> > Thanks,
> > -Takahiro AKASHI
> > 
> > >>>So I'm afraid that the change might break someone's assumption.
> > >>>
> > >>>Thanks,
> > >>>-Takahiro AKASHI
> > >>
> > >>- RGB
> > >
> > >- RGB
> 
> - RGB

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545

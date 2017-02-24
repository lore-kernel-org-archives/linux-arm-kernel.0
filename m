From: cdall@linaro.org (Christoffer Dall)
Date: Fri, 24 Feb 2017 11:16:50 +0100
Subject: [RFC PATCH 00/13] arm64/kvm: use common sysreg definitions
In-Reply-To: <1485885951-2747-1-git-send-email-mark.rutland@arm.com>
References: <1485885951-2747-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170224101650.GE1409@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Jan 31, 2017 at 06:05:38PM +0000, Mark Rutland wrote:
> Whenever we add new functionality involving new system registers, we need to
> add sys_reg() definitions so that we can access the registers regardless of
> whether the toolchain can assemble them. At the same time, we have to add
> duplicate definitions of the register encodings to KVM's sysreg tables, so that
> we can handle any configurable traps. This redundancy is unfortunate, and
> defining the encodings directly in the sysreg tables can make those tables
> difficult to read.
> 
> This series attempts to address both of these issues by allowing us to use
> common sys_reg() mnemonics in <asm/sysreg.h> to initialise KVM's sysreg tables.
> To that end, this series tries to make <asm/sysreg.h> the canonical location
> for common sysreg encodings.
> 
> Largely, I've only attacked the AArch64-native SYS encodings required by KVM
> today, though for the debug and perfmon groups it was easier to take the whole
> group from the ARM ARM than to filter them to only what KVM needed. I've
> ignored CP{15,14} registers for now, but these could be encoded similarly.
> 
> To verify that I haven't accidentally broken KVM, I've diffed sys_regs.o and
> sys_regs_generic_v8.o on a section-by-section basis before and after the series
> is applied. The .text, .data, and .rodata sections (and most others) are
> identical. The __bug_table section, and some .debug* sections differ, and this
> appears to be due to line numbers changing due to removed lines.
> 
> One thing I wasn't sure how to address was banks of registers such as
> PMEVCNTR<n>_EL0. We currently enumerate all cases for our GICv3 definitions,
> but it seemed painful to expand ~30 cases for PMEVCNTR<n>_EL0 and friends, and
> for these I've made the macros take an 'n' parameter.
> 
> The series is based on the arm64/for-next/core branch, since it relies on
> commit c9ee0f98662a6e35 ("arm64: cpufeature: Define helpers for sys_reg id")
> for the definition of SYS_DESC().
> 

I did not do a full in-depth review, but I really like this overall
change and the changes to KVM look great to me.

Thanks for doing this!
-Christoffer

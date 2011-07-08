From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 8 Jul 2011 12:11:40 +0100
Subject: [PATCH v4 10/40] ARM: mm: proc-arm1020: Use the new processor
	struct macros
In-Reply-To: <4E16E390.5050607@mvista.com>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
	<1310048867-14172-11-git-send-email-dave.martin@linaro.org>
	<4E16E390.5050607@mvista.com>
Message-ID: <20110708111140.GA2115@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 03:01:36PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 07-07-2011 18:27, Dave Martin wrote:
> 
> >Signed-off-by: Dave Martin<dave.martin@linaro.org>
> >---
> >  arch/arm/mm/proc-arm1020.S |   45 +++++--------------------------------------
> >  1 files changed, 6 insertions(+), 39 deletions(-)
> 
> >diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
> >index 6c4e7fd..6746966 100644
> >--- a/arch/arm/mm/proc-arm1020.S
> >+++ b/arch/arm/mm/proc-arm1020.S
> [...]
> >@@ -477,38 +468,14 @@ arm1020_crval:
> [...]
> >  	.section ".rodata"
> >
> >-	.type	cpu_arch_name, #object
> >-cpu_arch_name:
> >-	.asciz	"armv5t"
> >-	.size	cpu_arch_name, . - cpu_arch_name
> >-
> >-	.type	cpu_elf_name, #object
> >-cpu_elf_name:
> >-	.asciz	"v5"
> >-	.size	cpu_elf_name, . - cpu_elf_name
> >+	string	cpu_arch_name, "armv5t"
> 
>    Doesn't this result in ""armv5t"" string? Or the quotes get
> stripped when expanding macro?

The quotes get stripped.

If the quotes are wanted in the macro expansion, then they must be reapplied
inside the macro.

This allows for example a complicated string argument to be pasted into the
middle of another string:

.macro string s
	.string "1\s\()4"
.endm

	s ",2,3,"

...expands to

	.string "1,2,3,4"

(Though these patches don't make use of that ability.)

Without the quotes at mecro invocation time, the string would be mis-parsed
as multiple arguments.

Cheers
---Dave

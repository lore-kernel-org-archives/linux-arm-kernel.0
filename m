From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 22 Mar 2015 23:11:14 +0100
Subject: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <550F3500.1040608@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <2189259.UNlTC1BNmt@vostro.rjw.lan> <550F3500.1040608@linaro.org>
Message-ID: <5749112.zNnbMCHVxZ@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, March 22, 2015 09:32:48 PM Julien Grall wrote:
> 
> On 22/03/2015 21:49, Rafael J. Wysocki wrote:
> > On Sunday, March 22, 2015 09:05:21 PM Julien Grall wrote:
> >> Hello,
> >>
> >> On 21/03/2015 12:09, Naresh Bhat wrote:
> >>>       From 268dcdafa34a690e2f99c0784ca33a6d2352ecf5 Mon Sep 17 00:00:00 2001
> >>>      From: Hanjun Guo <hanjun.guo at linaro.org <mailto:hanjun.guo@linaro.org>>
> >>>      Date: Sat, 21 Mar 2015 14:43:54 +0800
> >>>      Subject: [PATCH] XEN / ACPI: Make XEN ACPI depend on X86
> >>>
> >>>      When ACPI is enabled on ARM64, XEN ACPI will also compiled
> >>>      into the kernel, but XEN ACPI is x86 dependent, so introduce
> >>>      CONFIG_XEN_ACPI to make it depend on x86 before XEN ACPI is
> >>>      functional on ARM64.
> >>>
> >>>      Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org
> >>>      <mailto:hanjun.guo@linaro.org>>
> >>>      ---
> >>>        drivers/xen/Kconfig  | 4 ++++
> >>>        drivers/xen/Makefile | 2 +-
> >>>        2 files changed, 5 insertions(+), 1 deletion(-)
> >>>
> >>>      diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> >>>      index b812462..a31cd29 100644
> >>>      --- a/drivers/xen/Kconfig
> >>>      +++ b/drivers/xen/Kconfig
> >>>      @@ -253,4 +253,8 @@ config XEN_EFI
> >>>            def_bool y
> >>>            depends on X86_64 && EFI
> >>>
> >>>      +config XEN_ACPI
> >>>      +    def_bool y
> >>>      +    depends on X86 && ACPI
> >>>      +
> >>>        endmenu
> >>>      diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> >>>      index 2ccd359..f4622ab 100644
> >>>      --- a/drivers/xen/Makefile
> >>>      +++ b/drivers/xen/Makefile
> >>>      @@ -13,7 +13,7 @@ CFLAGS_efi.o                += -fshort-wchar
> >>>
> >>>        dom0-$(CONFIG_PCI) += pci.o
> >>>        dom0-$(CONFIG_USB_SUPPORT) += dbgp.o
> >>>      -dom0-$(CONFIG_ACPI) += acpi.o $(xen-pad-y)
> >>>      +dom0-$(CONFIG_XEN_ACPI) += acpi.o $(xen-pad-y)
> >>>        xen-pad-$(CONFIG_X86) += xen-acpi-pad.o
> >>>        dom0-$(CONFIG_X86) += pcpu.o
> >>>        obj-$(CONFIG_XEN_DOM0)            += $(dom0-y)
> >>
> >> [..]
> >>
> >>>
> >>> AFAIK,  There is already a kernel patch exists to fix this issue.  I
> >>> think  Julien or Parth is a right person to ask.  Hence I am CCed Julien
> >>> Grall too.
> >>
> >> The ACPI support for Xen is not ready. So I think avoiding to compile
> >> drivers/xen/acpi.c on ARM64/ARM seems the better solution for now.
> >>
> >> Although, rather than introducing a new CONFIG option, I would use the
> >> same trick we use within the Makefile to avoid hotplug.c on ARM/ARM64.
> >>
> >> ifeq ($(filter y, $(CONFIG_ARM) $(CONFIG_ARM64)), )
> >> dom0-$(CONFIG_ACPI) += acpi.o $(xen-pad-y)
> >> endif
> >
> > Well, is avoiding an extra CONFIG_ option worth the ugliness of this?
> 
> When the support of ACPI for Xen will come, the CONFIG_ option will be 
> an alias to CONFIG_XEN.
> 
> In this case the CONFIG_ option won't bring much improvement to the code 
> and add an extra indirection.
> 
> The "ugliness" option has, at least, the advantage to be tiny and 
> self-contained.

Oh well, not really.  You're moving a config-time check to compile time
which means that it will be done every time this Makefile is executed
and for all architectures that execute it.  Not nice.

Also I think that ia64 is missing from the list, but I may be wrong.

Not to mention the fact that the dependency will be rather difficult to find
for tools like xconfig ...


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

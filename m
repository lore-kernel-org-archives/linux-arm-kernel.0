From: axel.lin@ingics.com (Axel Lin)
Date: Thu, 15 Nov 2012 21:44:07 +0800
Subject: [PATCH 1/4] pinctrl: dove: Prevent NULL dereference if
 of_match_device returns NULL
In-Reply-To: <20121115083511.08f5a16f@skate>
References: <1352955096.6793.1.camel@phoenix> <20121115083511.08f5a16f@skate>
Message-ID: <CAFRkauCybE+UcBD17u3J6hoxEA88GM0tatxkrKtWqVNvDPC9dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/15 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

> Dear Axel Lin,
>
> On Thu, 15 Nov 2012 12:51:36 +0800, Axel Lin wrote:
> > of_match_device() may return NULL.
> >
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
> Could you detail under what conditions of_match_device() may return
> NULL in the specific case of this driver? This of_match_device() call
> is using the same dove_pinctrl_of_match array that is used to ->probe()
> this driver. So I don't see how you can get into ->probe() without
> having a matching entry.
>
> Am I missing something?
>

 hi Thomas,
You are right.

I was thinking when the case CONFIG_OF is not selected,
of_match_ptr(dove_pinctrl_of_match) is NULL and of_match_device returns
NULL.
But this driver only works when CONFIG_OF is selected.

BTW, I found there is no way to compile the dove and kirkwood pinctrl
drivers.
I need add below patch to compile these two drivers, how do you think about
below patch?
( In dove, the USE_OF is optional, it is selected only when MACH_DOVE_DT is
enabled )

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 14f8160..dda6785 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -531,6 +531,8 @@ config ARCH_DOVE
        select CPU_V7
        select GENERIC_CLOCKEVENTS
        select MIGHT_HAVE_PCI
+       select PINCTRL
+       select PINCTRL_DOVE if USE_OF
        select PLAT_ORION_LEGACY
        select USB_ARCH_HAS_EHCI
        help
@@ -542,6 +544,8 @@ config ARCH_KIRKWOOD
        select CPU_FEROCEON
        select GENERIC_CLOCKEVENTS
        select PCI
+       select PINCTRL
+       select PINCTRL_KIRKWOOD
        select PLAT_ORION_LEGACY
        help
          Support for the following Marvell Kirkwood series SoCs:

Regards,
Axel
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121115/be2e1627/attachment-0001.html>

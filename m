From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Oct 2014 12:49:16 +0200
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
Message-ID: <16427778.JB7cnWY0r4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 October 2014 21:02:43 Geert Uytterhoeven wrote:
> +       default 0xe6c40000 if DEBUG_SCIF && (ARCH_R8A73A4 || ARCH_SH7372)
> +       default 0xe6c50000 if DEBUG_SCIF && ARCH_R8A7740
> +       default 0xe6c80000 if DEBUG_SCIF && ARCH_SH73A0
> +       default 0xe6e58000 if DEBUG_SCIF && ARCH_R8A7794
> +       default 0xe6e60000 if DEBUG_SCIF && (ARCH_R8A7790 || ARCH_R8A7791 || ARCH_R8A7793)
> +       default 0xe8008000 if DEBUG_SCIF && ARCH_R7S72100

Just saw this patch. Note that most other entries do not depend on a particular
SoC but instead on one of the Kconfig entries, and I would like to eventually
change all of them to be the same way.

The main reason for this is that your way is a mix of two methods: if you
build a kernel for just one SoC you get the right entry here, but if you
build the kernel for multiple SoCs combined, you have to edit the address
by hand.

An alternative would be to not define a default here and document the
possible addresses in the help text for DEBUG_SCIF, so that users will
/always/ have to manually edit these, so at least it would be consistent.

	Arnd

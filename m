From: lukas@wunner.de (Lukas Wunner)
Date: Wed, 22 Mar 2017 20:31:11 +0100
Subject: [PATCH v3] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
In-Reply-To: <1490196629-28088-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1490196629-28088-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170322193111.GA8190@wunner.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 03:30:29PM +0000, Ard Biesheuvel wrote:
> On UEFI systems, the PCI subsystem is enumerated by the firmware,
> and if a graphical framebuffer is exposed by a PCI device, its base
> address and size are exposed to the OS via the Graphics Output
> Protocol (GOP).
> 
> On arm64 PCI systems, the entire PCI hierarchy is reconfigured from
> scratch at boot. This may result in the GOP framebuffer address to
> become stale, if the BAR covering the framebuffer is modified. This
> will cause the framebuffer to become unresponsive, and may in some
> cases result in unpredictable behavior if the range is reassigned to
> another device.

Hm, commit message seems to indicate the issue is restricted to arm64,
yet there's no IS_ENABLED(ARM64) to constrain the added code to that arch?


> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, efifb_fixup_resources);

Maybe this can be constrained to PCI_BASE_CLASS_DISPLAY?

Thanks,

Lukas

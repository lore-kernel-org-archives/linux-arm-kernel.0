From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Oct 2013 14:55:16 -0700
Subject: [PATCH v8 1/5] ARM: add basic support for Trusted Foundations
In-Reply-To: <CA+Ln22FdkcxOfq-yxVVQ7vTLWC3TYRBbAOZ=e3WmpSKkgk_DRg@mail.gmail.com>
References: <1381527938-22840-1-git-send-email-acourbot@nvidia.com>
 <1381527938-22840-2-git-send-email-acourbot@nvidia.com>
 <20131015110725.GZ25034@n2100.arm.linux.org.uk>
 <525D7969.5060908@nvidia.com>
 <CA+Ln22FdkcxOfq-yxVVQ7vTLWC3TYRBbAOZ=e3WmpSKkgk_DRg@mail.gmail.com>
Message-ID: <20131028215516.GA10833@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 12:04:43PM +0100, Tomasz Figa wrote:
> Hi,
> 
> 2013/10/15 Alex Courbot <acourbot@nvidia.com>:
> > On 10/15/2013 04:07 AM, Russell King - ARM Linux wrote:
> >>
> >> On Fri, Oct 11, 2013 at 02:45:34PM -0700, Alexandre Courbot wrote:
> >>>
> >>> Trusted Foundations is a TrustZone-based secure monitor for ARM that
> >>> can be invoked using the same SMC-based API on all supported
> >>> platforms. This patch adds initial basic support for Trusted
> >>> Foundations using the ARM firmware API. Current features are limited
> >>> to the ability to boot secondary processors.
> >>>
> >>> Note: The API followed by Trusted Foundations does *not* follow the SMC
> >>> calling conventions. It has nothing to do with PSCI neither and is only
> >>> relevant to devices that use Trusted Foundations (like most Tegra-based
> >>> retail devices).
> >>>
> >>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> >>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> >>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> >>> ---
> >>>   .../arm/firmware/tl,trusted-foundations.txt        | 20 ++++++
> >>>   .../devicetree/bindings/vendor-prefixes.txt        |  1 +
> >>>   arch/arm/Kconfig                                   |  2 +
> >>>   arch/arm/Makefile                                  |  1 +
> >>>   arch/arm/firmware/Kconfig                          | 28 ++++++++
> >>>   arch/arm/firmware/Makefile                         |  1 +
> >>>   arch/arm/firmware/trusted_foundations.c            | 79
> >>> ++++++++++++++++++++++
> >>>   arch/arm/include/asm/trusted_foundations.h         | 68
> >>> +++++++++++++++++++
> >>>   8 files changed, 200 insertions(+)
> >>>   create mode 100644
> >>> Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
> >>>   create mode 100644 arch/arm/firmware/Kconfig
> >>>   create mode 100644 arch/arm/firmware/Makefile
> >>>   create mode 100644 arch/arm/firmware/trusted_foundations.c
> >>>   create mode 100644 arch/arm/include/asm/trusted_foundations.h
> >>
> >>
> >> Is having this under arch/arm appropriate?  What happens if the API
> >> gets re-used on ARM64 for example?  Would drivers/firmware be a better
> >> cross-arch location for this?
> >
> >
> > The reason why this has been put into arch/arm is that the firmware_ops
> > feature this patch depends also resides there
> > (arch/arm/include/asm/firmware.h).
> >
> > On the other hand it might also make sense to move firmware_ops out of ARM
> > since I don't see anything ARM-specific with it. Tomasz, could we have your
> > thoughts on this?
> 
> I don't see anything wrong in moving this out of arch/arm, feel free
> to do so.
> 
> However I guess that some (or all) of the names will have to
> be put into a more separate namespace, as the term "firmware" is a bit
> too generic IMHO. Possibly something like platform_firmware could be
> better.
> 
> What do you think?

I think we can probably merge this under arch/arm now, and when we figure out
what needs to be common with ARM64 we can move it out to a good location. It
might be that mostly just a header file with ABI conventions needs to be
shared, not actual implementation, for example.


-Olof

From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Sat, 30 Aug 2014 03:17:31 +0100
Subject: [PATCH 2/2] efi/arm64: use UEFI for system reset
In-Reply-To: <20140829162534.GG4995@arm.com>
References: <1409324757-12607-1-git-send-email-ard.biesheuvel@linaro.org>
 <1409324757-12607-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140829160448.GF4995@arm.com>
 <CAKv+Gu-u6Q_t9yU4Cb=0-XmEkmejuMwpy2AN8cBABUHEZxg4dg@mail.gmail.com>
 <20140829162534.GG4995@arm.com>
Message-ID: <20140830021731.GD22224@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 05:25:34PM +0100, Catalin Marinas wrote:
> > For poweroff (the other patch), it may not make a huge difference, but
> > the SBBR does state it explicitly.
> 
> The SBBR scope reads like this:
> 
>   This document defines the boot and Runtime Services that are expected
>   by an enterprise platform Operating System or hypervisor, for an ARM
>   AArch64 server, which is SBSA-compliant and follows the UEFI and ACPI
>   specifications.
> 
> Which means that it does not apply to non-SBSA or SBSA systems that use
> UEFI but not ACPI?

It applies to all UEFI systems, really. But the SBBR explicitly
enumerates certain features already covered by the spec, to reduce
risk of misinterpretation (i.e. not reading the whole UEFI spec when
implementing).

> > For reboot, we *have* to use EFI reboot in order to support capsules:
> > when using capsules (for instance, for updating the firmware), you
> > need to use EFI reboot as you need to pass the return code of
> > UpdateCapsule() (a runtime service) to ResetSystem()
> 
> That's a better argument ;). But I think with the restart patches you
> could set some priority and if absolutely needed on a platform as
> workaround we could register a driver with a higher priority (and losing
> the above features).

That sounds sensible to me.
But the kernel should probably be very noisy on the console if that
override was done. And we would also want to store that fact
somwehere, to prevent any capsule runtime service calls being made.

/
    Leif

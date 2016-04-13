From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Apr 2016 14:59:29 +0100
Subject: [PATCH] arm64: acpi: add a Kconfig option to prefer ACPI boot
 over DT
In-Reply-To: <CAK-u0QmB7QWBTosbhqVeFXF5ZRjt9UM9h-8wcV+LvXvg1yPkwg@mail.gmail.com>
References: <1460373568-4374-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160412130751.GA8066@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-XYoyRkfMtdSARW0mf5dbztWbjM7hps4yBS6O1hKfRqg@mail.gmail.com>
 <20160412133555.GD8066@e104818-lin.cambridge.arm.com>
 <CAK-u0QmB7QWBTosbhqVeFXF5ZRjt9UM9h-8wcV+LvXvg1yPkwg@mail.gmail.com>
Message-ID: <20160413135929.GB15182@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 12:41:23PM -0700, Roy Franz (HPE) wrote:
> On Tue, Apr 12, 2016 at 6:35 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Tue, Apr 12, 2016 at 03:19:58PM +0200, Ard Biesheuvel wrote:
> >> On 12 April 2016 at 15:07, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> > On Mon, Apr 11, 2016 at 01:19:28PM +0200, Ard Biesheuvel wrote:
> >> >> If both ACPI and DT platform descriptions are available, and the
> >> >> kernel was configured at build time to support both flavours, the
> >> >> default policy in absence of a acpi=[off|force] kernel command line
> >> >> parameter is to prefer DT over ACPI.
> >> >>
> >> >> This adds an option to invert that default policy, and prefer ACPI
> >> >> over DT instead. Note that this policy is still superseded by the
> >> >> value of the acpi= command line parameter.
> >> >
> >> > Why do we need another method to specify an ACPI boot? I thought those
> >> > vendors going for ACPI wouldn't be bothered with DT anyway.
> >> >
> >> > I'm not keen on having kernel builds with different behavior in respect
> >> > of whether ACPI or DT is preferred.
> >>
> >> How about adding support for acpi=on then? Currently, we only have
> >> acpi=off or acpi=force, and there is no way (i.e., for a distro
> >> installer) to boot via ACPI if it can but fall back to DT otherwise.
> >> Some enterprise features (like RAS) depend on ACPI boot so it may
> >> simply preferred but not mandated in some cases.
> >
> > Since this is a distro preference, I would rather have an acpi=on
> > option.
> 
> While this is a 'distro preference', I think it is somewhat ugly for
> this to be configured on the commandline.   We (HPE) don't support DT,
> and I don't think that is likely to change. While we control the
> firmware for our main internal platform, and don't provide a DT there,
> we also do development and testing on other platforms where the
> firmware may provide a DT, but we never want to use it.  This requires
> developers/users to specify "acpi=force" on the command-line to boot
> in a supported manner.

You wrongly assume that everyone wants ACPI by generalising "we" (HPE)
to "developers/users".

In an ideal world where both ACPI and DT (if provided by firmware) are
equally supported, such option wouldn't be much of an issue. But we are
not there yet with some platforms having ACPI in an experimental state
or relying on distro-only kernel patches. This means that a _mainline_
kernel configured with such ACPI default on option would require an
explicit acpi=off on the command line to boot with DT. Since you don't
always know which kernel you'd run, you pretty much end up with an acpi=
option on the command line permanently.

Maybe those vendors providing both ACPI and DT have a good reason like
ACPI support not ready.

> I would much rather be able to configure the kernel to prefer (or even
> unconditionally require) ACPI to boot, as this will be the normal,
> default, and only supported way to boot for our platform, and I expect
> this to also be the case in much of the enterprise space.

I really don't care about which platform recommends ACPI or DT. What I
care about is not having to enable certain config option depending on
which platform you target as this leads to config fragmentation (think
of single Image). I much prefer a clear kernel policy on whether ACPI or
DT is used if both are provided by firmware and we've already made that
call - DT takes precedence.

> Since I don't think it is possible to build an arm64 kernel with only
> ACPI, and no DT support, I think a kconfig option to select the
> preferred HW description to be used is the better solution.

The (multi-platform, single Image) kernel is not in a position to assess
whether ACPI or DT is in a better state for a given SoC. We should leave
this "ACPI preferred" choice to the code running before the kernel by
simply providing only ACPI tables.

-- 
Catalin

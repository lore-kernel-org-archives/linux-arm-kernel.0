From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 28 Jun 2018 12:25:06 +0200
Subject: [RFC/RFT PATCH 0/2] disable_hest quirk on HP m400 with bad UEFI
 firmwware
In-Reply-To: <20180628100656.10692-1-james.morse@arm.com>
References: <20180628100656.10692-1-james.morse@arm.com>
Message-ID: <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 28 June 2018 at 12:06, James Morse <james.morse@arm.com> wrote:
> There are reports[0] that HPE's 'ProLiant m400 Server' (aka moonshot) has
> broken RAS support, and adding disable_hest to the kernel cmdline is the
> only way to make the board boot if APEI support is built into the kernel.
>
> After Mark Salter's investigation[1] we know that UEFI's ExitBootServices
> is doing something that causes a fatal error to be written to GHES.2.
> Once the kernel finds this, it falsely assume it was due to something that
> happened during boot, and panic()s.
>
> This series adds a DMI quirks table to hest.c, and adds a helper that lets
> us query the UEFI system table version, to set hest_disabled on this
> platform.
>
> Testing the HEST table vendor and revision is a problem as this would
> match all 'HPE ProLiant', some of which may be a totally different CPU
> architecture.
>
>
> I don't have access to an m400, these DMI and UEFI values were taken from
> the crashlog report at [0], then tested with the equivalent fields on
> Seattle.
>

I understand the desire to keep running these M400s as long as they
have some life left in them, but the reality is that they are end of
life already, and not many were manufactured to begin with.

Given how the upstream kernel is aimed at future development, I don't
think we should fix this in the upstream kernel at all. Distros are
free to do what they like, of course, and I'm sure RedHat already have
a fix for this in their downstream kernel. But putting this upstream
means we will never be able to remove it again, which would be
especially unfortunate given that it is the first ever DMI quirk for
arm64, which we tried *very* hard to avoid, also because we don't
initialize the DMI framework as early as x86 does, and so once we open
the floodgates, we will run into issues where we will need to reorder
the init sequence to make DMI data available early enough.

As for the efi.h patch: I don't object to adding code that makes the
spec revision available, but note that this is *not* a firmware build
number, and so it should not be used as such. Also, given that m400 is
EOL and unmaintained, no firmware updates are expected, and so
assuming that there will be a UEFI 2.7 based update in the future
seems rather optimistic.

Ultimately, it is not up to me to decide whether

a) DMI quirks will be permitted on arm64
b) we care about m400 enough to put this quirk in the upstream kernel

but I'd prefer it if we steered clear of this.

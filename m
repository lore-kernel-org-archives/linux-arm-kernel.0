From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Jul 2018 18:01:34 +0100
Subject: [RFC PATCH 0/2] efi: add contents of LinuxExtraArgs EFI var to
 command line
In-Reply-To: <20180704154919.18564-1-ard.biesheuvel@linaro.org>
References: <20180704154919.18564-1-ard.biesheuvel@linaro.org>
Message-ID: <20180712170134.GF26935@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Wed, Jul 04, 2018 at 05:49:17PM +0200, Ard Biesheuvel wrote:
> As noted by Ian, many DMI based quirks for x86 ACPI machines disable
> features that can also be disabled via the kernel command line. Similarly,
> a quirk is under discussion for a arm64 ACPI machine [0] that explodes
> when enabling support for hardware error reporting via the ACPI HEST table.
> 
> When support for DMI tables was introduced to arm64 and ARM, the agreement
> was that they are informational only, i.e., provided to userland to describe
> the platform, not for keying off of to enable quirks in the kernel.
> 
> There are a couple of reasons for this:
> - Unlike the x86 architecture, where virtually all platforms are PC variants,
>   and the presence of ACPI and DMI tables may be assumed, the arm64 architecture
>   is much more heterogeneous, and none of UEFI, ACPI or DMI or actually mandated
>   or especially common across arm64 platforms; using DMI only makes sense for
>   working around a limited subset of platform issues that have to do with
>   firmware running on platforms that bother to implement it in the first place.
> - DMI is not initialized as early as it is on x86, and doing so is not trivial.
>   This means that even on ACPI/DMI machines, some issues may require quirks that
>   are enabled in a different way, or we need to refactor the DMI support so that
>   we can enable it as early as x86 does.
> - Using DMI tables fundamentally means quirking *after* the fact, which makes it
>   a moving target. Some quirks may require the DMI match table to be updated if
>   someone happens to change a string in the DMI tables when shipping a mostly
>   identical platform.
> 
> So instead, let's provide these platforms with the facilities required to enable
> such quirks at the platform level. Especially for UEFI systems, if upgrading
> firmware is a reasonable prerequisite for being able to upgrade to the latest
> kernel, having to run a script that sets a UEFI variable (either via the Linux
> command line of from the UEFI shell) should not be an unreasonable requirement
> either, and so we can solve part of this issue by configuring extra command line
> arguments persistenly from the firmware environment. This solves all the above
> issues in an unintrusive manner, given that the kernel command line is already
> made available extremely early in the boot, and the fact that it already permits
> a wide range of configuration options and overrides to be set, including the
> 'hest_disable=1' option that works around the issue addressed by [0].

I'm torn on this one. Whilst I strongly agree that keying off DMI tables
to detect firmware quirks is a bad idea on arm64, silently extending the
kernel command-line also has its downsides. The command-line provides ways
to override kernel defaults, so if a user has forced a feature on/off,
then I think this should take precedence over quirks and we should taint
instead, rather than silently override the option.

I'd be interested in other opinions on this.

Will

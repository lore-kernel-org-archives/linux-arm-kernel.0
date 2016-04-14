From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 14 Apr 2016 17:46:54 +0100
Subject: [PATCH] arm64: acpi: add a Kconfig option to prefer ACPI boot
 over DT
In-Reply-To: <570E7FFE.6050007@hpe.com>
References: <1460373568-4374-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160412130751.GA8066@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-XYoyRkfMtdSARW0mf5dbztWbjM7hps4yBS6O1hKfRqg@mail.gmail.com>
 <20160412133555.GD8066@e104818-lin.cambridge.arm.com>
 <CAK-u0QmB7QWBTosbhqVeFXF5ZRjt9UM9h-8wcV+LvXvg1yPkwg@mail.gmail.com>
 <20160413135929.GB15182@e104818-lin.cambridge.arm.com>
 <570E7FFE.6050007@hpe.com>
Message-ID: <20160414164653.GE15182@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 10:21:02AM -0700, Roy Franz wrote:
> On 04/13/2016 06:59 AM, Catalin Marinas wrote:
> >On Tue, Apr 12, 2016 at 12:41:23PM -0700, Roy Franz (HPE) wrote:
> >>While this is a 'distro preference', I think it is somewhat ugly for
> >>this to be configured on the commandline.   We (HPE) don't support DT,
> >>and I don't think that is likely to change. While we control the
> >>firmware for our main internal platform, and don't provide a DT there,
> >>we also do development and testing on other platforms where the
> >>firmware may provide a DT, but we never want to use it.  This requires
> >>developers/users to specify "acpi=force" on the command-line to boot
> >>in a supported manner.
> >
> >You wrongly assume that everyone wants ACPI by generalising "we" (HPE)
> >to "developers/users".
> 
> This is not what I am assuming or thinking.  I think that a large enough set
> of arm64 developers and users care primarily/only about ACPI,
> and would benefit from not having to have an "acpi=xx" on the command-line
> forevermore.

That's to the detriment of those wanting to use DT on such platforms and
would have to pass "acpi=off" (because I don't believe in different
kernel images/configurations for different platforms).

You may argue that no-one wants to use DT if the firmware also provides
ACPI. As we currently stand, there are two main camps on ARM:

1. The DT one, unlikely to ever bother with ACPI for their platforms
   (e.g. mobile). This camp never cares about DT vs ACPI preference
   because their firmware would never provide the latter

2. The ACPI early adopters. Of these, there are two sub-categories:
   a) those who care about mainline Linux and provide a DT (in addition
      to ACPI) with their firmware as the more mature solution
   b) those who only run distro kernels with tons of patches and think
      that ACPI on ARM is ready, the last thing to solve being the boot
      priority

As maintainer, I only care about (1) and (2.a). When ACPI on ARM will be
mature enough and more feature-rich than DT (e.g. RAS features), we can
revisit the ACPI vs DT boot priority, potentially making a switch
without any additional config options. Who knows, maybe at that point no
firmware will provide both DT and ACPI and we won't need to do anything
in the kernel.

But in the meantime, from a _mainline_ perspective, DT is considered the
recommended/better supported option and the boot preference should only
be overridden by users explicitly via command line arguments.

-- 
Catalin

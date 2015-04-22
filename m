From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 22 Apr 2015 12:37:27 -0700
Subject: [PATCH] arm64: errata: add workaround for cortex-a53 erratum
 #845719
In-Reply-To: <1427792898-22297-1-git-send-email-will.deacon@arm.com>
References: <1427792898-22297-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAMAWPa_NnQ7RSds7jM3bULqC+oMOy5HC6DNTT39Tez8C4MGc=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Mar 31, 2015 at 2:08 AM, Will Deacon <will.deacon@arm.com> wrote:
> When running a compat (AArch32) userspace on Cortex-A53, a load at EL0
> from a virtual address that matches the bottom 32 bits of the virtual
> address used by a recent load at (AArch64) EL1 might return incorrect
> data.
>
> This patch works around the issue by writing to the contextidr_el1
> register on the exception return path when returning to a 32-bit task.
> This workaround is patched in at runtime based on the MIDR value of the
> processor.
>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Curious if you are planning to flag this for v3.19-stable?  I also
noticed that the recent one from Bo Yan[1] for A57 might also be
missing from stable/linux-3.19.y.  A quick check suggests they both
apply cleanly to stable/linux-3.19.y

Speaking of stable, is anyone at ARM working on getting these into
older versions of stable?

For v3.18, I did a quick backport (and simple boot test on qemu) of
Andre's framework plus the errata I'm aware of to stable/linux-3.18.y,
and it seems to work (kernel reports "alternative: enabling workaround
for ARM erratum 832075) so getting the framework plus errata into
stable/linux-3.18.y seems like a good idea too and pretty straight
forward too.

Kevin

[1] commit 6d1966dfd6e0 (arm64: fix midr range for Cortex-A57 erratum 832075)
[2] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git
wip/v3.18/arm64-errata

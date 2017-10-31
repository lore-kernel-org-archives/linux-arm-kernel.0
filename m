From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 31 Oct 2017 12:57:29 +0100
Subject: [PATCH] arm64: support __int128 on gcc 5+
In-Reply-To: <20171031115156.GF5584@arm.com>
References: <CAHmME9pE+G0V-nyKchQyG03YXbPjGykL1xX0M8E544Rh7QrgOQ@mail.gmail.com>
 <20171031114319.24436-1-Jason@zx2c4.com> <20171031115156.GF5584@arm.com>
Message-ID: <CAHmME9qZq4rsspQ2BFWMXp1boj8YRuvbyfqKWtdPs=6BO9Bm0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Oct 31, 2017 at 12:51 PM, Will Deacon <will.deacon@arm.com> wrote:
> Which code in the kernel actually uses 128-bit types directly? I know we
> have some unfortunate occurences in our headers (including uapi) for the
> vector registers, but I thought we generally used asm or copy routines to
> access those.

math64.h provides it, and various things throughout use those
functions. Notably, the scheduler and kvm use those the __int128
functions. There's also an elliptic curve implementation that uses it,
which makes a big difference. And soon I'll be adding an
implementation of curve25519 that will make heavy use of these
instructions for significant speedups as well.

Generally, adding this CONFIG_ARCH key is a hint for current and
future bits of code, so that they can use the faster 128-bit
implementations when available. Not providing it when it's there and
available would be silly. This wasn't originally added to the
architecture, because when the Kconfig symbol was added, gcc didn't
have sane support for it on aarch64. But now it does, so let's support
it.

Jason

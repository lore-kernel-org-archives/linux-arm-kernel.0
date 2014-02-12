From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 12:51:05 +0100
Subject: [RFC/PATCH 0/3] Add devicetree scanning for randomness
In-Reply-To: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org>
References: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <201402121251.06280.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014, Laura Abbott wrote:
> This is an RFC to seed the random number pool earlier when using devicetree.
> The big issue this is trying to solve is the fact that the stack canary for
> ARM tends to be the same across bootups of the same device. This is because
> the random number pools do not get initialized until after the canary has
> been set up. The canary can be moved later, but in general there is still
> no way to reliably get random numbers early for other features (e.g. vector
> randomization).

Implementation-wise this looks reasonable, and it obviously addresses a
very real problem.

> The goal here is to allow devices to add to the random pools via
> add_device_randomness or some other method of their chosing at FDT time.
> I realize that ARCH_RANDOM is already available but this didn't work because
> 1) ARCH_RANDOM is not multi-platform compatible without added
> infrastructure to ARM

That could certainly be done, but I agree that a more generic
approach like you did is nicer. One thing that might be useful
would be to wire up your OF_RANDOM infrastructure as a generic
implementation of ARCH_RANDOM, and merge your header file into
include/asm-generic/archrandom.h, with an added way to call
arch_get_random_long() for the devices you add.

> The big reason to skip ARCH_RANDOM though is that the random number generation
> we have would be reasonable if only seeded earlier.

Yes, makes sense.

I also wonder if we should add a 'trivial' implementation that just
reads a DT property full of random numbers to use as either an initial
seed, or to feed into arch_get_random_long(). This would allow the
boot loader to pass any entropy it has already gathered into the kernel,
but leaves the danger that people might pass static not-so-random data
through a precompiled dtb file ;-). If we get the boot loaders to be
smart enough, doing only this would be a much simpler kernel implementation
than your suggestion, but I'm not sure how far I want to trust boot loaders.

Another possibilitiy is to mix in the any contents of a "local-mac-address"
property into the entropy at early DT probing, which would still be
deterministic for a given machine and should not count as entropty,
but at least give each machine with this property a unique seed in the
absence of any other entropy source.

	Arnd

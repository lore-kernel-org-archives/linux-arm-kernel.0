From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jul 2015 22:41:51 +0200
Subject: [PATCH] ARM: BCM: Restrict Broadcom BCM470X / BCM5301X to non-LPAE
In-Reply-To: <55A68C9C.8000303@gmail.com>
References: <1436897535-3782-1-git-send-email-f.fainelli@gmail.com>
 <9845978.JUsldTlF3B@wuerfel> <55A68C9C.8000303@gmail.com>
Message-ID: <5941809.XWvPzT6esn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 July 2015 09:38:52 Florian Fainelli wrote:
> 
> I like the idea in general, but I think this is going to be a very
> tedious job to collect every single CR values for ARMv7 processors to
> determine whether they are pure v7 or v7e... Maybe we could use
> kernelci.org to start extracting the relevant lines in bootlogs and
> people can start adding their own chips one by one?

No, we know most of them:

Cortex-A5, A8, A9: ARMv7, no LPAE, no IDIV
Cortex-A7, A15, A12, A17: ARMv7VE, no LPAE, no IDIV


Almost everyone uses the above cores unmodified.

The ones I'm not 100% sure about are:

Marvell PJ4 (almost certainly ARMv7)
Marvell PJ4B (probably ARMv7 plus IDIV without LPAE)
Qualcomm Scorpion (probably ARMv7)
Qualcomm Krait (probably ARMv7 plus IDIV without LPAE)
Broadcom Brahma-B15 (almost certainly ARMv7VE)

We basically just need to find out from the mach-qcom and
mach-mvebu maintainers what combination of LPAE and IDIV
they need to support, and you can find out about B15.

If my list above is correct, there are no CPUs that have
LPAE but don't have IDIV, and we just need to decide how
to represent that.

	Arnd

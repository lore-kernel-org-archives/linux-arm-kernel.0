From: klaus.goger@theobroma-systems.com (klaus.goger at theobroma-systems.com)
Date: Thu, 17 Nov 2016 21:57:43 +0100
Subject: [PATCH] ARM: dts: sunxi: Explicitly enable pull-ups for MMC pins
In-Reply-To: <20161117093438.17988-1-wens@csie.org>
References: <20161117093438.17988-1-wens@csie.org>
Message-ID: <ea02ec937a12d6ca2a2e0d8bbea5c484@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-11-17 10:34, Chen-Yu Tsai wrote:
> Given that MMC starts in open-drain mode and the pull-ups are required,
> it's best to enable it for all the pin settings.

It's even more complicated than that with MMC. It starts in open-drain 
mode for
CMD during initialization but changes to push-pull afterwards. The card 
has
internal pull-ups to prevent bus floating during setup and will disable 
them
after switching to 4bit mode (or 8bit for eMMC when available).
But even after switching to push-pull drivers there are states the bus 
would
float and pull ups have to ensure a high level on the bus.

See JESD84-A441 chapter 7.15 ff as reference.

   The difference between the P-bit and Z-bit is that a P-bit is actively 
driven
   to HIGH by the card respectively host output driver, while Z-bit is 
driven to
  (respectively kept) HIGH by the pull-up resistors Rcmd respectively 
Rdat.


Enabling the pull ups on the CPU would be the right choice considering 
that
most boards will not have external pull-ups. Even if they would have 
one,
adding the internal in parallel would work in almost all cases and the
increase in power consumption would be negligible.

Cheers,
Klaus

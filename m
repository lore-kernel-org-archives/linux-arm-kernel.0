From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Jan 2013 07:41:19 -0500
Subject: [PATCH 3.8-rc] arm: mvebu: use global interrupts for GPIOs on
 Armada XP
In-Reply-To: <1357576018-24157-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357576018-24157-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130108124119.GT5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 05:26:58PM +0100, Thomas Petazzoni wrote:
> The Armada XP GPIO controller has two ways of notifying interrupts:
> using global interrupts or using per-CPU interrupts. In an attempt to
> use the best available features, the 'marvell,armadaxp-gpio'
> compatible string selects a variant of the gpio-mvebu driver that
> makes use of the per-CPU interrupts.
> 
> Unfortunately, this doesn't work properly in a SMP context, because we
> fall into cases where the GPIO interrupt is enabled on CPU X at the
> GPIO controller level, but on CPU Y at the interrupt controller
> level. It is not yet clear how to fix that easily.
> 
> So for 3.8, our approach is to switch to global interrupts for GPIOs,
> so that we do not fall into this per-CPU interrupts problem.
> 
> This patch therefore fixes GPIO interrupts on Armada XP
> platforms. Without this patch, GPIO interrupts simply do not work
> reliably, because their proper operation depends on which CPU the code
> requesting the interrupt is running.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> This is 3.8-rc material.
> ---
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi |   14 ++++++--------
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi |   21 +++++++++------------
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi |   21 +++++++++------------
>  3 files changed, 24 insertions(+), 32 deletions(-)

Applied to mvebu/fixes

thx,

Jason.

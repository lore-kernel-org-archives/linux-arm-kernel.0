From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Jul 2014 15:23:54 -0400
Subject: [PATCH] ARM: mvebu: fix SMP boot for Armada 38x and Armada 375
 Z1 in big endian
In-Reply-To: <1404228186-21203-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404228186-21203-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140701192354.GI23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 05:23:06PM +0200, Thomas Petazzoni wrote:
> The SMP boot on Armada 38x and Armada 375 Z1 is currently broken in
> big-endian configurations, and this commit fixes it for both
> platforms.
> 
> For Armada 375 Z1, the problem was in the
> armada_375_smp_cpu1_enable_code part of the code that gets copied to
> the Crypto SRAM as a work-around for an issue of the Z1 stepping. This
> piece of code was not switching the CPU core to big-endian, and not
> endian-swapping the value read from the Resume Address register (the
> value is stored little-endian). Due to the introduction of the
> conditional 'rev r1, r1' instruction, the offset between the 'ldr r0,
> [pc, #4]' instruction and the value it was looking is different
> between LE and BE configurations. To solve this, we instead use one
> 'adr' instruction followed by one 'ldr'.
> 
> For Armada 38x, the problem was simply that the CPU core was not
> switched to big endian in the secondary CPU startup function.
> 
> This change was tested in LE and BE configurations on Armada 385,
> Armada 375 Z1 and Armada 375 A0.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Jason, since the support for SMP was integrated in 3.16, this patch
> should go in the 3.16-rc cycle. Thanks!
> 
>  arch/arm/mach-mvebu/headsmp-a9.S | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied to mvebu/fixes

thx,

Jason.

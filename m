From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Dec 2017 11:59:18 +0100
Subject: [PATCH 4/4] arm: dts: sun8i: a83t: Set timer node to use phy timer
In-Reply-To: <20171211075001.6100-5-mylene.josserand@free-electrons.com>
References: <20171211075001.6100-1-mylene.josserand@free-electrons.com>
 <20171211075001.6100-5-mylene.josserand@free-electrons.com>
Message-ID: <20171213105918.tah3ihvmropmeu5g@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 11, 2017 at 08:50:01AM +0100, Myl?ne Josserand wrote:
> By default, virtual timers are used. These timers need an offset
> that must be set by firmware, for example. In case of SMP support,
> after a reset, this offset is in "unknown" state and produced
> a hang of the kernel.
> 
> Use "arm,cpu-registers-not-fw-configured" property allows to use
> physical timers instead of virtual ones.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>

Your commit log could be a little better, something like:

"
The ARM architected timers use an offset between their physical and
virtual counters. That offset should be configured by the bootloader
in CNTVOFF.

However, the A83t bootloader fails to do so, and we end up with an
undefined offset (which in our case is random), meaning that each CPU
will have a different time, which isn't working very well.

Fix that by setting the arm,cpu-registers-not-fw-configured that will
make Linux use the physical timers instead of the virtual ones. One
possible side effect would be that the virtualization features would
be disabled. However, due to the way the GIC has been integrated in
the system, it is already unusable so we're effectively not losing any
feature.
"

The commit title should be improved too.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171213/d0d1f918/attachment.sig>

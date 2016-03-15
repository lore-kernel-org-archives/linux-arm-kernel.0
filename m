From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Mar 2016 19:29:54 +0100
Subject: [PATCH] ARM: dts: sun8i-q8-common: Do not set constraints on
 dc1sw regulator
In-Reply-To: <1457552339-400-2-git-send-email-hdegoede@redhat.com>
References: <1457552339-400-1-git-send-email-hdegoede@redhat.com>
 <1457552339-400-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20160315182954.GH30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 08:38:59PM +0100, Hans de Goede wrote:
> dc1sw is an on/off only regulator and as such it cannot have constraints.
> 
> This is a limitation of the kernel regulator implementation which resolves
> supplies on the first regulator_get(), which is done after applying
> constraints, and applying the constrains will fail because it calls
> _regulator_get_voltage() and _regulator_do_set_voltage() both of which
> will fail on a switch regulator when there is no supply (yet).
> 
> This causes registering of all axp22x regulators to fail with the
> following errors:
> 
> [    1.395249] vcc-lcd: failed to get the current voltage(-22)
> [    1.405131] axp20x-regulator axp20x-regulator: Failed to register dc1sw
> [    1.412436] axp20x-regulator: probe of axp20x-regulator failed with error -22
> 
> This commit removes the constrains on dc1sw / vcc-lcd fixing this problem
> note that dcdc1 itself is contrained to the exact same values, so this
> does not change anything.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued this as fixes for 4.6.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160315/9b6b9b45/attachment-0001.sig>

From: balbi@ti.com (Felipe Balbi)
Date: Mon, 8 Jul 2013 16:26:34 +0300
Subject: [PATCH v9 0/8] Generic PHY Framework
In-Reply-To: <780E789C2E067A4BB8F69D0BB9EC4F253E9764D5@DBDE04.ent.ti.com>
References: <1372247257-30186-1-git-send-email-kishon@ti.com>
 <780E789C2E067A4BB8F69D0BB9EC4F253E975B5E@DBDE04.ent.ti.com>
 <51D3F773.9000209@ti.com> <20130703132038.GI15056@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E975D6E@DBDE04.ent.ti.com>
 <51D54694.20203@ti.com> <20130704101216.GD4830@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E9764D5@DBDE04.ent.ti.com>
Message-ID: <20130708132634.GC31221@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 08, 2013 at 01:24:49PM +0200, Patel, Satish wrote:

[ big snip ]

> We have two options over here
> 
> Option 1: 
> 
> Defining generic api to which can be mapped over multiple phys
> For smartcard case, I have can thought of following mapping with new 
> generic apis as suggested.
> 
> Smartcard_poweron -> power_on
> Smartcard_powerdown -> power_off
> Smartcard_set_voltage -> phy_set_voltage

these three are generic enough

> Smartcard_activate_card -> phy_activate_slot
> Smartcard_deactivate_card -> phy_deactivate_slot

this looks unnecessary, why can't you always activate the card when you
phy_poweron ?

> Smartcard_set_c4/c8/rst/io -> phy_set_pin

why do you want to control each pin separately ? looks like something we
don't want to allow, in order to prevent users fiddling with the HW
directly.

> Smartcard_warm_reset -> phy_warmreset

phy_reset()

> Smartcard_set_clkdiv -> phy_set_clock
> Smartcard_get_clkdiv -> phy_get_clock

why do you need to control the clock like that ? That should be
something in the clock framework and, hey, it already exists:

clk_set_rate()
clk_get_rate()

> Smartcard_set_atr_mute_timeout -> ??
> Smartcard_set_atr_early_timeout -> ??	
> Smartcard_get_isr_status -> phy_get_status
> Smartcard_get_version -> phy_get_version

these look unnecessary. Why does any other entity need to know about the
PHY version and Interrupt status ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130708/f80e2ded/attachment.sig>

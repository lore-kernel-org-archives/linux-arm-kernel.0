From: balbi@ti.com (Felipe Balbi)
Date: Tue, 9 Jul 2013 14:44:16 +0300
Subject: [PATCH v9 0/8] Generic PHY Framework
In-Reply-To: <780E789C2E067A4BB8F69D0BB9EC4F253E976575@DBDE04.ent.ti.com>
References: <1372247257-30186-1-git-send-email-kishon@ti.com>
 <780E789C2E067A4BB8F69D0BB9EC4F253E975B5E@DBDE04.ent.ti.com>
 <51D3F773.9000209@ti.com> <20130703132038.GI15056@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E975D6E@DBDE04.ent.ti.com>
 <51D54694.20203@ti.com> <20130704101216.GD4830@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E9764D5@DBDE04.ent.ti.com>
 <51DAADD1.3060302@ti.com>
 <780E789C2E067A4BB8F69D0BB9EC4F253E976575@DBDE04.ent.ti.com>
Message-ID: <20130709114416.GL5552@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 09, 2013 at 04:23:29AM +0200, Patel, Satish wrote:
> > > We have two options over here
> > >
> > > Option 1:
> > >
> > > Defining generic api to which can be mapped over multiple phys
> > > For smartcard case, I have can thought of following mapping with new
> > > generic apis as suggested.
> > >
> > > Smartcard_poweron -> power_on
> > > Smartcard_powerdown -> power_off
> > > Smartcard_set_voltage -> phy_set_voltage
> > > Smartcard_activate_card -> phy_activate_slot
> > > Smartcard_deactivate_card -> phy_deactivate_slot
> > 
> > how is activate/deactivate different from poweron/poweroff in this
> > use case?
> 
> power on/off normal power sequence. While activate/de-activate will be 
> called during card transaction.

why can't you implement activate/deactivate with suspend/resume ?

> Brief on how it works:
> - when system start, execute power on for phy
> - smartcard controller and phy is connected through i2c, clock lines and 
> i/o lines
> - clock will be supplied by controller to phy to get data sync on i/o lines

fair enough.

> Operation:
>
> Once the card gets inserted into the slot, user application can
> initiate activate sequence anytime, it is not mandatory that
> activation has to be called Immediately. It all depends whether other
> connections ( network, printer) are proper.  User application can do
> some checks and then dynamically activate the card

The card or the phy ? Who actually activates ? Is the activation
handling part of the PHY or part of the smartcard controller ?

> There are 2 sequence of activation - normal activation and warm reset.
> If first fails then warm reset should be executed, if card does not
> response to both then deactivation will be carried out

ret = phy_resume(phy);
if (ret == -EINVAL) { /* perhaps there's a better error code */
	ret = phy_reset(phy);
	if (ret)
		phy_suspend(phy);
}

????

> - For activation there are some timing parameters ( called ATR -
> Answer to reset timings) Has to be set to the phy

does that change in runtime or is it something which is set during probe
and never touched again ?

> - on activation card will respond with some initial characters (ATR),
> which will be verified by application, in case of error user
> application will de-activate the card not the phy module
> 
> - After activation, use application initiate normal tx/rx
> 
> - Once tx/rx is done, it will initiate deactivation of card not the
> phy module.

then that has nothing to do with the PHY framework, right ?

> > > Smartcard_set_c4/c8/rst/io -> phy_set_pin
> > 
> > Whats should be exactly done here? Looks to me like it should be
> > part of init. Does these pin settings need to be changed dynamically?
> 
> These are all phy pins which will be physically come in contact with
> smart card When inserted. In case of synchronous card, these pins will
> be toggled manually by s/w bit bang algorithm

is that a requirement or just something that everybody does ?

In any case, you can hide that under some gpio calls, or something
similar.

> > Why? Is it like the detection of an external event? Then the PHY
> > driver should use *extcon* for event detection and passing.
> >
> 
> Smartcard controller need a way to ready isr status ( like card presence,
> Card inserted in to which slot, removed from which slot ) to maintain its
> Internal state machine.

register an interrupt handler with devm_request_threaded_irq(), what's
the problem ?

> > > Smartcard_get_version -> phy_get_version
> > 
> > Again why? Why would the smartcard need the version of the PHY?
> > 
> 
> Can be omitted. This is for the test suite reference.

if it's for testsuite, it sounds like something that should be done
through userland and, as such, should be implemented by a set of debugfs
files which expose the necessary information. That has nothing to do
with the PHY framework.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/b8472db6/attachment-0001.sig>

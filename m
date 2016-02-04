From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 04 Feb 2016 17:55:22 +0100
Subject: [PATCH v3 3/3] reset: Add support for shared reset controls
In-Reply-To: <56ADCFEF.3040707@redhat.com>
References: <1453918516-3078-1-git-send-email-hdegoede@redhat.com>
 <1453918516-3078-4-git-send-email-hdegoede@redhat.com>
 <20160130113837.GA25528@pengutronix.de> <56ADCFEF.3040707@redhat.com>
Message-ID: <1454604922.3356.80.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

Am Sonntag, den 31.01.2016, 10:12 +0100 schrieb Hans de Goede:
> Hi,
> 
> On 01/30/2016 12:38 PM, Philipp Zabel wrote:
> > Hi Hans,
> >
> > On Wed, Jan 27, 2016 at 07:15:16PM +0100, Hans de Goede wrote:
> >> In some SoCs some hw-blocks share a reset control. Add support for this
> >> setup by adding new:
> >>
> >> reset_control_get_shared()
> >> devm_reset_control_get_shared()
> >> devm_reset_control_get_shared_by_index()
> >>
> >> methods to get a reset_control. Note that this patch omits adding of_
> >> variants, if these are needed later they can be easily added.
> >>
> >> This patch also changes the behavior of the existing exclusive
> >> reset_control_get() variants, if these are now called more then once
> >> for the same reset_control they will return -EBUSY. To catch existing
> >> drivers triggering this error (there should not be any) a WARN_ON(1)
> >> is added in this path.
> >
> > Which is a good thing.
> >
> >> When a reset_control is shared, the behavior of reset_control_assert /
> >> deassert is changed, for shared reset_controls these will work like the
> >> clock-enable/disable and regulator-on/off functions. They will keep a
> >> deassert_count, and only (re-)assert the reset after reset_control_assert
> >> has been called as many times as reset_control_deassert was called.
> >>
> >> Calling reset_control_assert without first calling reset_control_deassert
> >> is not allowed on a shared reset control. Calling reset_control_reset is
> >> also not allowed on a shared reset control.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> > All three patches look very nice. I'll give them a test-drive next week.
> > So far I have one small issue, and I like Stephens suggestion of
> > elaborating on how shared resets are to be used a bit more.
> 
> I can do that, where would you like me to put this, a doxygen style comment
> in include/linux/reset.h ?

Sorry for the delay. I had just thought of extending the
reset_control_get_shared comment below, but an overview comment in
reset.h would be fine, too.

[...]
> >>   /**
> >> - * of_reset_control_get - Lookup and obtain a reference to a reset controller.
> >> + * reset_control_get_shared - Lookup and obtain a shared reference to a
> >> + *                            reset controller.
> >> + * @dev: device to be reset by the controller
> >> + * @id: reset line name
> >> + *
> >> + * Returns a struct reset_control or IS_ERR() condition containing errno.
> >
> > How about addressing Stephen's suggestion by extending this kerneldoc comment a
> > bit?

^^^ this.

Now that I think of it, the reset_control_assert function comment should
explicitly state that for shared resets the drivers can't expect their
registers and internal state to be reset, but must be prepared for this
to happen.

best regards
Philipp

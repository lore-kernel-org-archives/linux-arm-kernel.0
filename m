From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 14 Sep 2016 10:37:16 +0200
Subject: [PATCH 4/7] phy: meson: add USB2 PHY support for Meson8b and GXBB
In-Reply-To: <CAFBinCC+izGS72TZuiiBu=DjtSmoZXRZ6r76M6rC8W7UTpSD6g@mail.gmail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160904213152.25837-5-martin.blumenstingl@googlemail.com>
 <m260q6jibf.fsf@baylibre.com>
 <CAFBinCA4Yvw5pbOFmJ8SqyOASADavyEPmHywSdOiUazcqe_Zmg@mail.gmail.com>
 <e3b1f611-d6f6-c98b-a53b-98e94ef5bd96@codethink.co.uk>
 <m2eg4ui0nl.fsf@baylibre.com>
 <ffdd0188-72bc-4575-f997-e8547f4c31d2@codethink.co.uk>
 <CAFBinCC4gkMrJtertYevg_hXDLJEZ0PqfKKLL5UKXo8B=SXsPw@mail.gmail.com>
 <m2sht9gkau.fsf@baylibre.com>
 <CAFBinCDohOoFP_3GC+=tt6S7sPS308ao-yf+oGhdfwo-N-JnAA@mail.gmail.com>
 <1473780508.10237.22.camel@pengutronix.de>
 <CAFBinCC+izGS72TZuiiBu=DjtSmoZXRZ6r76M6rC8W7UTpSD6g@mail.gmail.com>
Message-ID: <1473842236.6816.0.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 13.09.2016, 20:38 +0200 schrieb Martin Blumenstingl:
> Hi Philipp,
> 
> On Tue, Sep 13, 2016 at 5:28 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Hi Martin,
> >
> > Am Freitag, den 09.09.2016, 22:36 +0200 schrieb Martin Blumenstingl:
> >> On Fri, Sep 9, 2016 at 5:33 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> >> > Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
> >> >
> >> >> On Thu, Sep 8, 2016 at 10:53 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >> >>> On 08/09/16 21:42, Kevin Hilman wrote:
> >> >>>>
> >> >>>> Ben Dooks <ben.dooks@codethink.co.uk> writes:
> >> >>>>
> >> >>>>> On 08/09/16 20:52, Martin Blumenstingl wrote:
> >> >>>>>>
> >> >>>>>> On Thu, Sep 8, 2016 at 9:35 PM, Kevin Hilman <khilman@baylibre.com>
> >> >>>>>> wrote:
> >> >>>>>>>>
> >> >>>>>>>> +     phy = devm_phy_create(&pdev->dev, NULL, &phy_meson_usb2_ops);
> >> >>>>>>>> +     if (IS_ERR(phy)) {
> >> >>>>>>>> +             dev_err(&pdev->dev, "failed to create PHY\n");
> >> >>>>>>>> +             return PTR_ERR(phy);
> >> >>>>>>>> +     }
> >> >>>>>>>> +
> >> >>>>>>>> +     if (usb_reset_refcnt++ == 0) {
> >> >>>>>>>> +             ret = device_reset(&pdev->dev);
> >> >>>>>>>> +             if (ret) {
> >> >>>>>>>> +                     dev_err(&phy->dev, "Failed to reset USB PHY\n");
> >> >>>>>>>> +                     return ret;
> >> >>>>>>>> +             }
> >> >>>>>>>> +     }
> >> >>>>>>>
> >> >>>>>>>
> >> >>>>>>> The ref count + reset here looks like something that could/should be
> >> >>>>>>> handled in a runtime PM callback.
> >> >>>>>>
> >> >>>>>> Unfortunately that doesn't work (as Jerome found out) because both
> >> >>>>>> PHYs are sharing the same reset line.
> >> >>>>>> So if the second PHY would call device_reset then it would also reset
> >> >>>>>> the first PHY!
> >> >>>>>>
> >> >>>>>> There's a comment above the declaration of usb_reset_refcnt which
> >> >>>>>> tries to explain this:
> >> >>>>>> "The PHYs are sharing a common reset line -> we are only allowed to
> >> >>>>>> reset once for all PHYs."
> >> >>>>>> Maybe I should move this comment to the "if (usb_reset_refcnt++ == 0)
> >> >>>>>> {" line to make it easier to see?
> >> >>>>>>
> >> >>>>>
> >> >>>>> pm-runtime has refcounting in it. When one of the nodes turns on,
> >> >>>>> the pm-runtime will call your driver to say there is a user when
> >> >>>>> this first use turns up.
> >> >>>>>
> >> >>>>> If all the sub-phys turn off and drop their refcount then the driver
> >> >>>>> is called to say there are no more users and you can go to sleep.
> >> >>>>
> >> >>>>
> >> >>>> After a chat w/Martin on IRC, It turns out runtime PM wont help here.
> >> >>>>
> >> >>>> The reason is because there are physically two PHY devices[1].  Those 2
> >> >>>> devices will be treated independely by runtime PM, and have separate
> >> >>>> use-counting, which means doing what I proposed would cause a reset to
> >> >>>> happen when either device was probed.
> >> >>>>
> >> >>>> So, I think it's OK as it is.
> >> >>>
> >> >>>
> >> >>> Surely you can do pm_runtime_get/put on the phy's parent platform
> >> >>> device and do it that way?
> >> >> could you please be more specific with that (do you mean pdev->dev.parent)?
> >> >> so we would use pm_runtime_{get_sync,put} with the parent, while we
> >> >> would still define the runtime_resume in our driver.
> >> >
> >> > You'd also need to do get/put on the children, but yes, that's what Ben
> >> > is suggesting.
> >> >
> >> > However, the problem with all of the solutions proposed (runtime PM ones
> >> > included) is that we're forcing a board-specific design issue (2 devices
> >> > sharing a reset line) into a driver that should not have any
> >> > board-specific assumptions in it.
> >> >
> >> > For example, if this driver is used on another platform where different
> >> > PHYs have different reset lines, then one of them (the unlucky one who
> >> > is not probed first) will never get reset.  So any form of per-device
> >> > ref-counting is not a portable solution.
> >> indeed, so in simple words we would need something like
> >> reset_control_do_once(rstc, RESET/ASSERT/DEASSERT) which would
> >> remember internally if any action has already been executed: if not it
> >> does a _reset, _assert or _deassert and otherwise it does nothing.
> >>
> >> > I'm not sure yet how the reset framework is supposed to handle shared
> >> > reset lines, but that needs some investigation.  I quick glance and it
> >> > seems that reset controllers can have shared lines, so that should be
> >> > investigated.
> >> I added Philipp and Hans to this thread - maybe they can comment on this.
> >> To sum it up, our problem is:
> >> - there are two separate USB PHYs on Meson GXBB
> >> - both are sharing the same reset line (provided by the reset-meson driver)
> >> - during initialization of the PHYs we must only call
> >> reset_control_reset(rstc) once (if we do it for the first *and* second
> >> PHY then the first PHY gets confused once the second PHY uses the
> >> reset because the first PHY's state is reset as well)
> >
> > If you have an initially asserted reset line and you can enable the
> > first module by deasserting the reset via reset_control_deassert (and
> > reset_control_assert to signal when the module may be disabled again
> > after use), shared resets are for you.
> >
> > If you need a reset pulse or have no direct control over the reset line,
> > (device_reset), the reset framework currently has no solution for this.
> > The ugly thing about reset_control_once would be that it can't re-reset
> > modules when unloading and reloading driver modules.
> The corresponding reset driver in question is reset-meson, which only
> implements reset (assert/deassert are not implemented). However, I
> don't know if this is due to hardware design.
> I think the hardware implements the latter, but maybe Neil can give
> more information here (I currently don't have access to my board so I
> cannot test how the hardware actually behaves).
> 
> > A real solution for shared reset lines with reset pulses would have to
> > be some kind of reset request framework where if one module requests a
> > reset, the other module sharing the reset could be notified, and then
> > either veto the reset or, if possible, cease operations, store its
> > state, and prepare to be reset, too, and afterwards restore state. I'd
> > prefer not to think about this too much unless absolutely necessary.
> I'm not sure if this would work in our case: one PHY instance would
> have to know if the other has already triggered the reset or not.

We could add a triggered flag or a counter to struct reset_control, and
have reset_control_reset_once do nothing if it is already set /
incremented. Since the reset_control goes away with the last consumer,
the shared reset line would get triggered again after unbinding both PHY
devices.

regards
Philipp

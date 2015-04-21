From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 21 Apr 2015 11:34:00 +0100
Subject: [PATCH 1/3] ARM: ux500: Move GPIO regulator for SD-card into
 board DTSs
In-Reply-To: <CAPDyKFrdEHMA-AtdTr9kwx+UXihZf4TirWS0Bq+W5wa66T+vtg@mail.gmail.com>
References: <1429538553-17366-1-git-send-email-ulf.hansson@linaro.org>
 <1429538553-17366-2-git-send-email-ulf.hansson@linaro.org>
 <20150420182634.GH3447@x1>
 <CAPDyKFrDOGBkfg48mmsbktCWFTaNV4WnTm_Fui=Kp30u1yH-tQ@mail.gmail.com>
 <20150421073336.GJ3447@x1>
 <CAPDyKFrdEHMA-AtdTr9kwx+UXihZf4TirWS0Bq+W5wa66T+vtg@mail.gmail.com>
Message-ID: <20150421103400.GW3447@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Apr 2015, Ulf Hansson wrote:

> On 21 April 2015 at 09:33, Lee Jones <lee@kernel.org> wrote:
> > On Tue, 21 Apr 2015, Ulf Hansson wrote:
> >
> >> On 20 April 2015 at 20:26, Lee Jones <lee@kernel.org> wrote:
> >> > On Mon, 20 Apr 2015, Ulf Hansson wrote:
> >> >
> >> >> The GPIO regulator for the SD-card isn't a ux500 SOC configuration, but
> >> >> instead it's specific to the board. Move the definition of it, into the
> >> >> board DTSs.
> >> >
> >> > What makes you think that?
> >>
> >> Because of how it was structured today.
> >>
> >> ste-dbx5x0.dtsi - common for all ux500 boards, thus I considered this
> >> as the SoC configuration.
> >
> > ste-dbx5x0.dtsi is common for all ux500 and ux540 boards.
> >
> >> Then below are board configs which uses the above dtsi:
> >> ste-href.dtsi - common for href boards (used by ste-hrefprev60.dtsi
> >> and ste-hrefv60plus.dtsi), have vmmci
> >> ste-snowball.dts, have vmmci
> >> ste-ccu8540.dts, don't have vmmci
> >> ste-ccu9540.dts, don't have vmmci
> >
> > Ah, got you.  In which case it doesn't belong in ste-dbx5x0.dtsi.
> >
> >> > We normally place the common pieces (of which there are many in this
> >> > node) in the highest level DTSI file, then add the platform specific
> >> > ones in the DTS files.
> >>
> >> Okay, so maybe it's due to the naming of ste-dbx5x0.dtsi, that I
> >> thought this was intended to cover the SoC configuration and not any
> >> of the platform specific stuff.
> >
> > ste-dbx5x0.dtsi should cover all pieces which are common to all ux500
> > and ux540 devices.  Then the lower level file ste-href-ab8500.dtsi
> > should cover all pieces which are common to ux500 devices and finally
> > the DTS files should add board specific information.  Duplicate
> > nodes and properties are frowned upon.
> >
> >> So what your advise of doing this?
> >
> > So the file which covers the x500 boards is ste-href-ab8500.dtsi.  I
> > would move the node into there instead.  Keep it disabled and enable
> > the associated nodes in the 2 DTS files.
> 
> Why ste-href-ab8500.dtsi? Isn't that suppose to cover configurations
> common to the ab8500 subsystem?

Only because up until now that has been what is a) different from the
abx5{40,05} platforms and b) common on abx500 ones.

However, the point of the DTS(I) hierarchy is to prevent duplication.
Lower level DTSI files contain nodes which are similar to a sub-set of
platforms, whereas the highest level DTSI files contain nodes which
are shared between all associated platforms.

> The vmmci models a board specific mounted circuit (aka level-shifter).
> Thus it exist on some boards but not on others.

Many of the peripherals we use on the boards are 'off-chip'.  That
does not preclude them from DTSI files if they are shared among
various platforms.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

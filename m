From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 1 Nov 2018 17:49:12 +0800
Subject: [RFC PATCH 7/7] arm64: allwinner: h6: orangepi-liet2: Enable
 AP6356S WiFi support
In-Reply-To: <CAMty3ZBNdg43nL-HviyHufwQtTbC4wv20JVYBBT8LDpWiV0wTQ@mail.gmail.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-7-jagan@amarulasolutions.com>
 <CAMty3ZCeZzXYy4XRwTeQjYfpB6KKjEVRWyhjoca9Os4foLYL4g@mail.gmail.com>
 <CAGb2v67xCnH20Hga2P2Ekk3vhhOWUSgtOmRVAte+HDuodjsjkw@mail.gmail.com>
 <CAMty3ZBNdg43nL-HviyHufwQtTbC4wv20JVYBBT8LDpWiV0wTQ@mail.gmail.com>
Message-ID: <CAGb2v66MohJC9fBYhwJgaf+HP_AZb-c5B9CZr1GaAABc+Qj0vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 5:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Nov 1, 2018 at 1:28 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Thu, Nov 1, 2018 at 3:35 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > On Thu, Nov 1, 2018 at 12:07 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > From: Jagan Teki <jagan@openedev.com>
> > > >
> > > > Enable AP6356S WiFi/BT combo chip on Orangepi Lite2 board:
> > > > - WiFi SDIO interface is connected to MMC1
> > > > - WiFi WL-PMU-EN pin connected to gpio PM3: attach to mmc-pwrseq
> > > > - WiFi WL-WAKE-AP pin connected to gpio PM0
> > > > - 32kHz external oscillator gate clock from RTC
> >
> > You never specified a clock rate for it, so it might actually be wrong.
> > The default clock rate would be something "around" 32 kHz, but not very
> > accurate. Meanwhile the WiFi module would have very specific requirements
> > on frequency and accuracy of this clock. The WiFi part doesn't seem to
> > care that much, but the Bluetooth part cares very much. It doesn't work
> > or it would seem to work but you don't get anything off the radio if the
> > frequency is off (as in off-frequency).
>
> True, but why it's not 32K which is stated in manual and schematics do
> we need to measure the actual rate with oscilloscope?

I suppose it's just shorthand. The datasheet describes the actual requirements
for both oscillators, where it clearly states the 32K one should be 32768 Hz.
A scope shouldn't be needed as we expect the board design to at least conform
to constraints outlined in datasheets.

On the side, the LOSC be _around_ 32kHz if you clocked it from the internal
RC oscillator, which is not very stable. This is actually the hardware default.
But the WiFi module (and also the RTC) needs 32.768K, a slight difference,
but enough to throw off calculations for other clocks. When the RTC module
isn't clocked from the external crystal, the RTC clock will drift. This has
been reported and is why we have

    /* Switch to the external, more precise, oscillator */
    writel(SUN6I_LOSC_CTRL_KEY | SUN6I_LOSC_CTRL_EXT_OSC,
           rtc->base + SUN6I_LOSC_CTRL);

in the RTC driver's clock probe function. See these two patches:

    fb61bb82cb46 rtc: sun6i: Switch to the external oscillator
    3855c2c3e546 rtc: sun6i: Expose the 32kHz oscillator

Note the commit message for the second patch is incorrect. We actually force
the RTC module to use the external crystal regardless of the "clocks" property.

I actually forgot about this. So even without assigning clock rates your patch
would work fine. Hope this doesn't confuse you more than it already has.

ChenYu

> > > > Signed-off-by: Jagan Teki <jagan@openedev.com>
> > > > ---
> > > > Note:
> > > > - chip detected, but failed to connect
> > > > [  129.084504] brcmfmac: brcmf_sdio_hostmail: mailbox indicates firmware halted
> > > > [  135.906409] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
> > >
> > > This got fixed. Will send next version.
> >
> > Could you wait until I get my RTC changes out? I also have some Bluetooth
> > patches for AP621x, which is what started all this RTC work, which you might
> > find interesting.
>
> Yes, my intention is the same.

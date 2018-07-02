From: mka@chromium.org (Matthias Kaehlcke)
Date: Mon, 2 Jul 2018 15:35:00 -0700
Subject: [PATCH v2 2/2] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
In-Reply-To: <20180702204611.GZ129942@google.com>
References: <20180702181005.18247-1-mka@chromium.org>
 <20180702181005.18247-2-mka@chromium.org>
 <CAD=FV=WH8q-3Rt89Get0N357+hWmKiEsruaKtWzo_JoE6gd_3g@mail.gmail.com>
 <20180702204611.GZ129942@google.com>
Message-ID: <20180702223500.GB129942@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 01:46:11PM -0700, Matthias Kaehlcke wrote:
> On Mon, Jul 02, 2018 at 12:53:44PM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Mon, Jul 2, 2018 at 11:10 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > > The thermal zone uses spmi-temp-alarm as sensor. If the sensor is
> > > configured without an IIO input it always reports 37?C for temperatures
> > > below the first hardware trip point at 105?C. This hardware trip point
> > > is configured as critical trip point, to initiate a system shutdown
> > > before the temperature reaches the next hardware trip point at 125?C,
> > > where the PMIC performs a partial shutdown.
> > >
> > > The temperature of the critical trip point can be raised after adding
> > > the die temperature ADC as IIO input for spmi-temp-alarm, which
> > > significantly increases the precision of the temperature measurements.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Changes in v2:
> > > - defined 'thermal-zones' node in pm8998.dtsi instead of using a label
> > >   to refer to it
> > > - use 105?C hardware trip point as critical trip point
> > 
> > I'm not sure this was right.  I guess you're trying to avoid
> > Temperature Stage 2?
> 
> Indeed
> 
> > From Davi'd email in response to v1:
> > 
> > > The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
> > > PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
> > > off peripherals within the PMIC that are expected to draw significant
> > > current.  The set of peripherals included varies between PMICs.  This
> > > partial shutdown will occur simultaneously with the triggering of an
> > > interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
> > > driver that an over-temperature threshold has been crossed.
> > 
> > I think it's actually OK to use Temperature Stage 2 as the "critical"
> > point, which is why it still interrupts the CPU.  At "critical" the
> > system will shut down, right?  ...so presumably it's OK if the drivers
> > can't recover from having the power yanked out from underneath them as
> > long as they don't hang/crash the system in this case.  If I had to
> > guess the whole point of this stage is to give the system shutdown a
> > better chance of succeeding without getting to stage 3.
> 
> That was my starting point, however in my tests the system reset
> several times when the temperature got close to 125?C, not allowing
> for a proper shutdown. Apparently the partial shutdown of the PMIC can
> result in a full reset at least on some systems.

For the record: Linux does a proper shutdown when software override
for stage 2 is enabled (bit OVRD_ST2_EN in TEMP_ALARM_SHUTDOWN_CTL1).

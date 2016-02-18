From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 13:43:01 +0100
Subject: [PATCH 2/2] ARM: dts: meson: Adding hwrev syscon node
In-Reply-To: <CABgxDo+oGe47hvxiCOAUWz8zfSeVONf=3pFm+=PbNsCbr_jTpg@mail.gmail.com>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
 <CAOQ7t2add21t4hFtTeUBFe9aW0EtNvSi5KS4JMb6qVC60Fj-tA@mail.gmail.com>
 <CABgxDo+oGe47hvxiCOAUWz8zfSeVONf=3pFm+=PbNsCbr_jTpg@mail.gmail.com>
Message-ID: <4158343.mkrTsd5B4G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 February 2016 13:33:04 Romain Perier wrote:
> 2016-02-17 21:36 GMT+01:00 Carlo Caione <carlo@caione.org>:
> > On Wed, Feb 17, 2016 at 6:28 PM, Romain Perier <romain.perier@gmail.com> wrote:
> >> These are the CBUS registers used to retrieve the revision and the
> >> identifier of the SoC on Meson8.
> >>
> >> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> >> ---
> >>  arch/arm/boot/dts/meson8b.dtsi | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> >> index 0477a81..71009dc 100644
> >> --- a/arch/arm/boot/dts/meson8b.dtsi
> >> +++ b/arch/arm/boot/dts/meson8b.dtsi
> >> @@ -99,6 +99,11 @@
> >>                 };
> >>         };
> >>
> >> +       hwrev at c1107d4c {
> >> +               compatible = "amlogic,meson8b-hwrev", "syscon";
> >> +               reg = <0xc1107d4c 0x460>;
> >
> > Interesting. Where did you get 0x460?
> 
> Carlo, Arnd.
> 
> Well, what I did is the following :
> - CBUS_PHY_BASE is 0xc1100000   (CBUS is a larger block of registers,
> like slcr on zynq)
> - the serial is at CBUS_PHY_BASE + 0x7d4c
> - the revision is at CBUS_PHY_BASE + 0x81a8
> 
> So I decided to create a device_node for hw revision at 0xc1107d4c, in
> this case the lenght is 0x460...
> Am I wrong ?

Yes, you should describe the device that is actually there, which would be
something like

	cbus at c1100000 {
		compatible = "amlogic,meson8b-cbus", "syscon";
		reg = <0xc1100000 0x10000>; /* no idea what the length is, fix it */
	};

Don't just make things up because you happen to access them in a particular
way, but try to stay as close as you can to describing the actual hardware.

Please also check that the register ranges don't overlap with something
that might already be there, in case someone else made the same mistake.

	Arnd

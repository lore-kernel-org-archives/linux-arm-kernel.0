From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 3 Jun 2011 00:21:50 +0800
Subject: [RFC 1/2] ARM:Tegra: Device Tree Support: Initialize the audio
	card from the device tree.
In-Reply-To: <20110602160445.GA8373@ponder.secretlab.ca>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205706.21000.34832.stgit@riker>
	<BANLkTi=NMjBjWVv_o3PocejhgGr8TdG+1Q@mail.gmail.com>
	<BANLkTi=PtEhxxmZo2DqvmySCmnEd3LbezQ@mail.gmail.com>
	<BANLkTikWpiY_o27OF-Jxvq7iPeWzrAYOsQ@mail.gmail.com>
	<20110602160445.GA8373@ponder.secretlab.ca>
Message-ID: <BANLkTikGp_O-Wd3nMhbV+-RLeXZoWeB6eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/3 Grant Likely <grant.likely@secretlab.ca>
>
> On Thu, Jun 02, 2011 at 05:07:02PM +0800, Barry Song wrote:
> > 2011/6/2 Grant Likely <grant.likely@secretlab.ca>:
> > > On Wed, Jun 1, 2011 at 1:07 AM, Barry Song <21cnbao@gmail.com> wrote:
> > >> 2011/5/28 John Bonesio <bones@secretlab.ca>:
> > >>> This patch makes it so the top level audio card is initialized from the device
> > >>> tree. This is just the first step getting the audio complex of devices
> > >>> iniialized from device tree nodes.
> > >>>
> > >>> Signed-off-by: John Bonesio<bones@secretlab.ca>
> > >>> ---
> > >>>
> > >>> ?arch/arm/boot/dts/tegra-harmony.dts | ? ?4 +++
> > >>> ?arch/arm/mach-tegra/board-dt.c ? ? ?| ? ?3 ++
> > >>> ?sound/soc/tegra/harmony.c ? ? ? ? ? | ? 45 ++++++++++++++++++++++++++++++++---
> > >>> ?3 files changed, 48 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
> > >>> index 05521a5..217a7f0 100644
> > >>> --- a/arch/arm/boot/dts/tegra-harmony.dts
> > >>> +++ b/arch/arm/boot/dts/tegra-harmony.dts
> > >>> @@ -53,6 +53,10 @@
> > >>> ? ? ? ? ? ? ? ?clock-frequency = <400000>;
> > >>> ? ? ? ?};
> > >>>
> > >>> + ? ? ? harmony_audio: audio_card {
> > >>> + ? ? ? ? ? ? ? compatible = "nvidia,harmony-audio";
> > >>> + ? ? ? };
> > >>> +
> > >>> ? ? ? ?serial at 70006300 {
> > >>> ? ? ? ? ? ? ? ?status = "ok";
> > >>> ? ? ? ? ? ? ? ?clock-frequency = < 216000000 >;
> > >>> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
> > >>> index c498e84..a569ad9 100644
> > >>> --- a/arch/arm/mach-tegra/board-dt.c
> > >>> +++ b/arch/arm/mach-tegra/board-dt.c
> > >>> @@ -56,6 +56,9 @@ static struct platform_device *tegra250_devices[] __initdata = {
> > >>> ? ? ? ?&tegra_i2c_device2,
> > >>> ? ? ? ?&tegra_i2c_device3,
> > >>> ? ? ? ?&tegra_i2c_device4,
> > >>> + ? ? ? &tegra_i2s_device1,
> > >>> + ? ? ? &tegra_das_device,
> > >>> + ? ? ? &tegra_pcm_device,
> > >>
> > >> i am thinking whether platform_device should be created by
> > >> of_platform_device_create after scanning device tree, but not by
> > >> hard-code? looks like the two patches are only trying to let device
> > >> tree deliver gpio to drivers?
> > >
> > > Can you please restate your question? ?I don't think I understand what
> > > you are trying to ask.
> >
> > i mean we don't need to have this platform device registerred by the
> > old way here. we may get it by matching information in dts and delete
> > all platform_device and related codes in arch/arm. For example:
>
> Ah, I see what you mean. ?Yes, it is ultimately the goal to register
> all the device from data in the device tree, but we're taking things
> one step at a time. ?For this series, it is expedient to register the
> on-chip devices, and to move to dynamic registration later.
>
> Right now we can't do dynamic registration for on-chip devices in a
> lot of cases because we don't have the infrastructure to hook up the
> associated struct clks.
Arnd has required me to use device tree in our new SoC for the coming
upstream. so i am trying to define a property like clock = "uart" in
dts. then in drivers,
i get this  string by:
clk = of_get_property(np, "clock", NULL);
then request this clock by clk_get().

it does work for the moment, but maybe is not what you like :-)

>
> g.
>
>

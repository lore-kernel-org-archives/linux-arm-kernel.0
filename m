From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 15 May 2018 23:47:16 -0700
Subject: [PATCH net-next v2 15/15] arm64: dts: allwinner: a64: add SRAM
 controller device tree node
In-Reply-To: <20180514080310.ngev5h6cqe4taedl@flea>
References: <20180501161227.2110-1-wens@csie.org>
 <20180501161227.2110-16-wens@csie.org>
 <20180502095118.rqnfwy576xh6ercm@flea>
 <CAGb2v67pvL58Pes1ZFDZtPu_nL2+m6dgf_XOOymG9nVAkXVpEw@mail.gmail.com>
 <29E5670C-9D17-4EC1-AAAC-0CF33DD0534C@aosc.io>
 <20180502115437.zlu2rafrguufutvp@flea>
 <CAGb2v64xTNqQQSppw2NZoLn+ViQNQLytn1EukLqw+HJzf1=5ig@mail.gmail.com>
 <20180514080310.ngev5h6cqe4taedl@flea>
Message-ID: <CAGb2v65uZeueE=2FfsxWen9zNvCtMsJ+b=KgMfSh-ZKmO+S=cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 1:03 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> 1;5201;0c
> On Sun, May 13, 2018 at 12:37:49PM -0700, Chen-Yu Tsai wrote:
>> On Wed, May 2, 2018 at 4:54 AM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>> > On Wed, May 02, 2018 at 06:19:51PM +0800, Icenowy Zheng wrote:
>> >>
>> >>
>> >> ? 2018?5?2? GMT+08:00 ??5:53:21, Chen-Yu Tsai <wens@csie.org> ??:
>> >> >On Wed, May 2, 2018 at 5:51 PM, Maxime Ripard
>> >> ><maxime.ripard@bootlin.com> wrote:
>> >> >> Hi,
>> >> >>
>> >> >> On Wed, May 02, 2018 at 12:12:27AM +0800, Chen-Yu Tsai wrote:
>> >> >>> From: Icenowy Zheng <icenowy@aosc.io>
>> >> >>>
>> >> >>> Allwinner A64 has a SRAM controller, and in the device tree
>> >> >currently
>> >> >>> we have a syscon node to enable EMAC driver to access the EMAC clock
>> >> >>> register. As SRAM controller driver can now export regmap for this
>> >> >>> register, replace the syscon node to the SRAM controller device
>> >> >node,
>> >> >>> and let EMAC driver to acquire its EMAC clock regmap.
>> >> >>>
>> >> >>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> >> >>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> >> >>> ---
>> >> >>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23
>> >> >+++++++++++++++----
>> >> >>>  1 file changed, 19 insertions(+), 4 deletions(-)
>> >> >>>
>> >> >>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> >> >b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> >> >>> index 1b2ef28c42bd..1c37659d9d41 100644
>> >> >>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> >> >>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> >> >>> @@ -168,10 +168,25 @@
>> >> >>>               #size-cells = <1>;
>> >> >>>               ranges;
>> >> >>>
>> >> >>> -             syscon: syscon at 1c00000 {
>> >> >>> -                     compatible =
>> >> >"allwinner,sun50i-a64-system-controller",
>> >> >>> -                             "syscon";
>> >> >>> +             sram_controller: sram-controller at 1c00000 {
>> >> >>> +                     compatible =
>> >> >"allwinner,sun50i-a64-sram-controller";
>> >> >>
>> >> >> I don't think there's anything preventing us from keeping the
>> >> >> -system-controller compatible. It's what was in the DT before, and
>> >> >> it's how it's called in the datasheet.
>> >> >
>> >> >I actually meant to ask you about this. The -system-controller
>> >> >compatible matches the datasheet better. Maybe we should just
>> >> >switch to that one?
>> >>
>> >> No, if we do the switch the system-controller compatible,
>> >> the device will be probed on the same memory region with
>> >> a syscon on old DTs.
>> >
>> > The device hasn't magically changed either. Maybe we just need to add
>> > a check to make sure we don't have the syscon compatible in the SRAM
>> > driver probe so that the double driver issue doesn't happen?
>>
>> The syscon interface (which is not even a full blown device driver)
>> only looks at the "syscon" compatible. Either way we're removing that
>> part from the device tree so things should be ok for new device trees.
>> As Maxime mentioned we can do a check for the syscon compatible and
>> either give a warning to the user asking them to update their device
>> tree, or not register our custom regmap, or not probe the SRAM driver.
>> Personally I prefer the first option. The system controller block is
>> probed before any syscon users, so we should be fine, given the dwmac
>> driver goes the custom regmap path first.
>>
>> BTW, I still might end up changing the compatible. The manual uses
>> "system control", not "system controller", which I think makes sense,
>> since it is just a bunch of register files, kind of like the GRF
>> (General Register Files) block found in Rockchip SoCs [1], and not an
>> actual "controller".
>
> I'm not really fond of that, but we should at least make it consistent
> on the other patches Paul sent then.

For the A10s / A13 right?

I think my naming is slightly better, but it's just a minor detail.
While we're still debating this, can I merge the R40 stuff first?
The driver bits are already in.

Thanks
ChenYu

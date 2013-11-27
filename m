From: hrhaan@gmail.com (Harro Haan)
Date: Wed, 27 Nov 2013 17:11:16 +0100
Subject: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
In-Reply-To: <20131126072557.GA6113@S2101-09.ap.freescale.net>
References: <0E83723C55F66F43A6041464FE31119D40FC99@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAJ+vNU13FA5s7tt-yEnBYNSBV+FHmHqZNoykFq8aF=O=TvqTnA@mail.gmail.com>
 <0E83723C55F66F43A6041464FE31119D40FD55@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAJ+vNU2ifxfprYsgcQs+Kkgu37+diXHJS6DEqs4d51+U3F4sLQ@mail.gmail.com>
 <52792C5E.6030008@writeme.com>
 <CAErSpo7c1KiOKqpM1+v6GM09Mspge=Yq9orwXVYjZZjsQssCHA@mail.gmail.com>
 <CAB5oZtAKmgeAYCgbVAUyjFF+=P4n728M3qD16-FG7mz_9WJooA@mail.gmail.com>
 <0E83723C55F66F43A6041464FE31119D45B7C1@039-SN2MPN1-011.039d.mgd.msft.net>
 <20131126043139.GH30476@S2101-09.ap.freescale.net>
 <0E83723C55F66F43A6041464FE31119D45B9CC@039-SN2MPN1-011.039d.mgd.msft.net>
 <20131126072557.GA6113@S2101-09.ap.freescale.net>
Message-ID: <CAB5oZtDD_KV+QJPUiCxU3on_x5pFd=rZOK0fzYb+meojCJisiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 November 2013 08:26, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Nov 26, 2013 at 06:04:16AM +0000, Richard Zhu wrote:
>> [Richard] Based on the tag " pci-v3.13-fixes-1" on pci git-repos, imx6 pcie had been tested on imx6 sabresd board.
>>
>> The pcie works after enable pcie support in imx6qdl-sabresd.dtsi file.
>
> Great, thanks, Richard.
>
> Shawn
>

Thanks Richard,

TC1: The following does NOT work with the mainline Linux tree on my
SabreSD with PCIe e1000e network card:
$ git reset --hard v3.13-rc1
$ git apply enable_pcie_on_imx6qdl_sabresd_board.patch # patch
supplied by Richard Zhu
result: "phy link never came up"

TC2: But the following does work with the mainline Linux tree:
$ git reset --hard d95d3d53c7ef85ec0dc87db63aece18212c337b0 # HEAD is
now at d95d3d5 Merge branch 'pci/host-imx6' into next (just a few
commits after v3.12-rc2)
$ git cherry-pick 1c4bfb9bd842f09318bc2fa37c1ee0d68bb4e8cb # [master
f283273] PCI: imx6: Remove redundant dev_err() in imx6_pcie_probe()
$ git cherry-pick 01ee0c70b5b935135dbe7fbf48115d9f16348474 # [master
5c93c84] PCI: imx6: Fix imprecise abort handler
$ git cherry-pick 5dcb7c402409f4b1ecb279d5e846bdb1dff9bbe0 # [master
c3cc5c5] PCI: imx6: Increase link startup timeout
$ git cherry-pick 832f3ca20743911508e0cc1909415080a3128532 # [master
b4a81be] PCI: imx6: Remove redundant of_match_ptr
$ git cherry-pick ca6457dc1fbcc1f5ed1f8311e7fcf7ff129cda55 # [master
45aa4ab] PCI: imx6: Probe the PCIe in fs_initcall()
$ git cherry-pick 212555bde33eeae0bec16d41bd4045fbebc0cfab # [master
4db342b] ARM: dts: imx6qdl: add pcie device node
$ git cherry-pick 64990a431469a58b2949aca5be9d69e220d53892 # [master
7c29353] ARM: imx6q: Add pll4_audio_div to clock tree
$ git cherry-pick bf22172158cd6dcc5be6dc286ff5c33794dd0ae8 # [master
5e5852f] ARM: imx: Add LVDS general-purpose clocks to i.MX6Q
$ git cherry-pick 74b8031307c5d33d36742c26dd0921991bd5a255 # [master
05ae48c] ARM: imx6q: clock and Kconfig update for PCIe support
$ git apply enable_pcie_on_imx6qdl_sabresd_board.patch # patch
supplied by Richard Zhu
result: lspci detects network card

I have also tested both test cases (TC1 + TC2) with the patches
supplied by Marek Vasut on 26-11-2013:
$ git apply 17_pci_imx6_make_reset-gpio_optional.patch
$ git apply 37_pci_imx6_fix_waiting_for_link_up.patch
$ git apply 47_pci_imx6_split_away_the_phy_reset.patch
$ git apply 57_pci_imx6_split_away_the_link_up_wait_loop.patch
$ git apply 67_pci_imx6_fix_link_start_operation.patch
same results:
TC1: "phy link never came up"
TC2: lspci detects network card

Best regards,

Harro

>>
>> Patch:
>> Author: Richard Zhu <r65037@freescale.com>
>> Date:   Tue Nov 26 13:29:24 2013 +0800
>>
>>     pcie: imx6: enable pcie on imx6qdl sabresd board
>>
>>     Add pcie device tree node into imx6qdl dts file,
>>     enable pcie on imx6qdl sabresd board
>>
>>     Signed-off-by: Richard Zhu <r65037@freescale.com>
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
>> index e75e11b..b821f87 100644
>> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
>> @@ -212,6 +212,12 @@
>>         };
>>  };
>>
>> +&pcie {
>> +       power-on-gpio = <&gpio3 19 0>;
>> +       reset-gpio = <&gpio7 12 0>;
>> +       status = "okay";
>> +};
>> +
>>  &pwm1 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&pinctrl_pwm0_1>;
>>
>> LOGs when e1000e nic is used:
>> uname -a
>> Linux freescale 3.12.0+ #49 SMP Tue Nov 26 13:26:03 CST 2013 armv7l GNU/Linux
>> root at freescale ~$ lspci -v
>> 00:00.0 PCI bridge: Unknown device 16c3:abcd (rev 01) (prog-if 00 [Normal decode])
>>         Flags: bus master, fast devsel, latency 0
>>         Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>         I/O behind bridge: 00001000-00001fff
>>         Memory behind bridge: 01100000-011fffff
>>         Prefetchable memory behind bridge: 01200000-012fffff
>>         [virtual] Expansion ROM at 01300000 [disabled] [size=64K]
>>         Capabilities: [40] Power Management version 3
>>         Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/0 Enable-
>>         Capabilities: [70] Express Root Port (Slot-) IRQ 0
>>         Capabilities: [100] Advanced Error Reporting
>>         Capabilities: [140] Virtual Channel
>>
>> 01:00.0 Ethernet controller: Intel Corporation Unknown device 10d3
>>         Subsystem: Intel Corporation Unknown device a01f
>>         Flags: bus master, fast devsel, latency 0, IRQ 155
>>         Memory at 01180000 (32-bit, non-prefetchable) [size=128K]
>>         Memory at 01100000 (32-bit, non-prefetchable) [size=512K]
>>         I/O ports at 1000 [disabled] [size=32]
>>         Memory at 011a0000 (32-bit, non-prefetchable) [size=16K]
>>         [virtual] Expansion ROM at 01200000 [disabled] [size=256K]
>>         Capabilities: [c8] Power Management version 2
>>         Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
>>         Capabilities: [e0] Express Endpoint IRQ 0
>>         Capabilities: [a0] MSI-X: Enable- Mask- TabSize=5
>>         Capabilities: [100] Advanced Error Reporting
>>         Capabilities: [140] Device Serial Number 8b-18-3a-ff-ff-21-1b-00
>> > >
>> <...>
>> >
>> > Best Regards
>> > Richard Zhu
>>
>> [Richard]
>> Best Regards
>> Richard Zhu
>>
>>
>

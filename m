From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Wed, 29 Nov 2017 21:21:46 +0300
Subject: [PATCH 2/2] arm64: dts: orange-pi-zero-plus2: enable AP6212a
 WiFi/BT combo
In-Reply-To: <CAMty3ZDkM7apyoJESQm0zU1t-pNFdj8ynrZJoTstvgs98Aw6ZQ@mail.gmail.com>
References: <20171103195855.15283-1-geomatsi@gmail.com>
 <20171103195855.15283-3-geomatsi@gmail.com>
 <CAMty3ZAiDvAG-P-c0J7vKaDyRWQ2CQobLA_xycRva5B20W6SOg@mail.gmail.com>
 <CAGb2v66mNeUL0Pk60aB2s98GK2WiSdhk2_QiZJuMz0Rt=NmEyg@mail.gmail.com>
 <CAMty3ZDkM7apyoJESQm0zU1t-pNFdj8ynrZJoTstvgs98Aw6ZQ@mail.gmail.com>
Message-ID: <20171129182146.ccw7wtppaiv6srpb@speedy.hunter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 11:39:35PM +0530, Jagan Teki wrote:
> On Wed, Nov 29, 2017 at 7:52 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> > On Wed, Nov 29, 2017 at 9:53 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> >> On Sat, Nov 4, 2017 at 1:28 AM, Sergey Matyukevich <geomatsi@gmail.com> wrote:
> >>> Enable AP6212a WiFi/BT combo chip on orange-pi-zero-plus2 board:
> >>> - WiFi SDIO interface is connected to MMC1
> >>> - WiFi REG_ON pin connected to gpio PA9: attach to mmc-pwrseq
> >>> - WiFi HOST_WAKE pin connected to gpio PL7
> >>> - BT is connected to UART1
> >>>
> >>> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> >>> ---
> >>>  .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    | 32 ++++++++++++++++++++++
> >>>  1 file changed, 32 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> >>> index a42fd79a62a3..d415b7b67cce 100644
> >>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> >>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> >>> @@ -64,6 +64,13 @@
> >>>                 regulator-min-microvolt = <3300000>;
> >>>                 regulator-max-microvolt = <3300000>;
> >>>         };
> >>> +
> >>> +       wifi_pwrseq: wifi_pwrseq {
> >>> +               compatible = "mmc-pwrseq-simple";
> >>> +               pinctrl-names = "default";
> >>> +               reset-gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
> >>> +               post-power-on-delay-ms = <200>;
> >>> +       };
> >>>  };
> >>>
> >>>  &mmc0 {
> >>> @@ -75,6 +82,25 @@
> >>>         status = "okay";
> >>>  };
> >>>
> >>> +&mmc1 {
> >>> +       pinctrl-names = "default";
> >>> +       pinctrl-0 = <&mmc1_pins_a>;
> >>> +       vmmc-supply = <&reg_vcc3v3>;
> >>> +       vqmmc-supply = <&reg_vcc3v3>;
> >>> +       mmc-pwrseq = <&wifi_pwrseq>;
> >>> +       bus-width = <4>;
> >>> +       non-removable;
> >>> +       status = "okay";
> >>> +
> >>> +       brcmf: wifi at 1 {
> >>> +               reg = <1>;
> >>> +               compatible = "brcm,bcm4329-fmac";
> >>> +               interrupt-parent = <&r_pio>;
> >>> +               interrupts = <0 7 IRQ_TYPE_LEVEL_LOW>;  /* PL7 */
> >>> +               interrupt-names = "host-wake";
> >>> +       };
> >>> +};
> >>
> >> Did you observe this issue, I'm using firmware from buildroot and
> >> couldn't find any *.txt from brcm/ I believe we need ass text file for
> >> firmware details, did you tried the same from BR?
> >
> > The text file is not provided as part of the linux-firmware repository.
> > You have to fetch it from your vendor BSP. This is documented not just
> > for sunxi, but also for the raspberry pi 3.
> 
> Yes, took the firmware and txt from [1] and observed the timeout.
> 
> # modprobe -a brcmfmac
> [  146.376922] cfg80211: Loading compiled-in X.509 certificates for
> regulatory database
> [  146.418193] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [  146.425801] platform regulatory.0: Direct firmware load for
> regulatory.db failed with error -2
> [  146.434464] cfg80211: failed to load regulatory.db
> # [  146.716016] brcmfmac: brcmf_fw_map_chip_to_name: using
> brcm/brcmfmac43430-sdio.bin for chip 0x00a9a6(43430) rev 0x000001
> [  147.781032] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000):
> clkctl 0x50
> [  148.812968] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000):
> clkctl 0x50
> [  149.824945] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000):
> clkctl 0x50
> 
> [1] https://github.com/RPi-Distro/firmware-nonfree/tree/master/brcm80211/brcm


There are several NVRAM file floating around. With some of them I observed the
same issue as yours. The NVRAM file from [2] worked fine with AP6212 on my
OrangePi Zero Plus2 v1.0. I haven't yet looked into NVRAM differences though...

[2] https://github.com/BPI-SINOVOIP/BPI-files/blob/master/others/brcm/lib/firmware/ap6212/nvram.txt

Regards,
Sergey

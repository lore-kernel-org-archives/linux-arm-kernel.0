From: aford173@gmail.com (Adam Ford)
Date: Wed, 18 Jul 2018 11:07:56 -0500
Subject: i.MX6Q no audio with wm8962 Question
In-Reply-To: <CAHCN7xLtV=wQuhorEi-BH_Ofk1bXexb33xZyF8R=QC61aciLhw@mail.gmail.com>
References: <CAHCN7xLtV=wQuhorEi-BH_Ofk1bXexb33xZyF8R=QC61aciLhw@mail.gmail.com>
Message-ID: <CAHCN7x+7MGRR+4tr22kMFxbaqOjKFh-mWz4iqpVRPQ72wiAF9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 2:40 PM Adam Ford <aford173@gmail.com> wrote:
>
> I have an iMX6Q with a wm8962 attached using AUDMUX4 and SSI2, but I
> am having difficulty getting the sound to generate from the headphone
> jack.

sorry for the noise.  It turns out to be a faulty pull-up resistor on
the I2C bus

it's working

adam
>
> I have verified the power is working, and we're getting the 24MHz
> clock signal from CK0 to the codec, and we've played with the
> alsamixer to un-mute a variety of options, yet we're still unable to
> get sound from the headphone port.
>
> sound {
> compatible = "fsl,imx-audio-wm8962";
> model = "wm8962-audio";
> ssi-controller = <&ssi2>;
> audio-codec = <&codec>;
> audio-routing =
> "Headphone Jack", "HPOUTL",
> "Headphone Jack", "HPOUTR",
> "Ext Spk", "SPKOUTL",
> "Ext Spk", "SPKOUTR",
> "AMIC", "MICBIAS",
> "IN3R", "AMIC";
> mux-int-port = <2>;
> mux-ext-port = <4>;
> };
>
>
> I beleive the mux-int-port points to ssi2 which should match the
> ssi-controller = <&ssi2> option
> I also beleive mux-ext-port = <4> should match the audmux 4 port.
>
> &i2c1 {
> pinctrl-names = "default";
> pinctrl-0 = <&pinctrl_i2c1>;
> clock-frequency = <400000>;
> status = "okay";
>
>
>
>     codec: wm8962 at 1a {
> compatible = "wlf,wm8962";
> reg = <0x1a>;
> clocks = <&clks IMX6QDL_CLK_CKO>;
> clock-names = "xclk";
> DCVDD-supply = <&reg_audio>;
> DBVDD-supply = <&reg_audio>;
> AVDD-supply = <&reg_audio>;
> CPVDD-supply = <&reg_audio>;
> MICVDD-supply = <&reg_audio>;
> PLLVDD-supply = <&reg_audio>;
> SPKVDD1-supply = <&reg_audio>;
> SPKVDD2-supply = <&reg_audio>;
> gpio-cfg = <
> 0x0000 /* 0:Default */
> 0x0000 /* 1:Default */
> 0x0013 /* 2:FN_DMICCLK */
> 0x0000 /* 3:Default */
> 0x8014 /* 4:FN_DMICCDAT */
> 0x0000 /* 5:Default */
> >;
> };
> };
>
>
> The snippet of my boot log are as follows:
>
> [    4.359592] snd-soc-dummy snd-soc-dummy: codec register snd-soc-dummy
> [    4.359615] snd-soc-dummy snd-soc-dummy: ASoC: dai register snd-soc-dummy #1
> [    4.359625] snd-soc-dummy snd-soc-dummy: ASoC: dynamically register
> DAI snd-soc-dummy
> [    4.359637] snd-soc-dummy snd-soc-dummy: ASoC: Registered DAI
> 'snd-soc-dummy-dai'
> [    4.359744] snd-soc-dummy snd-soc-dummy: ASoC: Registered codec
> 'snd-soc-dummy'
> [    4.359753] snd-soc-dummy snd-soc-dummy: ASoC: platform register
> snd-soc-dummy
> [    4.359775] snd-soc-dummy snd-soc-dummy: ASoC: Registered platform
> 'snd-soc-dummy'
> [    4.365610] wm8962 0-001a: customer id 0 revision F
> [    4.382144] wm8962 0-001a: codec register 0-001a
> [    4.382170] wm8962 0-001a: ASoC: dai register 0-001a #1
> [    4.382178] wm8962 0-001a: ASoC: dynamically register DAI 0-001a
> [    4.382190] wm8962 0-001a: ASoC: Registered DAI 'wm8962'
> [    4.382202] wm8962 0-001a: ASoC: Registered codec 'wm8962.0-001a'
> [    4.383977] fsl-asoc-card sound: ASoC: binding HiFi
>
> [    4.384007] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
>
> This seems like an issue,but it looks like it potentially gets resolved later.
>
> [    4.386043] fsl-asrc 2034000.asrc: ASoC: dai register 2034000.asrc #1
> [    4.386092] fsl-asrc 2034000.asrc: ASoC: dynamically register DAI
> 2034000.asrc
> [    4.386108] fsl-asrc 2034000.asrc: ASoC: Registered DAI '2034000.asrc'
> [    4.386126] fsl-asrc 2034000.asrc: ASoC: platform register 2034000.asrc
> [    4.386144] fsl-asrc 2034000.asrc: ASoC: Registered platform '2034000.asrc'
> [    4.387439] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back from HW
> [    4.388567] fsl-ssi-dai 202c000.ssi: ASoC: Registered platform '202c000.ssi'
> [    4.388589] fsl-ssi-dai 202c000.ssi: ASoC: dai register 202c000.ssi #1
> [    4.388597] fsl-ssi-dai 202c000.ssi: ASoC: dynamically register DAI
> 202c000.ssi
> [    4.388610] fsl-ssi-dai 202c000.ssi: ASoC: Registered DAI '202c000.ssi'
> [    4.393581] imx-wm8962 sound: ASoC: binding HiFi
> [    4.396233] input: WM8962 Beep Generator as
> /devices/soc0/soc/2100000.aips-bus/21a0000.i2c/i2c-0/0-001a/input/input1
> [    4.442347] imx-wm8962 sound: ASoC: probe wm8962-audio dai link 0 late -2
> [    4.442380] imx-wm8962 sound: ASoC: probe wm8962-audio dai link 0 late -1
> [    4.442392] imx-wm8962 sound: ASoC: probe wm8962-audio dai link 0 late 0
> [    4.442403] imx-wm8962 sound: ASoC: probe wm8962-audio dai link 0 late 1
> [    4.442412] imx-wm8962 sound: ASoC: probe wm8962-audio dai link 0 late 2
> [    4.458756] imx-wm8962 sound: wm8962 <-> 202c000.ssi mapping ok
>
>
> When trying to play audio through the headphone jack, I unmute the
> headphones in alsamixer, but when I query the interface, it appears to
> remain muted.
>
> # amixer -c0 cget numid=24
> numid=24,iface=MIXER,name='Headphone Volume'
>   ; type=INTEGER,access=rw---R--,values=2,min=0,max=127,step=0
>   : values=107,107
>   | dBscale-min=-121.00dB,step=1.00dB,mute=1
>
>
>
> I have tried unmute with a simiar instruction without any luck.
>
> I also noticed that when I run speaker-test -c2 -t wav, I get the
> following message:
>
> [ 1467.051679] wm8962 0-001a: Failed to read DCS status: -1
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 3840 to 17280
> Period size range from 1920 to 1920
> Using max buffer size 17280
> Periods = 4
> was set period_size = 1920
> was set buffer_size = 17280
>  0 - Front Left
> Time per period = 1.138101
>  0 - Front Left
> ^CTransfer failed: Bad address
> # [ 1474.553646] wm8962 0-001a: Failed to read DSPCLK: -1
>
>
> I am assuming that being unable to read the DCS -1 is a bad thing.
> Unfortunatly, after this instruction. we can no longer use alsamixer
> or the any alsa tool except for the speaker-test app.
> When running the speaker test a second time I get even more errors:
>
> Stream parameters are 48000Hz, S16_LE, 2 channels
> WAV file(s)
> [ 1700.659314] wm8962 0-001a: Unable to sync registers 0x0-0x3. -6
> [ 1700.833594] wm8962 0-001a: Failed to read DSPCLK: -1
> [ 1700.862662] wm8962 0-001a: ASoC: POST_PMU: HPOUTL PGA event failed: -6
> [ 1700.869709] wm8962 0-001a: ASoC: POST_PMU: SPKOUTL PGA event failed: -6
> [ 1700.879766] wm8962 0-001a: ASoC: POST_PMU: HPOUTR PGA event failed: -6
> [ 1700.888565] wm8962 0-001a: ASoC: POST_PMU: SPKOUTR PGA event failed: -6
> [ 1700.922471] wm8962 0-001a: Failed to read DCS status: -1
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 3840 to 17280
> Period size range from 1920 to 1920
> Using max buffer size 17280
> Periods = 4
> was set period_size = 1920
> was set buffer_size = 17280
>  0 - Front Left
>  1 - Front Right
>
> This worked one day, and for some reason, it seems to have stopped,
> and its repeatable on multiple boards, so I think it's a software
> configuration somewhere.
>
> Might someone have any suggestions?
>
> thank you,
>
> adam

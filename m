From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 14 May 2018 13:34:56 +0530
Subject: Allwinner A64: Issue on external rtc clock to wifi chip
In-Reply-To: <20180514075727.uxggyhmbahvhestx@flea>
References: <CAMty3ZCNyuEwmLGdDZLM_9qKJ2NsT33rodug7ZpKAE-OHymVEg@mail.gmail.com>
 <20180514075727.uxggyhmbahvhestx@flea>
Message-ID: <CAMty3ZDew=+zytKUx5+nX27CjCe0UfJpyYOy2s07NoJvbe57mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 1:27 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> Hi,
>
> On Mon, May 14, 2018 at 12:37:49PM +0530, Jagan Teki wrote:
>> Hi Maxime and All,
>>
>> We are trying to bring-up AP6330 Wifi chip for A64 board. We noticed
>> to have an external rtc clock has driven from wifi chip.
>>
>> So the devicetree is configured according to this as below.
>>
>> / {
>>         wifi_pwrseq: wifi-pwrseq {
>>                 compatible = "mmc-pwrseq-simple";
>>                 clocks = <&rtc 1>;
>>                 clock-names = "ext_clock";
>>                 reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>>                 post-power-on-delay-ms = <400>;
>>         };
>> };
>>
>> &rtc {
>>         clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
>>         clocks = <&osc32k>;
>>         #clock-cells = <1>;
>> };
>>
>> &mmc1 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&mmc1_pins>;
>>         vmmc-supply = <&reg_dcdc1>;
>>         vqmmc-supply = <&reg_eldo1>;
>>         mmc-pwrseq = <&wifi_pwrseq>;
>>         bus-width = <4>;
>>         non-removable;
>>         status = "okay";
>>
>>         brcmf: wifi at 1 {
>>                 reg = <1>;
>>                 compatible = "brcm,bcm4329-fmac";
>>                 interrupt-parent = <&r_pio>;
>>                 interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>;  /* WL-WAKE-AP: PL3 */
>>                 interrupt-names = "host-wake";
>>         };
>> };
>>
>> And observed rtc-osc32k-out clock is never enabled[1] and the value of
>> LOSC_OUT_GATING is 0x0 which eventually not enabling
>> LOSC_OUT_GATING_EN
>>
>> Pls. let us know if we miss anything here?
>>
>> [1] https://paste.ubuntu.com/p/X2By4q8kD2/
>
> Could you paste your config and the logs from a boot to?

.config
https://paste.ubuntu.com/p/w9w2KB7RFc/

dmesg
https://paste.ubuntu.com/p/mrZGk5bWRR/

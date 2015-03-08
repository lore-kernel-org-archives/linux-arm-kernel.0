From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 08 Mar 2015 12:25:38 +0100
Subject: [linux-sunxi] [PATCH 6/7] ARM: dts: sun7i: Add OOB irq support
 to boards with broadcom sdio wifi
In-Reply-To: <CAGb2v642i_Yg9PAg=iMyVgzm0gNwe6v7wmziYJTZcjoDBAFmcw@mail.gmail.com>
References: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
 <1425754884-7875-6-git-send-email-hdegoede@redhat.com>
 <CAGb2v642i_Yg9PAg=iMyVgzm0gNwe6v7wmziYJTZcjoDBAFmcw@mail.gmail.com>
Message-ID: <54FC31B2.3030706@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08-03-15 04:12, Chen-Yu Tsai wrote:
> On Sun, Mar 8, 2015 at 3:01 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 11 +++++++++++
>>   arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts  | 11 +++++++++++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>> index 0c219a4..8111b0c 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>> @@ -167,12 +167,23 @@
>>   };
>>
>>   &mmc3 {
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&mmc3_pins_a>;
>>          vmmc-supply = <&reg_vmmc3>;
>>          bus-width = <4>;
>>          non-removable;
>>          status = "okay";
>> +
>> +       brcmf: bcrmf at 1 {
>> +               reg = <1>;
>> +               compatible = "brcm,bcm4329-fmac";
>> +               interrupt-parent = <&pio>;
>> +               interrupts = <10 8>; /* PH10 / EINT10 */
>> +               interrupt-names = "host-wake";
>> +       };
>
> I gave this a spin on my Cubietruck. (I was running cap-sdio-irq before.)
>
> Ran a few ping tests with a simple
> "sudo ping -i 0.1 -I wlan0 -s 65500 192.168.1.1"
> After a few runs I got
>
> sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD SBE !!
> sunxi-mmc 1c12000.mmc: data error, sending stop command
> brcmfmac: brcmf_sdio_readframes: RXHEADER FAILED: -110
> brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send NAK
> brcmfmac: brcmf_sdiod_regrw_helper: failed to write data F1 at 0x0a040, err: -5
> brcmfmac: brcmf_sdio_hdparse: seq 226: sequence number error, expect 227
> sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD DTO !!
> sunxi-mmc 1c12000.mmc: data error, sending stop command
> sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD DTO !!
> sunxi-mmc 1c12000.mmc: data error, sending stop command
> sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD DTO !!
> sunxi-mmc 1c12000.mmc: data error, sending stop command
> brcmfmac: brcmf_sdiod_regrw_helper: failed to read data F1 at 0x0a020, err: -110
> brcmfmac: brcmf_sdio_dpc: failed backplane access over SDIO, halting operation
> sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD DTO !!
> sunxi-mmc 1c12000.mmc: data error, sending stop command
> sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD DTO !!
> sunxi-mmc 1c12000.mmc: data error, sending stop command
> sunxi-mmc 1c12000.mmc: smc 1 err, cmd 53, RD DTO !!
> sunxi-mmc 1c12000.mmc: data error, sending stop command
>
> The chip is pretty much dead afterwards.
>
> With cap-sdio-irq it doesn't happen so soon, but it does.
> Without either, the response time is bad with packet losses,
> but at least it doesn't die.

That is not true, without either cap-sdio-irq or oob irq it
still dies, try doing a scp of a large file, that is a more
reliable way to trigger it.

I've been down this road (blaming the irq) mechanism myself,
but it is a dead end, the problem you're describing, the CMD 53
SBE error happens with all 3 irq mechanisms.

> Is this the problem Arend (CC-ed) was looking into?

Is looking into, yes. He has a Cubietruck now, and he can reproduce
it, so hopefully we will see some progress on this soon.

Note that as a workaround (for me at least) you can boot into
the linux on the cubietruck nand, then insert an sdcard with
upstream kernel, then reboot so that it boots from the sdcard
without loosing power, and then the problem seems to be gone.

Regards,

Hans

From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 21 Jun 2016 17:11:21 +0800
Subject: [PATCH] ARM: sun8i: Add Parrot Board DTS
In-Reply-To: <20160620183543.GM26668@lukather>
References: <1465812931-22824-1-git-send-email-quentin.schulz@free-electrons.com>
 <1465812931-22824-2-git-send-email-quentin.schulz@free-electrons.com>
 <CAGb2v64jduBijEXzsKbOpSvLd9YHwO=qpSyPSDuYtMPg8wfKzA@mail.gmail.com>
 <575FFFBE.5090107@free-electrons.com>
 <CAGb2v67JGG35odB7kEAoF0kGes=KRGoREOSTc_GM0B4A+8cKWg@mail.gmail.com>
 <20160620154452.GL26668@lukather>
 <CAGb2v66_iUMd5V=9Np4Kqqv+yqq2HbjoPhC3Z6cpHFrMzkddvw@mail.gmail.com>
 <20160620183543.GM26668@lukather>
Message-ID: <CAGb2v66KPsQ60QbwbWP1nEcjpWVf8CP5vAyOeVpB5hL-Q+wUmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 2:35 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Jun 21, 2016 at 12:30:25AM +0800, Chen-Yu Tsai wrote:
>> >> >>> +&reg_aldo1 {
>> >> >>> +       regulator-always-on;
>> >> >>> +       regulator-min-microvolt = <3000000>;
>> >> >>> +       regulator-max-microvolt = <3000000>;
>> >> >>> +       regulator-name = "aldo1";
>> >> >>
>> >> >> What is this for exactly? Would turning it off render the system inoperable?
>> >> >> How was it referenced in the fex file?
>> >> >>
>> >> >> If this is for WiFi I/O VCC, then you should specify it in mmc1 with
>> >> >> vqmmc-supply.
>> >> >>
>> >> >
>> >> > In the fex, aldo1 is one of the three power inputs for the WiFi (the
>> >> > others being dldo1 and dldo2) and in the schematics it is linked to
>> >> > both VCC-USB and VCC-IO-WIFI.
>> >> >
>> >> > I tried to turn it off and, indeed, the system becomes inoperable.
>> >> >
>> >> > I'll add vqmmc-supply in mmc1 with aldo1 regulator. However, I am
>> >> > wondering what to put in vmmc-supply for mmc1 since the WiFi module has
>> >> > three power inputs: dldo1, dldo2 and aldo1. In the fex, they are
>> >> > referenced as, respectively, module_power1, module_power2 and
>> >> > module_power3 and in the schematics dldo1 and dldo2 are named VCC-WIFI
>> >> > while aldo1 is used for VCC-IO-WIFI (if it can help in any way).
>> >> >
>> >> > VCC-WIFI is connected to pin VBAT of the Broadcom AP6212 WiFi chip.
>> >> > VCC-IO-WIFI is connected to pin VDDIO of the chip.
>> >>
>> >> VCC-IO-WIFI is vqmmc, and VCC-WIFI is vmmc.
>> >
>> > Isn't vmmc supposed to be always powered at 3.3v, and vqmmc the one
>> > used to drop to 1.8V with the UHS cards?
>>
>> For eMMC, vmmc and vqmmc correspond to the pins on the eMMC chip.
>> vmmc provides power to the internals, while vqmmc provides power to the
>> I/O buffers on both sides. With SD this is a bit less clear. IIUC the SD
>> card itself supplies I/O voltage, dropping it to 1.8V if necessary, from
>> VDD (vmmc). vqmmc only affects the host side, and whatever external pull-ups
>> that might exist.
>
> Ok.
>
>> > In which case, VCC-IO-WIFI is vmmc, and VCC-WIFI is just one of the
>> > wifi chip power rail, to be handled by a power sequence.
>>
>> For the WiFi chip, there is a separate IO-VCC rail, which is VCC-IO-WIFI.
>> This, from what I understand of the datasheet, is for I/O signaling, and
>> thus vqmmc. VCC-WIFI is what powers the chip, which is what vmmc is.
>
> Ok. but there's still the issue of the two regulators that needs to be
> kept in sync. Before, that, I'd rather stice to not tying them to the
> MMC bus, and putting a comment on top.

OK. Let's do that for now.

ChenYu

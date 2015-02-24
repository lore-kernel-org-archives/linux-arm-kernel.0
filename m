From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 23 Feb 2015 20:28:03 -0800
Subject: [PATCH 2/2] ARM: shmobile: silk: add SDHI0/1 DT support
In-Reply-To: <54E9ED95.8070702@cogentembedded.com>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <2348421.LHyZ4ZOiiG@wasted.cogentembedded.com>
 <CANqRtoRnDzTSvKYcNDHKHbeaN7jp1VvKnk1jTHDvNt1oyBzwKg@mail.gmail.com>
 <54E9ED95.8070702@cogentembedded.com>
Message-ID: <CANqRtoQhGOob734kNqNNjMxPcT2Fz=1X6J4M1iobzyiF8Cp8nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Sun, Feb 22, 2015 at 6:54 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 02/22/2015 03:45 AM, Magnus Damm wrote:
>
>>> Define the SILK board dependent parts of the SDHI0  (connected to SDIO
>>> Wi-Fi
>>> chip)  and SDHI1  (connected to micro-SD slot) device nodes along with
>>> the
>>> necessary voltage regulators.
>
>
>>> Based on the original patch by Vladimir Barinov
>>> <vladimir.barinov@cogentembedded.com>.
>
>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
>
>> Thanks for your patch. One question - above you write that SDHI1 is
>> micro-SD...
>
>
>    Yes, have double-checked now.
>
>
>>> @@ -100,3 +159,25 @@
>>>          non-removable;
>>>          status = "okay";
>>>   };
>>> +
>>> +&sdhi0 {
>>> +       pinctrl-0 = <&sdhi0_pins>;
>>> +       pinctrl-names = "default";
>>> +
>>> +       vmmc-supply = <&vcc_sdhi0>;
>>> +       vqmmc-supply = <&vccq_sdhi0>;
>>> +       cd-gpios = <&gpio6 6 GPIO_ACTIVE_LOW>;
>>> +       wp-gpios = <&gpio6 7 GPIO_ACTIVE_LOW>;
>>> +       status = "okay";
>>> +};
>>> +
>>> +&sdhi1 {
>>> +       pinctrl-0 = <&sdhi1_pins>;
>>> +       pinctrl-names = "default";
>>> +
>>> +       vmmc-supply = <&vcc_sdhi1>;
>>> +       vqmmc-supply = <&vccq_sdhi1>;
>>> +       cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
>>> +       wp-gpios = <&gpio6 15 GPIO_ACTIVE_LOW>;
>>> +       status = "okay";
>>> +};
>
>
>> ... however here the WP signal is assigned.
>
>
>> I believe micro-SD doesn't use the WP signal, so either I'm wrong or
>> the patch needs to be updated to reflect reality. =)
>
>
>    Both seem correct: SD1_WP signal is just tied to VCCQ_SD1. Do you think
> we should still drop it?

If the signal is not exposed to the card connector then I believe the
correct approach is to omit it. So yes, please drop it.

>> Also, I doubt that an on-board SDIO module makes use of CD and/or WP
>> signals?
>
>    Those two are tied to VCCQ_SD0 as well. Do you think we should drop them?

Since the on-board SDIO chip does not support hotplug and cannot be
write-protected I think those should be dropped too.

Thanks,

/ magnus

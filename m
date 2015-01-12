From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 12 Jan 2015 15:11:41 +0100
Subject: [PATCH v2 3/5] pinctrl: exynos: Fix GPIO setup failure because
 domain clock being gated
In-Reply-To: <CA+Ln22H_a9CWxrYO_i9Esm6keXA8XLLYmE1Vg-8ynamJ1sAwpQ@mail.gmail.com>
References: <1417011857-10419-1-git-send-email-k.kozlowski@samsung.com>
 <1417011857-10419-4-git-send-email-k.kozlowski@samsung.com>
 <CACRpkdb8F8YcvFeHPvOKHjx_p4HEpimck3XRabB3oHpZTdmRQQ@mail.gmail.com>
 <1417183724.18249.36.camel@AMDC1943>
 <CA+Ln22Ejo51VPWf6DmuRvV_fZr_H=-BXAshSPSOokNE1bz=-QA@mail.gmail.com>
 <1417423043.4055.14.camel@AMDC1943>
 <CA+Ln22H_a9CWxrYO_i9Esm6keXA8XLLYmE1Vg-8ynamJ1sAwpQ@mail.gmail.com>
Message-ID: <1421071901.20276.7.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2014-12-01 at 23:34 +0900, Tomasz Figa wrote:
> 2014-12-01 17:37 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> >
> > On nie, 2014-11-30 at 21:19 +0900, Tomasz Figa wrote:
> >> Hi Krzysztof,
> >>
(...)
> >
> >> Also isn't a similar problem happening due to power domains? I believe
> >> the whole maudio block is located in a separate power domain but
> >> somehow it doesn't get turned off?
> >
> > There is Maudio power domain... but I think it is not related here.
> 
> Could you somehow check what happens when the maudio power domain is
> turned off and maudio pin controller is accessed? Could you also check
> the difference in power consumption with this domain powered on and
> off?

Hi Tomasz,

Some time ago you asked for some details of Exynos5420 Maudio domain
behavior. Here it goes:

1. mau domain ON, EPL: OFF: boot hang (this was behavior after adding
runtime PM to pl330 driver)

2. maud domain OFF, EPLL OFF: boot hang

3. maud domain ON, EPLL ON: works (current linux-next and mainline)

4. maud domain OFF, EPLL ON: works, almost the same energy consumption
as in (3) (diff: 0.1% so it is smaller than measuring accuracy).

However an unspecified imprecise abort shows up in (4):
[   11.911628] Freeing unused kernel memory: 328K (c0674000 - c06c6000)
[   12.122695] usb 5-1.4: new high-speed USB device number 3 using exynos-ehci
[   12.190011] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
[   12.219062] usb 5-1.4: New USB device found, idVendor=0b95, idProduct=772a
[   12.224548] usb 5-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   12.231794] usb 5-1.4: Product: AX88772
[   12.235681] usb 5-1.4: Manufacturer: ASIX Elec. Corp.
[   12.240707] usb 5-1.4: SerialNumber: 000001
[   12.248835] asix 5-1.4:1.0 (unnamed net_device) (uninitialized): invalid hw address, using random
root@(none):/#

Best regards,
Krzysztof

> 
> > Pinctrl driver does not have runtime PM and is not attached to a domain.
> > I thought about other solution to this problem (with utilization of
> > power domains):
> >  - add runtime PM to pinctrl and audss clocks,
> >  - attach pinctrl and audss clocks to maudio power domain,
> >  - enable the clock when power domain is turned on.
> > However almost the same changes had to be added to pinctrl and audss
> > clocks drivers (replace clock_enable() with pm_runtime_get_sync()).
> 
> Well, if the dependency is there due to hardware design, I think it
> needs to be reflected in the drivers as well.
> 
> Few other issues that came to my mind:
> 
>  - Your previous patch added clock control only to pinctrl operations.
> Shouldn't GPIO operations be included as well?
> 
>  - If power domain dependency is there too, what happens with GPIO
> pins if the domain is powered off? If they lose their states, wouldn't
> it necessary to keep the domain powered on whenever there is some GPIO
> pin requested (which usually = in use)? (I'd assume that special
> functions shouldn't take a reference on runtime PM, because they are
> related to IP blocks in the same PM domain, which will implicitly keep
> the domain powered on.)
> 
>  - Doesn't the clock controller also lose its state whenever the power
> domain is powered off? I guess that would be similar to ISP clock
> controller, issues of which are still not resolved in mainline.
> Sylwester could tell you more about this, I guess.
> 
> Best regards,
> Tomasz

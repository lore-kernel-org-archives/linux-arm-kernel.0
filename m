From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Jan 2018 23:05:33 +0100
Subject: [PATCH 1/3] arm: spear600: Add missing interrupt-parent of rtc
In-Reply-To: <CAOesGMiHeitS_j9r0DsPf3k1jVJT9_z-bHyrhbB7fQ__LjjaqA@mail.gmail.com>
References: <a062d9ed0d3365b578156a780202fa533e725374.1515650104.git.viresh.kumar@linaro.org>
 <20180112020711.6gp2pnsxxjzelidq@localhost> <20180112032223.GK3626@vireshk-i7>
 <CAOesGMggU73asY1SEUDD_BsWcrGYR___o8e5omjziOPEwJgqBQ@mail.gmail.com>
 <CAK8P3a2SO4=YKBE3L_AKsyfNe77YR7a8F=dvbS=ic03=6NK8MA@mail.gmail.com>
 <CAOesGMgcf9FovbzhPkKnrG4ETRFP3dsSJnTYNfp1wECMFeFOGA@mail.gmail.com>
 <CAL_JsqJVWLazDRB1me2OubqqMhdsqsR+cLSHR+K0OY3dZHcE-w@mail.gmail.com>
 <CAOesGMiyfpRyoe4dxQeNMF5invysVBEy+J5OwUhuop=JyAvZoQ@mail.gmail.com>
 <CAK8P3a3KTz0sOSbO9+sAY1Sv95hZF4Yg1qMzOaXPAZ_1pOgGpg@mail.gmail.com>
 <CAOesGMiHeitS_j9r0DsPf3k1jVJT9_z-bHyrhbB7fQ__LjjaqA@mail.gmail.com>
Message-ID: <CAK8P3a3MZX-ZsxX9h1-8kVQhn9hqY=c8L1+=e3uTfjEjBCYuPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 10:57 PM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Jan 12, 2018 at 1:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Jan 12, 2018 at 10:50 PM, Olof Johansson <olof@lixom.net> wrote:
>>> On Fri, Jan 12, 2018 at 12:45 PM, Rob Herring <robh+dt@kernel.org> wrote:
>>>> On Fri, Jan 12, 2018 at 12:23 PM, Olof Johansson <olof@lixom.net> wrote:
>>>> I have more dtc checks in the works (nothing for 4.16 :) ). I'd like
>>>> the process to work better. I'm not going to fix all the warnings. I
>>>> don't think Arnd should either. Turning them off by default hasn't
>>>> worked great either. For some, I'm not sure we can ever get to warning
>>>> free, but I'd like new stuff to have warnings enabled and no one
>>>> builds with W=1. We could put together tooling to just show new
>>>> warnings, but someone has to run it and enforce it. I could stick dtc
>>>> updates into linux-next for multiple cycles before sending to Linus.
>>>
>>> I'll split up and report DT warnings separate from compiler, seems
>>> like a reasonable approach.
>>
>> Maybe also report any other output from the build process as another
>> category. When things build fine, we should see no output at all.
>
> Yep, true.
>
> Right now there's mostly DTC warnings and missing MODULE_LICENSE().

I've sent patches for all the remaining MODULE_LICENSE warnings earlier
this week, and we should now have patches for almost all the dtc
warnings in flight. This is what I still see on my randconfig builder
with linux-next + arm-soc/for-next + patches I sent:

     arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property):
Missing property '#gpio-cells' in node /interrupt-controller at ec801000
or bad phandle (referred from /ahb/apb/spi at e0100000:cs-gpios[6])
     arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property):
Property 'cs-gpios', cell 6 is not a phandle reference in
/ahb/apb/spi at e0100000
     arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property):
Missing property '#dma-cells' in node /interrupt-controller at ec801000
or bad phandle (referred from /ahb/apb/serial at b4100000:dmas[4])
     arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property):
Property 'dmas', cell 4 is not a phandle reference in
/ahb/apb/serial at b4100000
     arch/arm/boot/dts/spear600-evb.dtb: Warning
(interrupts_property): Missing interrupt-parent for
/ahb/apb/rtc at fc900000
     arch/arm/boot/dts/ste-nomadik-nhk15.dtb: Warning
(interrupts_property): Missing interrupt-parent for
/amba/clcd at 10120000
     arch/arm/boot/dts/ste-nomadik-s8815.dtb: Warning
(interrupts_property): Missing interrupt-parent for
/amba/clcd at 10120000

Not sure why the spear warnings are still there, maybe Viresh missed those
or you missed one of his patches?

I hope Linus Walleij can find out what the right interrupt-parent
should be on the
nomadik machine, that is otherwise the last remaining warning. Apparently the
clcd driver doesn't actually need its interrupt, so we could decide to
just comment
out that line if we don't know which controller it's connected to.

       Arnd

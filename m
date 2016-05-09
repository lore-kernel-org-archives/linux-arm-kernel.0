From: robh@kernel.org (Rob Herring)
Date: Mon, 9 May 2016 12:00:43 -0500
Subject: [PATCH] ARM: dts: imx: Remove unneeded unit-addresses
In-Reply-To: <20160506121911.04a7aa6e@jclayton-pc>
References: <1462283851-10820-1-git-send-email-fabio.estevam@nxp.com>
 <CAL_JsqKv_7ufFG7DSkxqp9QOEjLEDVofyYMoudtJjqBA78ahcA@mail.gmail.com>
 <CAOMZO5AO15UmNJARS9aL-U=CjYnUq0D9S38NYHC8w2DLwOeR_A@mail.gmail.com>
 <CAOMZO5BXFL47p=WTPDDRFGq38yktmB1FnbOTWJ37mrWsKkeUSQ@mail.gmail.com>
 <20160506121911.04a7aa6e@jclayton-pc>
Message-ID: <CAL_JsqKp5q5oL=s6haOU8ggtst_ejL5wZx2NeqFi=izF64z6cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 6, 2016 at 2:19 PM, Joshua Clayton <stillcompiling@gmail.com> wrote:
> On Tue, 3 May 2016 12:45:07 -0300
> Fabio Estevam <festevam@gmail.com> wrote:
>
>> On Tue, May 3, 2016 at 12:42 PM, Fabio Estevam <festevam@gmail.com>
>> wrote:
>> > On Tue, May 3, 2016 at 12:37 PM, Rob Herring <robh@kernel.org>
>> > wrote:
>> >> Presumably these are register offsets which could be useful to have
>> >> even if the Linux driver doesn't use them. But either way is fine
>> >> with me.
>> >
>> > Yes, these are register offsets.
>> >
>> >                 reg_3p0: regulator-3p0 {
>> >                     compatible = "fsl,anatop-regulator";
>> >                     regulator-name = "vdd3p0";
>> >                     regulator-min-microvolt = <2625000>;
>> >                     regulator-max-microvolt = <3400000>;
>> >                     anatop-reg-offset = <0x120>;
>>
>> Sorry, pressed the 'send' button too quickly.
>>
>> There is a "anatop-reg-offset = <0x120>;" property that is used to
>> pass the offset to the anatop regulator driver, so that's why I
>> preferred to remove the unneeded unit-address.
>>
>> Thanks
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> There are actually 2 registers (on some of them),
> anatop-reg-offset, and anatop-delay-reg-offset...
> Converting those to use reg and deprecating the anatop specific
> items would seem like a Good Thing (tm) to me.
>
> ...wandering into less safe territory:
> I know reg is usually a memory offset in bytes, but
> each of the anatop memory offsets also include a bit-shift
> and a bit-width item, which really narrowly defines the
> register bits that pertain to each regulator.
>
> would it be totally inappropriate to use
> #address-cells = 2 and
> #size-cells =1
> where address cells would contain the byte offset and the bit shift, and
> the size cell would contain the bit offset?

Technically that is fine. However, then the standard address
translation functions will not work.

Given it is also encoding bit offsets, I'd just keep this patch as is.
We could also debate just not putting this in the DT at all.

Acked-by: Rob Herring <robh@kernel.org>

Rob

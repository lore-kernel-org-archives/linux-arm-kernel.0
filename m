From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Nov 2016 12:31:30 +0100
Subject: [PATCH v3] ARM: dts: Add gyro and accel to APQ8060 Dragonboard
In-Reply-To: <20161031222029.GG25787@tuxbot>
References: <1477473794-26030-1-git-send-email-linus.walleij@linaro.org>
 <20161031222029.GG25787@tuxbot>
Message-ID: <CACRpkdbipgysCjQDgvBhex7SewVaV379gL-wsZuHCY4Mz1p-aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2016 at 11:20 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

>> +                                     interrupt-parent = <&pm8058_gpio>;
>> +                                     interrupts = <208 IRQ_TYPE_EDGE_FALLING>;
>
> To remove the need of resetting the interrupt-parent in each child you
> can use the following form:
>
>     interrupts-extended = <&pm8058_gpio 208 IRQ_TYPE_EDGE_FALLING>;
>
> But, if we correct the ssbi gpio driver then this would no longer be
> interrupt 208 in this parent, right?. I believe that if you say
> <&pmicintc 208 IRQ_TYPE_EDGE_FALLING> instead, which should work even
> after we correct the gpio translation.

Yes. It should be fixed everywhere but is not related to this
patch. But I can do a two-patch series first fixing this and then
adding the gyro+accelerometer on top referencing the MFD
pmicintc as parent.

> (Which probably means we need to get that redesigned, before we
> introduce to many of these)

What needs to happen is for the SSBI and SPMI GPIO to use a
hierarchical irqdomain so their GPIO local line offset and hwirq
are the same. Then we can reference the GPIO IRQ lines directly
in a correct manner.

You are not alone with this mess. A lot of hierarchical GPIOs
are wrong. My fail as GPIO maintainer I guess, ouch.

Yours,
Linus Walleij

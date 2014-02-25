From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 25 Feb 2014 14:05:26 +0100
Subject: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
In-Reply-To: <20140225123921.GY27282@n2100.arm.linux.org.uk>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
 <1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch>
 <20140224180336.GU27282@n2100.arm.linux.org.uk>
 <CABxcv=kKxidVJWcMrueB+edW=g_6gcucvi6=7p=EZ_WooCpbMA@mail.gmail.com>
 <20140225123921.GY27282@n2100.arm.linux.org.uk>
Message-ID: <530C9516.7070501@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/25/2014 01:39 PM, Russell King - ARM Linux wrote:
> On Mon, Feb 24, 2014 at 05:22:27PM -0300, Javier Martinez Canillas wrote:
>> Hi Russell,
>>
>> On Mon, Feb 24, 2014 at 3:03 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Mon, Feb 24, 2014 at 06:07:49PM +0100, Florian Vaussard wrote:
>>>> +     hdmi0: connector at 0 {
>>>> +             compatible = "hdmi-connector";
>>>
>>> This looks way to generic a compatible string.  Are you sure it's
>>> correct?
>>>
>>
>> That compatible string is correct according to the latest series
>> posted by Tomi Valkeinen to add DT bindings for the OMAP Display
>> SubSystem (DSS) [0].
> 
> in which case:
> 
> N    N   AA     CCCC  K  K
> NN   N  A  A   C    C K K
> N N  N A    A C       KK
> N  N N AAAAAA C       KK
> N   NN A    A  C    C K K
> N    N A    A   CCCC  K  K
> 

What a nice nack.

> Yes, that's a very big nack.  Two things:
> 
> 1. OMAP really doesn't have the right to define a compatible string which
>    is as generic as "hdmi-connector".
> 
> 2. Even with "omapdss," before it, the convention that DT people have adopted
>    is for the prefix to be "companyname," and not a subsystem.
> 
> I'm not the only one with this concern - I discussed it with Arnd last
> night and his comments were about it being "obviously bogus".
>

I agree. It should probably be "ti,omapdss-hdmi-connector", or simply
"ti,hdmi-connector", if any.

>> The property is added on this patch [1] and as far as I understood the
>> idea is that it could be a generic DT binding that can be used by
>> platform specific HDMI connectors like the omap dss HDMI connector [2].
> 
> Why do the physical connectors need a DT binding?  Surely what needs the
> DT binding is the HDMI encoder - and that certainly should no way be a
> generic name, because there's no such thing as a generic HDMI encoder
> chip.
> 

The HDMI IP is declared in omap4.dtsi, with the compatible
"ti,omap4-hdmi". The code of the HDMI connector [1] seems to mainly call
ops of the connected endpoint, so it seems to act as a logical
termination in the DSS chain, but I may be wrong.

Regards,
Florian

[1]
https://git.kernel.org/cgit/linux/kernel/git/tomba/linux.git/tree/drivers/video/omap2/displays-new/connector-hdmi.c?h=work%2Fdss-dt-review-3

From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 17 Apr 2018 14:03:41 +0100
Subject: [PATCH] ARM: dts: Restructure Vexpress motherboard includes
In-Reply-To: <CACRpkda0Fq+b4htyx=8Kez7UGj_jQ-MO1orL=QESQ-JaAAjG=g@mail.gmail.com>
References: <20180417114331.5233-1-linus.walleij@linaro.org>
 <86a95dd0-a702-3dce-e69b-20205a519a88@arm.com>
 <CACRpkda0Fq+b4htyx=8Kez7UGj_jQ-MO1orL=QESQ-JaAAjG=g@mail.gmail.com>
Message-ID: <b736820a-e851-a8de-06ca-f3c79135825a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/18 13:43, Linus Walleij wrote:
[...]
>>> +/ {
>>> +       smb at 8000000 {
>>
>>
>> Nit: Surely "&smb {", given that you've already gone to the length of
>> labelling it in the includers? (plus that should also avoid the need to
>> reindent)
> 
> I tried that and it didn't work.
> 
> I guess it is because the includes go in the reverse parsing order, this
> file is included into the main DTS.
> 
> If the &smb was referenced from the DTS to the definition in
> the DTSI, it would work fine.
> 
> However the reverse, &smb before the node has been defined
> (it's in the DTS) doesn't work and seems to reflect to top-to-bottom
> parsing scheme.

Ah, right, I'd overlooked that the funky VExpress "one board, many SoCs" 
setup makes this inclusion backwards compared to the typical usage. I 
suppose the way to make it more regular would be to add an extra level 
of indirection, i.e. vexpress-<tile>.dts as just:

#include vexpress-<tile>.dtsi
#include vexpress-motherboard.dtsi

which in no way seems worth the bother. Let's keep this as-is then 
(although possibly that means we don't really need the smb labels at all?)

Thanks,
Robin.

From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue, 12 Jul 2011 09:46:18 -0700
Subject: [PATCH 4/6] ARM: i.MX53: clean up iomux-mx53.h
In-Reply-To: <4E1C76D3.8070006@boundarydevices.com>
References: <1310428928-2637-1-git-send-email-troy.kisky@boundarydevices.com>	<1310428928-2637-4-git-send-email-troy.kisky@boundarydevices.com>	<20110712133758.GS6069@pengutronix.de>
	<4E1C76D3.8070006@boundarydevices.com>
Message-ID: <4E1C7A5A.8000508@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/12/2011 9:31 AM, Troy Kisky wrote:
> On 7/12/2011 6:37 AM, Sascha Hauer wrote:
>> On Mon, Jul 11, 2011 at 05:02:06PM -0700, Troy Kisky wrote:
>>> Delete about 1,000 symbols used only once
>>>
>>> I used the following script to clean up the file.
>>> cp iomux-mx53.h iomux-mx53.h.cpy
>>>
>>> grep "define _MX5" iomux-mx53.h.cpy | \
>>> sed -e 's/#define[ \x09]\+\(_MX5[0-9a-zA-Z_]*\)[ \x09]\+\(.\+\)/s@\1@\2 at g/' >t.tmp
>>>
>>> grep -v "define _MX5" iomux-mx53.h.cpy | \
>>> sed -f t.tmp | \
>>> sed -e 's/,[ \x09]*\([^,]\+\)/, \1/g' \
>>> -e 's/, 0)[ \x09]*|[ \x09]*MUX_PAD_CTRL(/, /' \
>>> -e 's/(IOMUX_PAD(\(.*\)))/IOMUX_PAD(\1)/' \
>>> -e 's/0x\([0-9a-fA-F]\{2\}\)[ \x09]*,/0x0\1,/' \
>>> -e 's/NON_PAD_I/__NA_/' \
>>> -e 's/0x0,/__NA_,/' \
>>> -e 's/#define[ \x09]\+\(MX5[0-9a-zA-Z_]*\)[ \x09]\+\(IOMUX_PAD.\+\)/#define \1\x09\2/' \
>>> -e 's/\(#define MX5[^\x09]\{5,12\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\x09\x09\x09\x09\2/' \
>>> -e 's/\(#define MX5[^\x09]\{13,20\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\x09\x09\x09\2/' \
>>> -e 's/\(#define MX5[^\x09]\{21,28\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\x09\x09\2/' \
>>> -e 's/\(#define MX5[^\x09]\{29,36\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\x09\2/' \
>>> -e 's/\(#define MX5[^\x09]\{45,\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\\\n\x09\x09\x09\x09\x09\x09\x09\2/' \
>>> -e 's/, IOMUX_CONFIG_SION,/, 0 | IOMUX_CONFIG_SION,/' >iomux-mx53.h
>>>
>>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>>> ---
>>>  arch/arm/plat-mxc/include/mach/iomux-mx53.h | 3527 +++++++++------------------
>>>  1 files changed, 1184 insertions(+), 2343 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
>>> index 235d7ea..04dbbb6 100644
>>> --- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
>>> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
>>> @@ -23,7 +23,7 @@
>>>  
>>>  /* These 2 defines are for pins that may not have a mux register, but could
>>>   * have a pad setting register, and vice-versa. */
>>> -#define NON_PAD_I	0x00
>>> +#define __NA_	0x00
>>>  
>>>  #define MX53_UART_PAD_CTRL		(PAD_CTL_PKE | PAD_CTL_PUE |	\
>>>  		PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST | PAD_CTL_HYS)
>>> @@ -31,2348 +31,1189 @@
>>>  				PAD_CTL_PUS_47K_UP | PAD_CTL_DSE_HIGH | \
>>>  				PAD_CTL_SRE_FAST)
>>>  
>>> -#define _MX53_PAD_GPIO_19__KPP_COL_5		IOMUX_PAD(0x348, 0x20, 0, 0x840, 0, 0)
>>
>> The underscore versions are for the case when somebody wants a
>> nonstandard pad control setting and shouldn't be removed.
>>
>> Sascha
>>
> 
> I handled that case.
> 
> 
> +#define NEW_PAD_CTRL(cfg, pad)	((cfg & ~MUX_PAD_CTRL_MASK) |
> MUX_PAD_CTRL(pad))
> 
> 
> 
> Look at patch 4/6
> 
Sorry,

I meant 5/6
Troy

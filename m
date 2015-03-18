From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 18 Mar 2015 18:00:04 +0100
Subject: [STLinux Kernel] [PATCH 2/6] pinctrl: st: Introduce a 'get pin
 function' call
In-Reply-To: <20150318165116.GR3318@x1>
References: <1426675899-19882-1-git-send-email-lee.jones@linaro.org>
 <1426675899-19882-3-git-send-email-lee.jones@linaro.org>
 <5509AAAB.8090906@st.com> <20150318165116.GR3318@x1>
Message-ID: <5509AF14.1060200@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/18/2015 05:51 PM, Lee Jones wrote:
> On Wed, 18 Mar 2015, Maxime Coquelin wrote:
>
>>
>> On 03/18/2015 11:51 AM, Lee Jones wrote:
>>> This call fetches the numerical function value a specified pin is
>>> currently operating in.  Function zero is more often than not the
>>> GPIO function.  Greater than zero values represent an alternative
>>> function.  You'd need to either look those up in the Device Tree
>>> sources or the Programmer's Manual.
>>>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>   drivers/pinctrl/pinctrl-st.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
>>> index 9e5ec00..5362e45 100644
>>> --- a/drivers/pinctrl/pinctrl-st.c
>>> +++ b/drivers/pinctrl/pinctrl-st.c
>>> @@ -460,6 +460,20 @@ static void st_pctl_set_function(struct st_pio_control *pc,
>>>   	regmap_field_write(alt, val);
>>>   }
>>> +static unsigned int st_pctl_get_pin_function(struct st_pio_control *pc, int pin)
>>> +{
>>> +	struct regmap_field *alt = pc->alt;
>>> +	unsigned int val;
>>> +	int offset = pin * 4;
>>> +
>>> +	if (!alt)
>>> +		return 0;
>> Shouldn't we print something if alt is NULL?
>> Else we can think we are on alternate 0.
> That is the assumption that I've made.  Is there isn't an alt, then a
> pin can only be on Alt-0.  Have I made the incorrect assumption here?
Just re-checked the code, and yes you are right.
No alt here means alt field of struct st_pctl_data is -1, which in turn 
means the register is not available.

You can forget my remark, and add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime

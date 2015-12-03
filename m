From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 03 Dec 2015 09:16:55 +0800
Subject: [PATCH v4 06/10] thermal: rockchip: consistently use int for
 temperatures
In-Reply-To: <20151203004903.GA9543@google.com>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
 <1447044542-30859-7-git-send-email-wxt@rock-chips.com>
 <20151202183851.GA91131@google.com> <565F8FFE.3080807@rock-chips.com>
 <20151203004903.GA9543@google.com>
Message-ID: <565F9807.4080700@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brain,

? 2015?12?03? 08:49, Brian Norris ??:
> Hi Caesar,
>
> On Thu, Dec 03, 2015 at 08:42:38AM +0800, Caesar Wang wrote:
>> ? 2015?12?03? 02:38, Brian Norris ??:
>>
>> [.....]
>>>   	if (thermal->tshut_temp > INT_MAX) {
>>>       CID 1341498:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
>>>       "thermal->tshut_temp > 2147483647 /* (int)(~0U >> 1) */" is always false regardless of the values of its operands. This occurs as the logical operand of if.
>>>
>>> I don't think this condition is even useful any more, so maybe we should
>>> just kill the 'if' block.
>> See the patch to fix
>> it.----->(https://patchwork.kernel.org/patch/7720601/)
>> <https://patchwork.kernel.org/patch/7720601/>
> -	if (thermal->tshut_temp > INT_MAX) {
> +	if (!(thermal->tshut_temp < INT_MAX)) {
>
> Huh? That still doesn't make much sense. The condition is still
> impossible, since thermal->tshut_temp is an int. You've just made it
> slightly harder for static analyzers to notice the impossibility.

Okay, that's possible remove this condition as you said.

- if (thermal->tshut_temp > INT_MAX) {
- dev_err(dev, "Invalid tshut temperature specified: %d\n",
- thermal->tshut_temp);
- return -ERANGE;
- }

Thanks!
>
>> This patch is merged into kernel 4.4-rc3.
> No it isn't, and I'm glad. The patch is silly.
>
> Brian
>
>
>

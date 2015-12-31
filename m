From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 31 Dec 2015 09:26:09 +0100
Subject: [PATCH] soc: mediatek: PMIC wrap: Clear the vldclr if state
 machine is stay on FSM_VLDCLR state.
In-Reply-To: <1451527755.20140.6.camel@mtksdaap41>
References: <1450770677-13557-1-git-send-email-henryc.chen@mediatek.com>
 <56841C41.4040901@gmail.com> <1451527755.20140.6.camel@mtksdaap41>
Message-ID: <5684E6A1.8050204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 31/12/15 03:09, Henry Chen wrote:
> Hi Matthias,
>
> On Wed, 2015-12-30 at 19:02 +0100, Matthias Brugger wrote:
>>
>> On 22/12/15 08:51, Henry Chen wrote:
>>> Sometimes PMIC is too busy to send data in time to cause pmic wrap timeout,
>>> because pmic wrap is waiting for FSM_VLDCLR after finishing WACS2_CMD. It
>>> just return error when issue happened, so the state machine will stay on
>>> FSM_VLDCLR state when data send back later by PMIC and timeout again in next
>>> time because pmic wrap waiting for FSM_IDLE state at the begining of the
>>> read/write function.
>>>
>>> Clear the vldclr when timeout if state machine is stay on FSM_VLDCLR.
>>>
>>> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
>>> ---
>>>    drivers/soc/mediatek/mtk-pmic-wrap.c | 16 ++++++++++++++--
>>>    1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> index 105597a..ccd5337 100644
>>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> @@ -443,10 +443,16 @@ static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
>>>    static int pwrap_write(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
>>>    {
>>>    	int ret;
>>> +	u32 val;
>>>
>>>    	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
>>> -	if (ret)
>>> +	if (ret) {
>>> +		/* Clear vldclr bit if state is on the WACS_FSM_WFVLDCLR */
>>> +		val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
>>> +		if (PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR)
>>> +			pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
>>>    		return ret;
>>> +	}
>>
>> I would prefer to have this encapsulated in a (inline) function. Maybe
>> with better description then just the one line comment.
>>
>> Thanks,
>> Matthias
>
> Ok, I will make the description more clear, do you means write the
> function like below and used it on pwrap_write/pwrap_read.
>
> static inline void pwrap_leave_fsm_vldclr(struct pmic_wrapper *wrp)
> {
> 	if (pwrap_is_fsm_vldclr(wrp))
> 		pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
> }
>

I didn't remind of pwrap_is_fsm_vldclr neither, nice.
Yes please use this function and add a descriptive comment on the top, 
so that in the future it is clear what is happening here.

Thanks,
Matthias

>
> Thanks,
> Henry
>
>>
>>>
>>>    	pwrap_writel(wrp, (1 << 31) | ((adr >> 1) << 16) | wdata,
>>>    			PWRAP_WACS2_CMD);
>>> @@ -457,10 +463,16 @@ static int pwrap_write(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
>>>    static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>>>    {
>>>    	int ret;
>>> +	u32 val;
>>>
>>>    	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
>>> -	if (ret)
>>> +	if (ret) {
>>> +		/* Clear vldclr bit if state is on the WACS_FSM_WFVLDCLR */
>>> +		val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
>>> +		if (PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR)
>>> +			pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
>>>    		return ret;
>>> +	}
>>>
>>>    	pwrap_writel(wrp, (adr >> 1) << 16, PWRAP_WACS2_CMD);
>>>
>>>
>
>

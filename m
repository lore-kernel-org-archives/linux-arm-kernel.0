From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 13 Apr 2018 12:09:35 +0100
Subject: [PATCH v2 1/2] dmaengine: stm32-mdma: align TLEN and buffer
 length on burst
In-Reply-To: <22bd0af7-9820-57c5-9215-8185839d7d27@st.com>
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
 <1523457879-9869-2-git-send-email-pierre-yves.mordret@st.com>
 <9a2a267c-2b0b-0d6a-c762-47e7d37f84ea@arm.com>
 <22bd0af7-9820-57c5-9215-8185839d7d27@st.com>
Message-ID: <7ab2cfcd-07ed-e380-727a-727e78cc0336@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/18 10:45, Pierre Yves MORDRET wrote:
> Hi Robin
> 
> On 04/11/2018 05:14 PM, Robin Murphy wrote:
>> On 11/04/18 15:44, Pierre-Yves MORDRET wrote:
>>> Both buffer Transfer Length (TLEN if any) and transfer size have to be
>>> aligned on burst size (burst beats*bus width).
>>>
>>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>>> ---
>>>     Version history:
>>>       v1:
>>>          * Initial
>>>       v2:
>>> ---
>>> ---
>>>    drivers/dma/stm32-mdma.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
>>> index daa1602..fbcffa2 100644
>>> --- a/drivers/dma/stm32-mdma.c
>>> +++ b/drivers/dma/stm32-mdma.c
>>> @@ -413,7 +413,7 @@ static u32 stm32_mdma_get_best_burst(u32 buf_len, u32 tlen, u32 max_burst,
>>>    	u32 best_burst = max_burst;
>>>    	u32 burst_len = best_burst * width;
>>>    
>>> -	while ((burst_len > 0) && (tlen % burst_len)) {
>>> +	while ((burst_len > 0) && (((tlen | buf_len) & (burst_len - 1)) != 0)) {
>>>    		best_burst = best_burst >> 1;
>>>    		burst_len = best_burst * width;
>>>    	}
>>
>> FWIW, doesn't that whole loop come down to just:
>>
>> 	burst_len = min(ffs(tlen | buf_len), max_burst * width);
> 
> No sure it ends as expected. or I miss something or don't understand this statement
> I tried with "relevant value" : i.e. best_burst = 32, Tlen=128(default) and
> buf_len = 64, width= 4. This statements gets me something wrong output => 7
> instead of 16 * 4.
> I doubt :)

Heh, seems I confused myself halfway through and started thinking 
max_burst and width were the exponents x rather than the values 2^x...

A more representative guess should be:

	min(1 << __ffs(tlen | buf_len), max_burst * width);

but the general point I was trying to make is that a loop checking 
whether the bottom n bits of something are zero for different values of 
n is unnecessary when n can simply be calculated directly*.

Robin.


* in the case of this "just the lowest set bit" idiom there's also the 
shift-free ((x & (x - 1)) ^ x), but as well as being unreadable it's 
generally less efficient than (1 << __ffs(x)) for most modern ISAs.

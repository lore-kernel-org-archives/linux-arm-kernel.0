From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Tue, 17 Oct 2017 16:35:13 +0200
Subject: [PATCH] i2c: stm32: Fixes multibyte transfer for STM32F4 I2C
 controller
In-Reply-To: <CAFvLkMS9Q801biCBYp+fJeiOo22zr436Td43PH3GG8E6diSL3A@mail.gmail.com>
References: <1507722788-31224-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <990c3275-35b3-68da-453c-d1a80e867df7@st.com>
 <CAFvLkMS6+o3D88Rj23of56KtjonwFAVD_aEP3eWaA2H=U5WP4Q@mail.gmail.com>
 <2d892fec-0496-8a6f-51c9-439b933d9975@st.com>
 <CAFvLkMS9Q801biCBYp+fJeiOo22zr436Td43PH3GG8E6diSL3A@mail.gmail.com>
Message-ID: <b24d9699-a88d-6a83-ceaf-140ea8b4db97@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/17/2017 03:51 PM, Rados?aw Pietrzyk wrote:
> I can try of course but it means that any IRQ delay may cause the same
> problem so the question is whether the driver should be vulnerable to
> such use cases.
> 

I may or ... may or not. If those patches don't find effectiveness at your side
I will have to look at it closer.
Nonetheless I prefer to start from something more stable in term of clock before
investigating further.

Please let me know

Regards
> 2017-10-17 15:18 GMT+02:00 Pierre Yves MORDRET <pierre-yves.mordret@st.com>:
>>
>>
>> On 10/12/2017 11:55 AM, Rados?aw Pietrzyk wrote:
>>> It looks like there is a use case when IRQ handler is delayed a bit
>>> and the logic in the driver does not work. What is the real root cause
>>> I don't know.
>>>
>>
>> As far as I know on this STM32 F4 platform there is some trouble with timer
>> events that may have bad influences on scheduling. Some tasks could be delayed
>> for some reasons.
>> It would be great if the following patches below could help in your matter
>> https://patchwork.kernel.org/patch/9980961/
>> https://patchwork.kernel.org/patch/9980963/
>> https://patchwork.kernel.org/patch/9980965/
>> https://patchwork.kernel.org/patch/9980967/
>>
>> Would you mind to test those ?
>> Thanks
>>
>>> 2017-10-12 11:31 GMT+02:00 Pierre Yves MORDRET <pierre-yves.mordret@st.com>:
>>>>
>>>>
>>>> On 10/11/2017 01:53 PM, Radoslaw Pietrzyk wrote:
>>>>>       Do not read data on RXNE but on BTF only due to HW
>>>>>       synchronisation problems and NACKing read data too early.
>>>>>       It was found during testing of stmpe811 touchscreen driver.
>>>>>
>>>>
>>>> Would you mind to explain what is behind "hw sync issue" you've seen ?
>>>>
>>>>> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
>>>>> ---
>>>>>  drivers/i2c/busses/i2c-stm32f4.c | 11 +----------
>>>>>  1 file changed, 1 insertion(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
>>>>> index 4ec1084..86bcf4c 100644
>>>>> --- a/drivers/i2c/busses/i2c-stm32f4.c
>>>>> +++ b/drivers/i2c/busses/i2c-stm32f4.c
>>>>> @@ -409,16 +409,9 @@ static void stm32f4_i2c_handle_read(struct stm32f4_i2c_dev *i2c_dev)
>>>>>        * So, here we just disable buffer interrupt in order to avoid another
>>>>>        * system preemption due to RX not empty event.
>>>>>        */
>>>>> -     case 2:
>>>>> -     case 3:
>>>>> +     default:
>>>>>               stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
>>>>>               break;
>>>>> -     /*
>>>>> -      * For N byte reception with N > 3 we directly read data register
>>>>> -      * until N-2 data.
>>>>> -      */
>>>>> -     default:
>>>>> -             stm32f4_i2c_read_msg(i2c_dev);
>>>>>       }
>>>>>  }
>>>>>
>>>>> @@ -470,8 +463,6 @@ static void stm32f4_i2c_handle_rx_done(struct stm32f4_i2c_dev *i2c_dev)
>>>>>                */
>>>>>               reg = i2c_dev->base + STM32F4_I2C_CR1;
>>>>>               stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
>>>>> -             stm32f4_i2c_read_msg(i2c_dev);
>>>>> -             break;
>>>>>       default:
>>>>>               stm32f4_i2c_read_msg(i2c_dev);
>>>>>       }
>>>>>

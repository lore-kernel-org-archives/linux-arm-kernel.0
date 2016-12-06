From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 6 Dec 2016 09:10:59 +0800
Subject: [resend v2: PATCH 1/2] dt-bindings: Document the hi3660 reset
 bindings
In-Reply-To: <5982682.vMJxVociDa@wuerfel>
References: <1480553321-17400-1-git-send-email-zhangfei.gao@linaro.org>
 <3900806.3NUubBDb0Q@wuerfel>
 <e15e76e2-b32d-a4d0-eb8b-850626a3946a@linaro.org>
 <5982682.vMJxVociDa@wuerfel>
Message-ID: <a9db0c7f-7cd5-5cde-dfa9-77fa4ad55385@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd


On 2016?12?02? 20:32, Arnd Bergmann wrote:
> On Friday, December 2, 2016 8:21:33 AM CET zhangfei wrote:
>> Hi, Arnd
>>
>> On 2016?12?01? 20:05, Arnd Bergmann wrote:
>>> On Thursday, December 1, 2016 8:48:40 AM CET Zhangfei Gao wrote:
>>>> +               hisi,reset-bits = <0x20 0x8             /* 0: i2c0 */
>>>> +                                  0x20 0x10            /* 1: i2c1 */
>>>> +                                  0x20 0x20            /* 2: i2c2 */
>>>> +                                  0x20 0x8000000>;     /* 3: i2c6 */
>>>> +       };
>>>> +
>>>> +Specifying reset lines connected to IP modules
>>>> +==============================================
>>>> +example:
>>>> +
>>>> +        i2c0: i2c at ..... {
>>>> +                ...
>>>> +               resets = <&iomcu_rst 0>;
>>>> +                ...
>>>> +        };
>>> I don't really like this approach, since now the information is
>>> in two places. Why not put the data into the reset specifier
>>> directly when it is used?
>> Any example, still not understand.
>> They are consumer and provider.
> I mean in the i2c node, have
>
> 	i2c0: i2c at ..... {
> 		...
> 		resets = <&iomcu_rst 0x20 0x8>;
> 		...
> }
Got it.
There is function of_xlate in reset_controller_dev can parse the dts
when devm_reset_control_get

* @of_xlate: translation function to translate from specifier as found 
in the
*            device tree to id as given to the reset control ops

Will use this instead.

>>> Also the format seems a little too close to the actual register
>>> layout and could be a little more abstract, using bit numbers instead
>>> of a bitmask and register numbers instead of offsets.
>> We use bit numbers first.
>> But in the developing process, we found several bits may be required for
>> one driver.
>> And they may not be continuous as the bits may already be occupied.
>> Directly using offset, we can set several bits together for simple, to
>> give more flexibility.
>> So after discussion, we directly use offset.
> Can you give an example for why this is needed? Is this different
> from a device that has multiple reset lines?
Yes, we can use multiple reset lines, which is also our original method.
But it may have too many reset lines, like pcie driver will have 5 resets.
So just thinking it can be optimized.

However, when using of_xlate, parsing offset & bit to rstc->id (unsigned 
int),
It only support u32, so will use bit numbers again.
rstc_id = rcdev->of_xlate(rcdev, &args);

Will update v3 patch, help take a look.

Thanks

From: paweljarosz3691@gmail.com (=?UTF-8?Q?Pawe=c5=82_Jarosz?=)
Date: Sat, 1 Oct 2016 21:59:42 +0200
Subject: [PATCH] ARM: dts: rockchip: Reserve unusable memory region on
 rk3066
In-Reply-To: <6962779.A926KxJite@phil>
References: <20161001140939.GA31220@vaio-ubuntu>
 <20161001181711.GB17554@remoulade> <6962779.A926KxJite@phil>
Message-ID: <799e2fe9-36ac-6f95-7422-f8d834f2d2ec@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
main symptom is complete system freeze.
With CONFIG_MEMTEST enabled and with passed "memtest" to the kernel all 
tests run ok.
But when i run command for example "memtester 800M" or simple "apt 
update" freeze happening.
And when i reserve this region in dts, board is stable again.

Thanks,
Pawel

W dniu 01.10.2016 o 21:18, Heiko Stuebner pisze:
> Am Samstag, 1. Oktober 2016, 19:17:11 CEST schrieb Mark Rutland:
>> Hi,
>>
>> On Sat, Oct 01, 2016 at 04:09:39PM +0200, =?UTF-8?q?Pawe=C5=82=20Jarosz?=
> wrote:
>>> For some reason accessing memory region above 0xfe000000 freezes
>>> system on rk3066. There is similiar bug on later rockchip soc (rk3288)
>>> solved same way.
>>>
>>> Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
>>> ---
>>>
>>>   arch/arm/boot/dts/rk3066a.dtsi | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/rk3066a.dtsi
>>> b/arch/arm/boot/dts/rk3066a.dtsi index 0d0dae3..44c8956 100644
>>> --- a/arch/arm/boot/dts/rk3066a.dtsi
>>> +++ b/arch/arm/boot/dts/rk3066a.dtsi
>>> @@ -93,6 +93,19 @@
>>>
>>>   		};
>>>   	
>>>   	};
>>>
>>> +	reserved-memory {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		ranges;
>>> +		/*
>>> +		 * The rk3066 cannot use the memory area above 0x9F000000
>>> +		 * for some unknown reason.
>>> +		 */
>>> +		unusable at 9F000000 {
>>> +			reg = <0x9F000000 0x1000000>;
>>> +		};
>> I don't think this is a sane workaround, but it is at best difficult to
>> tell, given there's no reason given for why this memory is unusable.
>>
>> For instance, if bus accesses to this address hang, then this patch only
>> makes the hand less likely, since the kernel will still map the region (and
>> therefore the CPU can perform speculative accesses).
>>
>> Are issues with this memory consistently seen in practice?
>>
>> Can you enable CONFIG_MEMTEST and pass 'memtest' to the kernel, to determine
>> if the memory is returning erroneous values?
> just for the sake of completeness, on the rk3288 the issue was the dma not
> being able to access the specific memory region (interestingly also the last
> 16MB but of the 4GB area supported on the rk3288). So memory itself was ok,
> just dma access to it failed.
>
> We didn't find any other sane solution to limit the dma access in a general way
> at the time, so opted for just blocking the memory region (as it was similarly
> only
>
> In the patch above, the newly blocked area is in the middle of the two 1gb
> memory areas (0x60000000-0xa0000000-1, 0xa0000000-0xe0000000-1).
>
> Pavel, apart from Mark's CONFIG_MEMTEST request above could you also specifiy
> what type of error you see please?
>
>
> Thanks
> Heiko

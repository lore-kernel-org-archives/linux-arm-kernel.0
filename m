From: robherring2@gmail.com (Rob Herring)
Date: Tue, 04 Sep 2012 12:51:32 -0500
Subject: [PATCH 10/11] ARM: vexpress: Add config bus components and clocks
 to DTs
In-Reply-To: <1346773023.20599.15.camel@hornet>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-11-git-send-email-pawel.moll@arm.com>
 <5045FAEC.6030906@gmail.com> <1346763920.2605.81.camel@hornet>
 <504610B4.6060902@gmail.com> <1346773023.20599.15.camel@hornet>
Message-ID: <50463FA4.90106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2012 10:37 AM, Pawel Moll wrote:
> On Tue, 2012-09-04 at 15:31 +0100, Rob Herring wrote:
>> On 09/04/2012 08:05 AM, Pawel Moll wrote:
>>> On Tue, 2012-09-04 at 13:58 +0100, Rob Herring wrote:
>>>>> -			sysctl at 020000 {
>>>>> +			v2m_sysctl: sysctl at 020000 {
>>>>>  				compatible = "arm,sp810", "arm,primecell";
>>>>>  				reg = <0x020000 0x1000>;
>>>>> +				clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&v2m_osc_clk0>;
>>>>> +				clock-names = "refclk", "timclk", "apb_pclk";
>>>>
>>>> See Documentation/devicetree/bindings/arm/primecell.txt
>>>>
>>>> apb_pclk should be first in the list.
>>>
>>> Hm. Why, if you don't mind me asking? The amba_get_enable_pclk()
>>> explicitly asks for "apb_pclk" id:
>>
>> So apb_pclk is always in the same position in the list and I had to
>> define something. Clock names are supposed to be optional, so we have to
>> be able to identify which clock is the bus clock without the name.
> [snip]
>> You're getting lucky with how clk_get is implemented. The driver should
>> be more specific with which clock it wants if there is more than 1.
>> Perhaps we need a clk_get_by_index() function?
> 
> But the clocking framework doesn't know what "index", while it knows
> exactly what is "id" (string). How about making the clock names
> obligatory in the tree when there a node has more than one clock input?
> This sounds much simpler to me and seems to be in line with the clocking
> API. And the apb_pclk wouldn't have to be first/last/whatever.

I did say they are *supposed* to be optional, but the amba bus code
essentially makes them required. Ideally, Linux doesn't dictate what
goes in the dtb or not, but I don't have a problem if specific users of
the clock binding require the names.

Rob

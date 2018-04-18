From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Apr 2018 16:28:41 -0500
Subject: [PATCH v3 07/10] Documentation: dt-bindings: Add documents for
 PECI hwmon client drivers
In-Reply-To: <1f2a86ff-b902-1d1d-488a-807ac1dd20cc@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-8-jae.hyun.yoo@linux.intel.com>
 <20180416181423.t4vf7sugv6z3aw5h@rob-hp-laptop>
 <aee4e04c-885f-b1d8-9e85-9e741551342f@linux.intel.com>
 <287e0fd9-b631-2602-2785-7b8aaed7a6b9@linux.intel.com>
 <6ff697e8-cd20-e551-da13-b614cc39f900@linux.intel.com>
 <CAL_JsqLcxEnCOywTtU14G4=6A5m6G=KH3oi8m1VxKSEdxuv-ww@mail.gmail.com>
 <1f2a86ff-b902-1d1d-488a-807ac1dd20cc@linux.intel.com>
Message-ID: <CAL_JsqLpuNj4kQ8oXB0kxOsS7ww9Jk-oq4tJrroDKkLRTPrjSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 3:28 PM, Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
> On 4/18/2018 7:32 AM, Rob Herring wrote:
>>
>> On Tue, Apr 17, 2018 at 3:40 PM, Jae Hyun Yoo
>> <jae.hyun.yoo@linux.intel.com> wrote:
>>>
>>> On 4/16/2018 4:51 PM, Jae Hyun Yoo wrote:
>>>>
>>>>
>>>> On 4/16/2018 4:22 PM, Jae Hyun Yoo wrote:
>>>>>
>>>>>
>>>>> On 4/16/2018 11:14 AM, Rob Herring wrote:
>>>>>>
>>>>>>
>>>>>> On Tue, Apr 10, 2018 at 11:32:09AM -0700, Jae Hyun Yoo wrote:
>>>>>>>
>>>>>>>
>>>>>>> This commit adds dt-bindings documents for PECI cputemp and dimmtemp
>>>>>>> client
>>>>>>> drivers.
>>>>>>
>>>>>>
>>>>>>
>>>
>>> [...]
>>>
>>>>>>> +Example:
>>>>>>> +    peci-bus at 0 {
>>>>>>> +        #address-cells = <1>;
>>>>>>> +        #size-cells = <0>;
>>>>>>> +        < more properties >
>>>>>>> +
>>>>>>> +        peci-dimmtemp at cpu0 {
>>>>>>
>>>>>>
>>>>>>
>>>>>> unit-address is wrong.
>>>>>>
>>>>>
>>>>> Will fix it using the reg value.
>>>>>
>>>>>> It is a different bus from cputemp? Otherwise, you have conflicting
>>>>>> addresses. If that's the case, probably should make it clear by
>>>>>> showing
>>>>>> different host adapters for each example.
>>>>>>
>>>>>
>>>>> It could be the same bus with cputemp. Also, client address sharing is
>>>>> possible by PECI core if the functionality is different. I mean,
>>>>> cputemp and
>>>>> dimmtemp targeting the same client is possible case like this.
>>>>> peci-cputemp at 30
>>>>> peci-dimmtemp at 30
>>>>>
>>>>
>>>> Oh, I got your point. Probably, I should change these separate settings
>>>> into one like
>>>>
>>>> peci-client at 30 {
>>>>       compatible = "intel,peci-client";
>>>>       reg = <0x30>;
>>>> };
>>>>
>>>> Then cputemp and dimmtemp drivers could refer the same compatible
>>>> string.
>>>> Will rewrite it.
>>>>
>>>
>>> I've checked it again and realized that it should use function based node
>>> name like:
>>>
>>> peci-cputemp at 30
>>> peci-dimmtemp at 30
>>>
>>> If it use the same string like 'peci-client at 30', the drivers cannot be
>>> selectively enabled. The client address sharing way is well handled in
>>> PECI
>>> core and this way would be better for the future implementations of other
>>> PECI functional drivers such as crash dump driver and so on. So I'm going
>>> change the unit-address only.
>>
>>
>> 2 nodes at the same address is wrong (and soon dtc will warn you on
>> this). You have 2 potential options. The first is you need additional
>> address information in the DT if these are in fact 2 independent
>> devices. This could be something like a function number to use
>> something from PCI addressing. From what I found on PECI, it doesn't
>> seem to have anything like that. The 2nd option is you have a single
>> DT node which registers multiple hwmon devices. DT nodes and drivers
>> don't have to be 1-1. Don't design your DT nodes from how you want to
>> partition drivers in some OS.
>>
>> Rob
>>
>
> Please correct me if I'm wrong but I'm still thinking that it is
> possible. Also, I did compile it but dtc doesn't make a warning. Let me
> show an another use case which is similar to this case:

I did say *soon*. It's in dtc repo, but not the kernel copy yet.

> In arch/arm/boot/dts/aspeed-g5.dtsi
> [...]
> lpc_host: lpc-host at 80 {
>         compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
>         reg = <0x80 0x1e0>;
>         reg-io-width = <4>;
>
>         #address-cells = <1>;
>         #size-cells = <1>;
>         ranges = <0x0 0x80 0x1e0>;
>
>         lpc_ctrl: lpc-ctrl at 0 {
>                 compatible = "aspeed,ast2500-lpc-ctrl";
>                 reg = <0x0 0x80>;
>                 clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>                 status = "disabled";
>         };
>
>         lpc_snoop: lpc-snoop at 0 {
>                 compatible = "aspeed,ast2500-lpc-snoop";
>                 reg = <0x0 0x80>;
>                 interrupts = <8>;
>                 status = "disabled";
>         };
> }
> [...]
>
> This is device tree setting for LPC interface and its child nodes.
> LPC interface can be used as a multi-functional interface such as
> snoop 80, KCS, SIO and so on. In this use case, lpc-ctrl at 0 and
> lpc-snoop at 0 are sharing their address range from their individual
> driver modules and they can be registered quite well through both
> static dt or dynamic dtoverlay. PECI is also a multi-functional
> interface which is similar to the above case, I think.

This case too is poor design and should be fixed as well. Simply put,
you can have 2 devices on a bus at the same address without some sort
of mux or arbitration device in the middle. If you have a device/block
with multiple functions provided to the OS, then it is the OS's
problem to arbitrate access. It is not a DT problem because OS's can
vary in how they handle that both from OS to OS and over time.

Rob

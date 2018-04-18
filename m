From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Apr 2018 09:32:36 -0500
Subject: [PATCH v3 07/10] Documentation: dt-bindings: Add documents for
 PECI hwmon client drivers
In-Reply-To: <6ff697e8-cd20-e551-da13-b614cc39f900@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-8-jae.hyun.yoo@linux.intel.com>
 <20180416181423.t4vf7sugv6z3aw5h@rob-hp-laptop>
 <aee4e04c-885f-b1d8-9e85-9e741551342f@linux.intel.com>
 <287e0fd9-b631-2602-2785-7b8aaed7a6b9@linux.intel.com>
 <6ff697e8-cd20-e551-da13-b614cc39f900@linux.intel.com>
Message-ID: <CAL_JsqLcxEnCOywTtU14G4=6A5m6G=KH3oi8m1VxKSEdxuv-ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 3:40 PM, Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
> On 4/16/2018 4:51 PM, Jae Hyun Yoo wrote:
>>
>> On 4/16/2018 4:22 PM, Jae Hyun Yoo wrote:
>>>
>>> On 4/16/2018 11:14 AM, Rob Herring wrote:
>>>>
>>>> On Tue, Apr 10, 2018 at 11:32:09AM -0700, Jae Hyun Yoo wrote:
>>>>>
>>>>> This commit adds dt-bindings documents for PECI cputemp and dimmtemp
>>>>> client
>>>>> drivers.
>>>>
>>>>
>
> [...]
>
>>>>> +Example:
>>>>> +    peci-bus at 0 {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +        < more properties >
>>>>> +
>>>>> +        peci-dimmtemp at cpu0 {
>>>>
>>>>
>>>> unit-address is wrong.
>>>>
>>>
>>> Will fix it using the reg value.
>>>
>>>> It is a different bus from cputemp? Otherwise, you have conflicting
>>>> addresses. If that's the case, probably should make it clear by showing
>>>> different host adapters for each example.
>>>>
>>>
>>> It could be the same bus with cputemp. Also, client address sharing is
>>> possible by PECI core if the functionality is different. I mean, cputemp and
>>> dimmtemp targeting the same client is possible case like this.
>>> peci-cputemp at 30
>>> peci-dimmtemp at 30
>>>
>>
>> Oh, I got your point. Probably, I should change these separate settings
>> into one like
>>
>> peci-client at 30 {
>>      compatible = "intel,peci-client";
>>      reg = <0x30>;
>> };
>>
>> Then cputemp and dimmtemp drivers could refer the same compatible string.
>> Will rewrite it.
>>
>
> I've checked it again and realized that it should use function based node
> name like:
>
> peci-cputemp at 30
> peci-dimmtemp at 30
>
> If it use the same string like 'peci-client at 30', the drivers cannot be
> selectively enabled. The client address sharing way is well handled in PECI
> core and this way would be better for the future implementations of other
> PECI functional drivers such as crash dump driver and so on. So I'm going
> change the unit-address only.

2 nodes at the same address is wrong (and soon dtc will warn you on
this). You have 2 potential options. The first is you need additional
address information in the DT if these are in fact 2 independent
devices. This could be something like a function number to use
something from PCI addressing. From what I found on PECI, it doesn't
seem to have anything like that. The 2nd option is you have a single
DT node which registers multiple hwmon devices. DT nodes and drivers
don't have to be 1-1. Don't design your DT nodes from how you want to
partition drivers in some OS.

Rob

From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu, 12 Apr 2018 12:51:10 -0700
Subject: [PATCH v3 09/10] drivers/hwmon: Add PECI hwmon client drivers
In-Reply-To: <20180412173714.GA13496@roeck-us.net>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-10-jae.hyun.yoo@linux.intel.com>
 <20180410222800.GA8484@roeck-us.net>
 <637d7812-e567-0bc2-4f08-fbdca0ee85d8@linux.intel.com>
 <292be2d9-e572-2e06-9899-f6c2c53fdefc@roeck-us.net>
 <7b378954-1ce8-a2d2-5d09-8b6b36c048be@linux.intel.com>
 <13d4c632-a20e-3c40-066a-1e9df02a0595@roeck-us.net>
 <89c8c847-87e7-a849-e05d-d32b787e9305@linux.intel.com>
 <20180412173714.GA13496@roeck-us.net>
Message-ID: <34c2c925-b62c-388b-d753-15fd4a821459@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2018 10:37 AM, Guenter Roeck wrote:
> On Thu, Apr 12, 2018 at 10:09:51AM -0700, Jae Hyun Yoo wrote:
> [ ... ]
>>>>>>>> +static int find_core_index(struct peci_cputemp *priv, int channel)
>>>>>>>> +{
>>>>>>>> +??? int core_channel = channel - DEFAULT_CHANNEL_NUMS;
>>>>>>>> +??? int idx, found = 0;
>>>>>>>> +
>>>>>>>> +??? for (idx = 0; idx < priv->gen_info->core_max; idx++) {
>>>>>>>> +??????? if (priv->core_mask & BIT(idx)) {
>>>>>>>> +??????????? if (core_channel == found)
>>>>>>>> +??????????????? break;
>>>>>>>> +
>>>>>>>> +??????????? found++;
>>>>>>>> +??????? }
>>>>>>>> +??? }
>>>>>>>> +
>>>>>>>> +??? return idx;
>>>>>>>
>>>>>>> What if nothing is found ?
>>>>>>>
>>>>>>
>>>>>> Core temperature group will be registered only when it detects at
>>>>>> least one core checked by check_resolved_cores(), so
>>>>>> find_core_index() can be called only when priv->core_mask has a
>>>>>> non-zero value. The 'nothing is found' case will not happen.
>>>>>>
>>>>> That doesn't guarantee a match. If what you are saying is correct
>>>>> there should always be
>>>>> a well defined match of channel -> idx, and the search should be
>>>>> unnecessary.
>>>>>
>>>>
>>>> There could be some disabled cores in the resolved core mask bit
>>>> sequence also it should remove indexing gap in channel numbering so it
>>>> is the reason why this search function is needed. Well defined match of
>>>> channel -> idx would not be always satisfied.
>>>>
>>> Are you saying that each call to the function, with the same parameters,
>>> can return a different result ?
>>>
>>
>> No, the result will be consistent. After reading the priv->core_mask once in
>> check_resolved_cores(), the value will not be changed. I'm saying about this
>> case, for example if core number 2 is unresolved in total 4 cores, then the
>> idx order will be '0, 1, 3' but channel order will be '5, 6, 7' without
>> making any indexing gap.
>>
> 
> And you yet you claim that this is not well defined ? Or are you concerned
> about the amount of memory consumed by providing an array for the mapping ?
> 
> Note that an indexing gap is acceptable and, in many cases, preferred.
> 

If the indexing gap is acceptable, the index search function isn't 
needed anymore. I'll fix all relating code to make that use direct 
mapping of channel -> idx then. Thanks!

> [ ... ]
> 
>>>>>>>> +
>>>>>>>> +??? dev_dbg(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev),
>>>>>>>> priv->name);
>>>>>>>> +
>>>>>
>>>>> Why does this message display the device name twice ?
>>>>>
>>>>
>>>> For an example, dev_name(hwmon_dev) shows 'hwmon5' and priv->name shows
>>>> 'peci-cputemp0'.
>>>>
>>> And dev_dbg() shows another device name. So you'll have something like
>>>
>>> peci-cputemp0: hwmon5: sensor 'peci-cputemp0'
>>>
>>
>> Practically it shows like
>>
>> peci-cputemp 0-30:00: hwmon10: sensor 'peci_cputemp.cpu0'
>>
>> where 0-30:00 is assigned by peci core.
>>
> 
> And what message would you see for cpu1 ?
> 

It shows like

peci-cputemp 0-31:00: hwmon10: sensor 'peci_cputemp.cpu1'

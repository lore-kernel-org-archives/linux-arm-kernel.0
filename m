From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 13 Jul 2018 13:51:31 +0100
Subject: RFC: tegra2/tegra3 automotive part changes
In-Reply-To: <8f050541-6b4c-34ed-2462-066313156180@nvidia.com>
References: <3916c0ea-964e-42ab-8bfd-8e8edc5110ee@codethink.co.uk>
 <fecd5597-1b04-6409-b87c-5cda54d43ce0@wwwdotorg.org>
 <4f215c76-6539-1130-6c1f-75f0a3df068a@codethink.co.uk>
 <8f050541-6b4c-34ed-2462-066313156180@nvidia.com>
Message-ID: <9c0ee90e-6608-e57c-aba7-3feccde33b29@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/07/18 10:58, Jon Hunter wrote:
> 
> On 13/07/18 10:41, Ben Dooks wrote:
>> On 12/07/18 16:56, Stephen Warren wrote:
>>> On 07/12/2018 07:36 AM, Ben Dooks wrote:
>>>> Hello, we are looking at up-streaming some of the work we have
>>>> done on the tegra2 and tegra3 automotive devices. The automotive
>>>> grade devices are close the commercial parts so we would like to
>>>> discuss the core changes before submitting.
>>>>
>>>> The changes are mostly with things like the clock setup and a
>>>> few peripheral quirks (IIRC these are mostly MMC).
>>>>
>>>> We are proposing to change the device-tree properties for the root
>>>> node and any other affected devices from "nvidia,tegraXX" to a new
>>>> "nvidia,tegraXXa". We would welcome discussion on whether to update
>>>> all the devices at the start
>>>>
>>>> An example of tegra30a.dtsi:
>>>>
>>>> #include "tegra30.dtsi"
>>>>
>>>> / {
>>>>  ???????? compatible = "nvidia,tegra30a";
>>>>
>>>>  ???????? clock at 60006000 {
>>>>  ???????????????? compatible = "nvidia,tegra30a-car";
>>>>  ???????? };
>>>> }
>>>
>>> This doesn't sound right. Auto and commercial parts are identical AFAIK; it's just qualification differences. Hence at most you'd add an extra compatible value and not remove the old one. Better might be to detect this at run-time from the fuses. I think we already do some of that already; search for speedo related code in arch/arm/mach-tegra/.
>>
>> The nvidia pdk for the automotive didn't set the clocks up in the
>> same way and we where told that there are certain clock restrictions
>> for the automotive parts that the commercial ones do not have. Some of
>> this came from internal discussions with nvidia and NDA'd datasheets
>> so I don't know how much actual data I can share.
>>
>> To get the 4.4 kernel to be similar enough to work with the tegra30a
>> we had to do some changes to the clock initialisation. For things
>> like the clock I am not sure if leaving a tegra30-car in there would
>> be a good idea, it may boot but probably won't be stable.
>>
>> For the fuses, is the fuse driver up early enough to allow the clock
>> driver could use this? otherwise I think the device-tree change would
>> be the only way. I'm not sure if I have the information to hand on
>> how to differentiate the tegra30 and tegra20.
> 
> It should be, if you see drivers/soc/tegra/fuse/fuse-tegra.c there is an
> 'early_initcall(tegra_init_fuse)' and there is a 'tegra_fuse_read_early()'
> function that can be used.

Ok, I've tried looking through all the data-sheets I have and I can't
find any data on which fuse-bits would be needed to identify the two
versions. Does anyone else know where to look?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

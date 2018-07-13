From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Jul 2018 10:53:43 -0600
Subject: RFC: tegra2/tegra3 automotive part changes
In-Reply-To: <4f215c76-6539-1130-6c1f-75f0a3df068a@codethink.co.uk>
References: <3916c0ea-964e-42ab-8bfd-8e8edc5110ee@codethink.co.uk>
 <fecd5597-1b04-6409-b87c-5cda54d43ce0@wwwdotorg.org>
 <4f215c76-6539-1130-6c1f-75f0a3df068a@codethink.co.uk>
Message-ID: <c8d947bb-a790-56f4-8ab4-2259f736d445@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2018 03:41 AM, Ben Dooks wrote:
> On 12/07/18 16:56, Stephen Warren wrote:
>> On 07/12/2018 07:36 AM, Ben Dooks wrote:
>>> Hello, we are looking at up-streaming some of the work we have
>>> done on the tegra2 and tegra3 automotive devices. The automotive
>>> grade devices are close the commercial parts so we would like to
>>> discuss the core changes before submitting.
>>>
>>> The changes are mostly with things like the clock setup and a
>>> few peripheral quirks (IIRC these are mostly MMC).
>>>
>>> We are proposing to change the device-tree properties for the root
>>> node and any other affected devices from "nvidia,tegraXX" to a new
>>> "nvidia,tegraXXa". We would welcome discussion on whether to update
>>> all the devices at the start
>>>
>>> An example of tegra30a.dtsi:
>>>
>>> #include "tegra30.dtsi"
>>>
>>> / {
>>> ???????? compatible = "nvidia,tegra30a";
>>>
>>> ???????? clock at 60006000 {
>>> ???????????????? compatible = "nvidia,tegra30a-car";
>>> ???????? };
>>> }
>>
>> This doesn't sound right. Auto and commercial parts are identical 
>> AFAIK; it's just qualification differences. Hence at most you'd add an 
>> extra compatible value and not remove the old one. Better might be to 
>> detect this at run-time from the fuses. I think we already do some of 
>> that already; search for speedo related code in arch/arm/mach-tegra/.
> 
> The nvidia pdk for the automotive didn't set the clocks up in the
> same way and we where told that there are certain clock restrictions
> for the automotive parts that the commercial ones do not have. Some of
> this came from internal discussions with nvidia and NDA'd datasheets
> so I don't know how much actual data I can share.

I believe this just changes the *selection* of values to use (clock 
rates, clock sources), not *how* to program them (set of registers and 
fields, programming algorithm), which is what the DT compatible is 
mainly about. In other words, it's mainly a performance/configuration 
decision not different HW.

> To get the 4.4 kernel to be similar enough to work with the tegra30a
> we had to do some changes to the clock initialisation. For things
> like the clock I am not sure if leaving a tegra30-car in there would
> be a good idea, it may boot but probably won't be stable.
> 
> For the fuses, is the fuse driver up early enough to allow the clock
> driver could use this? otherwise I think the device-tree change would
> be the only way. I'm not sure if I have the information to hand on
> how to differentiate the tegra30 and tegra20.
> 
> PS, we'll want to do the same for the tegra20.

As Job mentioned, the fuse driver should/could be available early enough 
without issue. It may have to (and probably already does) hard-code the 
physical address of the fuses rather than being configured from DT for 
this. I think if you read the chip "SKU" value from fuses, that should 
indicate which sets of restrictions on clocks/... are required, and 
there are many more SKUs than just "regular" and "automotive", although 
all the different SKUs may be bucketed into fewer sets of 
restriction/configuration data.

Briefly looking at drivers/soc/tegra/fuse/speedo-tegra20.c, some (a very 
little) of this may already be there

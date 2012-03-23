From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Fri, 23 Mar 2012 10:32:32 -0400
Subject: ioremap to a specific virtual address
In-Reply-To: <201203231407.00686.arnd@arndb.de>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <alpine.LFD.2.02.1203230023060.24151@xanadu.home>
 <CAKON4Ox6sp5YMryr2jzOAqYNmJG9RyahLTusrHZ_jcNQ40DAfQ@mail.gmail.com>
 <201203231407.00686.arnd@arndb.de>
Message-ID: <CAKON4OzF9KV=51yAR2pVHJZNQsGDkXVhBwbn4njhZPRjeh=-dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 10:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 23 March 2012, jonsmirl at gmail.com wrote:
>> So there are two ways to build these mappings..
>>
>> 1) At init time. I can extract the 11 regions, dynamically build a
>> 'struct map_desc' and call iotable_init. Doing it at init time via the
>> device tree will work, but it is complicated by the existence of nodes
>> in the device tree that have their status set to disabled. The init
>> time code will need to sort this out which duplicates what the driver
>> load system does.
>
> There is nothing wrong with setting up the static mappings at boot
> time for all devices, you don't need to check whether they are actually
> present. I would assume that you have plenty of virtual address space
> on lpc31xx, given that those machines tend to come with rather little
> physical memory.
>
>> 2) Driver load time. This is why I asked the initial question about
>> how to do ioremap to the specific virtual address. I didn't want to
>> rewrite all of the existing code to use the more normal style of
>> mapping. So is there some way to create the static mapping at a
>> specific address when the driver first loads?
>>
>> Is there any real advantage to doing the mapping at init time other
>> than being able to control which virtual address you get?
>
> The main reason why we do it in a lot of drivers is to allow the
> drivers to be used across multiple platforms that have the devices
> at a different location. We will soon (for some definition of that
> term) have multiplatform kernels that can run e.g. on lpc31xx and
> lpc32xx, and those two families can have the same devices at a different
> memory location, or could have a different number of devices of
> the same kind.
>
> In particular, in order to enable the multiplatform kernel, we have
> to restrict access of device drivers to platform specific header file
> in all cases where those have conflicting contents.

Isn't this a symptom of not having device trees? If the devices are
identical the header files should be identical except for the base
address. The device tree allows you to get that base address out of
the header file.

Assuming that we can clear up the conflicts in the header files, then
wouldn't it make sense to use ioremap in the  driver, let it assign a
random address, and then fix my code to the base+offset model?


>> I can start looking at how much code needs to be converted to the base
>> + offset model. One advantage to converting is that I'll get an
>> immediate GPF each time I mess up. Converting the code will let it
>> work with the random address from ioremap.
>>
>> This is a NXP BSP for the lpc31xx from about three years ago. I've
>> forward ported it up to v3.3 and I want to get device tree going in
>> it. We have products based on this chip and I'd like to be able to
>> build a single kernel that works in all of the various configurations.
>
> I think you should work together with Roland Stigge, who is currently
> looking into doing the same for lpc32xx. My guess is that you can save
> a lot of work by combining your efforts, while you would get conflicting
> DT bindings if you don't. Note that Roland has done a lot of patches
> already for nxp device drivers that will be part of v3.4. He has not yet
> started on DT patches but wants to work on that for v3.5.

I will need to check how similar the chips actually are. NXP did not
use primecells in the lpc31xx family.

I'd be happy to have some help. My trees are here:
https://github.com/jonsmirl

I haven't pushed out my device tree support because it doesn't work
yet. Its about half finished. Roland, check out the SPL support in
u-boot for the lpc31xx.

>
> ? ? ? ?Arnd



-- 
Jon Smirl
jonsmirl at gmail.com

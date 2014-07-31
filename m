From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 31 Jul 2014 14:13:48 +0200
Subject: [RFC PATCH v3] edac: synps: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <20140731113324.GB4375@pd.tnic>
References: <9dc2a947-d2ab-4f00-8ed3-d2499cb6fdfd@BN1BFFO11FD002.protection.gbl>
 <20140731113324.GB4375@pd.tnic>
Message-ID: <808655a9-77eb-4e3a-9781-2b059ad9517b@BN1AFFO11FD020.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2014 01:33 PM, Borislav Petkov wrote:
> On Wed, Jul 30, 2014 at 03:41:47PM +0000, Punnaiah Choudary Kalluri wrote:
>>> So you're telling me that you want one edac driver for *two* memory
>>> controllers which can be present on a single system *at* *the* *same*
>>> *time*? Is that it?
>>
>> Yes.
> 
> Oh, this'll be fun. :-P

just to give me one more possible and more crazy example.
You can start system with one memory controller - then use partial
reconfiguration and add others at run time till you have enough pins
on your board. You can also remove it when you decide to do so.
And every boot can be different on the same board.


>>>
>>> How exactly is that topology supposed to look like, work, etc, etc? What
>>> kind of error reporting do you imagine you want to do with EDAC?
>>
>> Zynq (All programmable SOC) contains a dual core ARM cortex A9 based processing
>> System(PS) and Xilinx programmable logic(PL) in a single device.
>>
>> Assume the application is a broadcast camera. The design for this system use PS as
>> Control plane and use PL as data plane for processing the video data. So, the design 
>> may have two different memory controllers one in PS and another one in PL.   
>> PS is running with Linux OS and PL doesn't have the OS and it is  controlled by the 
>> OS running on PS.
> 
> Ok.
> 
>>  Now the requirement is to develop a monitoring system for all the
>> hardware failures Including ddr ecc errors. Since the broadcast camera
>> involves more data processing and DDR memory access, there is a high
>> probability of getting ddr ecc errors over the period.
> 
> So you're saying the camera has memory with ECC? People really pay
> attention on getting error free video frames? :-)
> 
> Or this is just an example? You're saying the PL will need ECC for some
> applications?

I believe that this is real example.
The another example can also be that Linux uses this PL memory with ECC
and PS memory for application because of whatever reason - speed for example.

But that configurations are real.

> 
>> So, the user should be intimated with these errors when they occur and if the error rate
>>  is high, then the user can consider the preventive methods. Without this error reporting
>> mechanism it is difficult to debug the issues like memory corruption, kernel oops which
>>  may occur due to ddr ecc failures.
>>
>> Since, the memory controllers are different, it need two edac drivers for reporting the ecc 
>> errors and also maintaining the statistics of that particular memory controller. With the current
>> framework, there is a chance that both the drivers get mc_num as zero and malfunction. 
>> Assume the code for the two drivers looks like below
>>
>> Driver 1:
>> 	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
>> 			    sizeof(struct  ctrl1_drvdata));
>>
>> Driver 2:
>> 	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
>> 			    sizeof(struct ctrl2_drvdata));
>>
>> Issue:
>>   Since driver is providing the mc_num to framework, now there is chance that only one device active as
>>  both the drivers claiming the same number.
>>
>> Solution 1:
>>  Keep two drivers in single file and use static global variable for tracking the mc_num. This solution looks
>> good but the drivers may not be generic as these driver would be in a zynq_edac.c file. So others may not
>> reuse these drivers
> 
> Ok, I think I know what you mean. And this architecture works just fine.
> On x86 we have one EDAC instance per memory controller so on a multinode
> machine with multiple memory controllers, we do edac_mc_alloc() per
> memory controller.
> 
> For examples, see amd64_edac::init_one_instance() and sb_edac should
> have this too. So you basically have a local array of instances which
> you allocate and setup.
> 
> If someone wants to reuse the driver, then we can talk about this later,
> when the time comes.
>
> For now I think you should put both PS and PL stuff in one file,
> zynq_edac or so.
> 
> Any issues with this design?

Mixing two drivers in the one file is not a good idea because with more
memory controllers it is just a mess and you are not able to cover all cases.

If this is just about providing uniq number we can easily extend binding
and provide that uniq value.
That's remind me solution with edac_mc_get_id() can caused that you won't have
exact number all the time - depends on driver loading (deferred probing too).

One option via DT can be via aliases where you can easily specify order.
But all of these issues can be solved in follow-up patch.

Thanks,
Michal

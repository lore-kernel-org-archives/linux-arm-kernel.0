From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 31 Jul 2014 11:33:18 +0200
Subject: [RFC PATCH v3] edac: synps: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <03CA77BA8AF6F1469AEDFBDA1322A7B74821CC98@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <03CA77BA8AF6F1469AEDFBDA1322A7B74821CC98@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <70b38686-5049-42a9-af87-b762b91e201e@BN1BFFO11FD018.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2014 05:41 PM, Punnaiah Choudary Kalluri wrote:
> Hi Boris,
> 
>> -----Original Message-----
>> From: Borislav Petkov [mailto:bp at alien8.de]
>> Sent: Monday, July 28, 2014 11:32 PM
>> To: Punnaiah Choudary Kalluri
>> Cc: Punnaiah Choudary Kalluri; dougthompson at xmission.com;
>> robh+dt at kernel.org; pawel.moll at arm.com; Michal Simek;
>> mark.rutland at arm.com; ijc+devicetree at hellion.org.uk; Kumar Gala; Rob
>> Landley; devicetree at vger.kernel.org; linux-doc at vger.kernel.org; linux-
>> edac at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
>> kernel at lists.infradead.org; Punnaiah Choudary; Anirudha Sarangi; Srikanth
>> Vemula
>> Subject: Re: [RFC PATCH v3] edac: synps: Added EDAC support for zynq ddr
>> ecc controller
>>
>> On Mon, Jul 28, 2014 at 10:53:26PM +0530, punnaiah choudary kalluri wrote:
>>> I can agree with you that we can use shorter names.But ZYNQ has
>>> programmable logic next to processing system where one can add soft
>>> memory controller in the same system and may use different driver. So,
>>> the edac driver for zynq may include multiple drivers for different
>>> memory controllers in the same file. In this case it is difficult to
>>> maintain generic macros as you suggested above.
>>
>> So?
>>
>> You can still shorten them a bit - the current names are awfully long.
>> SYNPS_DDRC_ECC_ is too much information, for example. We know it is DDR
>> and we know it is about ECC. So do SYNPS and ZYNQ or OTHER or whatever
>> you wanna call it prefix and then the rest. I.e.,
>>
>>    SYNPS_<reg>_<bits*>
>>    ZYNQ_<reg>_bits*>
>>
>> You can even use single letter prefixes like S_ and Z_ and add a comment
>> explaining what those mean. Still much more readable than the long
>> repeating prefixes currently.
> 
> Ok.
>>
>>> Also the current edac framework for edac memory controllers is
>>> expecting the mc_num from the driver while allocating the memory
>>> controller instance using the edac_mc_alloc function. This requirement
>>> mandates that if the system contains two different memory controllers
>>> then the corresponding edac drivers should be in single file.
>>
>> So you're telling me that you want one edac driver for *two* memory
>> controllers which can be present on a single system *at* *the* *same*
>> *time*? Is that it?
> 
> Yes.
>>
>> How exactly is that topology supposed to look like, work, etc, etc? What
>> kind of error reporting do you imagine you want to do with EDAC?
> 
> Zynq (All programmable SOC) contains a dual core ARM cortex A9 based processing
> System(PS) and Xilinx programmable logic(PL) in a single device.
> 
> Assume the application is a broadcast camera. The design for this system use PS as
> Control plane and use PL as data plane for processing the video data. So, the design 
> may have two different memory controllers one in PS and another one in PL.   
> PS is running with Linux OS and PL doesn't have the OS and it is  controlled by the 
> OS running on PS.
>  Now the requirement is to develop a monitoring system for all the hardware failures 
> Including ddr ecc errors. Since the broadcast camera involves more data processing and
> DDR memory access, there is a high probability of getting ddr ecc errors over the period.
> So, the user should be intimated with these errors when they occur and if the error rate
>  is high, then the user can consider the preventive methods. Without this error reporting
> mechanism it is difficult to debug the issues like memory corruption, kernel oops which
>  may occur due to ddr ecc failures.
> 
> Since, the memory controllers are different, it need two edac drivers for reporting the ecc 
> errors and also maintaining the statistics of that particular memory controller. With the current
> framework, there is a chance that both the drivers get mc_num as zero and malfunction. 
> Assume the code for the two drivers looks like below
> 
> Driver 1:
> 	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> 			    sizeof(struct  ctrl1_drvdata));
> 
> Driver 2:
> 	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> 			    sizeof(struct ctrl2_drvdata));
> 
> Issue:
>   Since driver is providing the mc_num to framework, now there is chance that only one device active as
>  both the drivers claiming the same number.
> 
> Solution 1:
>  Keep two drivers in single file and use static global variable for tracking the mc_num. This solution looks
> good but the drivers may not be generic as these driver would be in a zynq_edac.c file. So others may not
> reuse these drivers
> static int mc_num = 0;
> 
> Driver 1:
> 	mci = edac_mc_alloc(mc_num, ARRAY_SIZE(layers), layers,
> 			    sizeof(struct  ctrl1_drvdata));
>               mc_num++;
> 
> Driver 2:
> 	mci = edac_mc_alloc(mc_num, ARRAY_SIZE(layers), layers,
> 			    sizeof(struct ctrl2_drvdata));
>                  mc_num++;
> 
> Solution 2:
>   Let the framework assign the mc_num to the edac driver
> 
>      mc_num = edac_mc_get_id(); /* returns the next available mci slot */
>      mci = edac_mc_alloc(mc_num,...);
> 
> 
> In my opinion solution 2  looks neat and it eliminates the dependency on tracking
>  the mc_num.

Isn't there also 3rd option which is provide mc_num via DTS?

Thanks,
Michal

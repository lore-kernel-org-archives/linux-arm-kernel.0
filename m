From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 17 Aug 2012 10:09:05 +0000
Subject: [PATCH-V3] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
In-Reply-To: <20120817095851.GX11011@atomide.com>
References: <1343214422-28718-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1207251438210.23542@utopia.booyaka.com>
 <alpine.DEB.2.00.1207261359500.14468@utopia.booyaka.com>
 <20120814082911.GG11011@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA8F4CD@DBDE01.ent.ti.com>
 <20120817074934.GL11011@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA92062@DBDE01.ent.ti.com>
 <20120817084047.GN11011@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA9220D@DBDE01.ent.ti.com>
 <20120817095851.GX11011@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA922AA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2012 at 15:28:51, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120817 02:51]:
> > On Fri, Aug 17, 2012 at 14:10:47, Tony Lindgren wrote:
> > > * Hiremath, Vaibhav <hvaibhav@ti.com> [120817 01:22]:
> > > > On Fri, Aug 17, 2012 at 13:19:34, Tony Lindgren wrote:
> > > > > * Hiremath, Vaibhav <hvaibhav@ti.com> [120815 02:11]:
> > > > > > 
> > > > > > Somehow we have to have some mechanism to initialize " _mpu_rt_va" before 
> > > > > > core_init call, which will take DT resources and initialize accordingly.
> > > > > 
> > > > > That's for the device reset/idle? We should not do that in hwmod code
> > > > > except in late_initcall for unclaimed devices as discussed earlier. We
> > > > > discussed setting up the reset function in the device specific headers
> > > > > so both device and hwmod code can call them as needed.
> > > > 
> > > > May be I didn't understand your above statement, can you please elaborate 
> > > > more on "device specific header file"?
> > > 
> > > We should have the device drivers idle and reset the devices. But also
> > > hwmod may need to do that for the unclaimed devices for PM to work. 
> > > As the driver may not be even compiled in, the driver specific reset and
> > > idle functions should be static inline functions in the device specific
> > > header file so hwmod code can still call those.
> > >  
> > 
> > How about mapping the address of the devices?
> 
> That should be done based on the iorange coming from DT during the driver
> probe. The range in hwmod can be populated at that point too if needed.
>  

There will not be any driver probe for unclaimed devices, right? 

> > Some more thoughts on the similar line on unclaimed devices -
> > As par of late_initcall(), traverse all the DTB nodes and for each node with 
> > "state = disabled", we can do something like,
> > 
> > Late_initcall()
> > 	-> Traverse DTB nodes and check for "state = disabled"
> > 		-> Read the "ti,hwmod" entry and get offsets like, sys_config 
> > 		   and reset.
> > 		-> Map the base address
> > 		-> Enable the module/clock
> > 		-> Reset the device
> > 		-> Write to sysc register offset
> > 		-> Disable the module/clock
> > 
> > 
> > 
> > > > Just to highlight, its not only during late_initcall, the _enable and _idle 
> > > > functions are getting executed as part of every runtime_pm_get\put_sync from 
> > > > the driver.
> 
> Heh, but the unclaimed devices do not have a driver :) So there's no runtime_pm
> calls for the unclaimed devicdes.
> 

I think you mixed two responses here, this was not part of my last response.
Just only read above code execution steps, I think they still make sense and 
we may end up doing something similar.

> > At the current stage, I really think it would be really nice and beneficial 
> > for driver developers from the community if they get Linux Boot from 
> > linux-next/master branch. I have seen lot of community folks are struggling 
> > with it and they are blocked because we do not have booting kernel on 
> > BeagleBone.
> > They always end up patching kernel with HWMOD patch and submit the driver 
> > patches. So request to consider this cleanup as sequential patch on top of 
> > original HWMOD patch?
> 
> Yes I'm fine merging the data as is, just trying to figure out how to sort
> out the issues for future. 
>  

Thanks a lot Tony.
Paul, Care to add it in your next pull request.

> > > > May be get rid of resource overwriting for AM33xx and OMAP5 alone as of 
> > > > now??
> > > 
> > > Sorry I don't follow this part, care to explain a little more?
> > > 
> > 
> > As per current implementation, we are using HWMOD information to fill the 
> > platform_device->resources. Even if you pass "reg" and "interrupt" property 
> > from DT, omap_device layer overwrites it with HWMOD data information.
> > 
> > So what I am trying to propose here is, avoid this overwrite and resources 
> > (address and interrupt) should strictly gets used from DT blob. Since AM33xx 
> > and OMAP5 devices are the new devices and supports DT boot only, we can 
> > implement it easily for them.
> 
> Yes I agree. And then we should also drop the data from hwmod when it's no
> longer needed.
>  

Exactly, I will submit RFC for this.

> > Only issue her is, DMA resources, I was going through some of the old email 
> > archives today, submitted by Benoit and later Jon, but I am still not sure 
> > how to pass dma_channel to driver as a resource.
> 
> Hmm I thought that got merged already? 

No, atleast didn't find in 3.6-rc1.

> Anyways, the iorange and interrupts
> are standard resources that should exist in every device entry in .dts files.
> 

Agreed, I am submitting patch for this as well.

Thanks,
Vaibhav

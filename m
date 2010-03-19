From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri, 19 Mar 2010 10:15:14 +0530
Subject: QUERY: How to handle SOC Configuration (Peripheral	Multiplexing)
	in linux
In-Reply-To: <20100317163023.GF31126@trinity.fluff.org>
References: <4B9DB823.1040809@st.com>
	<20100315062041.GD31126@trinity.fluff.org>
	<4B9DDC61.3090609@st.com>
	<20100317163023.GF31126@trinity.fluff.org>
Message-ID: <4BA3015A.7020904@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/17/2010 10:00 PM, Ben Dooks wrote:
> On Mon, Mar 15, 2010 at 12:36:09PM +0530, Viresh KUMAR wrote:
>> Ben,
>>
>> On 3/15/2010 11:50 AM, Ben Dooks wrote:
>>>>> I have provided this selection from "make menuconfig", based on selection I
>>>>> configure hardware at initialization time. Basically these selections will
>>>>> decide which device is present in the system when it boots.
>>> This is really bad idea, what happens if you have a selection of
>>> boards with mutually-exclusive peripheral sets?
>>
>> In this case, we can have different defconfig files for different boards.
> 
> That is not acceptable, it makes life difficult for things like the
> autobuilder (more configurations to process), for people trying to
> package software distributions (each kernel requires a package, a set
> of modules, requiring time to build and space to store).
> 
> The configuration is known to the board initialisation code in the
> kernel, and thus it should be requesting a set of features from the
> core SoC implementation saying what it wants. This can then ensure
> that the configuration is mutually exclusive, ensure any resources
> such as GPIO are correctly configured, etc.
> 
> Note, currently the s3c2410_defconfig builds 123Mbyte of modules.
> Think about having m-machines' worth of those littering your development
> system.
>  
>>> Making these sorts of
>>> decisions at compile time is always a bad idea, it leaves people making
>>> distributitions a lot of extra work.
>>>
>>
>> I agree with this point but what is the other way for this.
>>
>> Doing this at runtime will have following issue:
>>
>> User have inserted a module and by mistake or lack of knowledge,
>> he disabled already working IP(due to multiplexing). Now with Kconfig concept 
>> this is taken care of at the beginning only. User can't select peripherals which
>> can't be enabled simultaneously.
> 
> Generally, all devices are registered at initialisation time. If there is
> the chance of dynamically loading drivers afterwards, either you'll have
> to do one of the following:
> 
> 1) Change the driver to call the SoC code in the probe() code to ensure
>    that it can get the required SoC resources
> 
> 2) Ensure the board has reseved the SoC resources for the device at start
>    time
> 
> Note, also unless you have very specific modules, your Kconfig approach
> will break down if you forget to update the root-fs when changing the
> kernel, otherwise modules you can't load will be left around.
> 
> Generally, runtime controls are much better than build time.
> 

Thanks guys.
All of you gave great inputs, this discussion helped me a lot.

This is what I understood,
1. Mux config decision must be done at run time.
2. Mux config will be board dependent.
3. Mux config should be one time and should be discouraged to be done again as this
can cause board failures or more power consumption. 

thanks,
viresh kumar.

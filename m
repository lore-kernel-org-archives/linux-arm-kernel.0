From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 12 Oct 2012 13:45:48 +0800
Subject: [PATCH] i2c: change the id to let the i2c device work
In-Reply-To: <20121012051419.GJ11726@opensource.wolfsonmicro.com>
References: <1350009258-10044-1-git-send-email-voice.shen@atmel.com>
 <20121012044042.GI11726@opensource.wolfsonmicro.com>
 <5077A33E.4080801@atmel.com>
 <20121012051419.GJ11726@opensource.wolfsonmicro.com>
Message-ID: <5077AE8C.5040605@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2012 13:14, Mark Brown wrote:
> On Fri, Oct 12, 2012 at 12:57:34PM +0800, Bo Shen wrote:
>> On 10/12/2012 12:40, Mark Brown wrote:
>>> On Fri, Oct 12, 2012 at 10:34:18AM +0800, Bo Shen wrote:
>
>>>> As the old method will use platform device id, change the id to
>>>> let the i2c device work
>
>>> What are "the old method" and new method?  You're not explaining why
>>> this is needed...
>
>> Maybe use the 'legacy method' will be better (I am not sure). Now,
>> the Linux kernel is transferring to device tree which doesn't use
>> platform device id. So, change the id to let the legacy code work.
>
>> May you understand.
>
> No, this still makes no sense to me.  This is clearly a non-DT device
> registration, what does DT have to do with anything here?  What is the

Yes, this is non-DT device registration.
As the Linux kernel code is transferring to DT which doesn't use 
platform device id. however here, modified unconsciously. So correct 
this error.

> practical problem you are seeing in your system and how does this help
> with it?

In non-DT kernel, we use platform device id to distinguish between each 
device.

For example,
if register i2c device on i2c bus 0, using:
   i2c_register_board_info(0, ...)
if register i2c device on i2c bus 1, using:
   i2c_register_board_info(1, ...)

So, in this case, if the id = -1, i2c core will dynamically assign a bus 
id to this bus when running, the dynamically assigned bus id is unknown 
when writing the code. So, when we use i2c_register_board_info(int 
busnum, ...) to register device on busnum. we don't know which value to 
be use.

So, this patch will fix this issue.


BRs,
Bo Shen

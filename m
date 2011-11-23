From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 22 Nov 2011 19:48:52 -0800
Subject: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
In-Reply-To: <20111122191347.GB4844@kroah.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
 <20111122154900.GB18954@kroah.com>
 <CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
 <20111122191347.GB4844@kroah.com>
Message-ID: <4ECC6D24.9030509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2011 11:13 AM, Greg KH wrote:
> On Tue, Nov 22, 2011 at 09:57:41AM -0800, Mike Turquette wrote:
>>> Ah, comments like this warm my heart.
>>>
>>> Come on, no abusing the kobject code please, if have problems with how
>>> the kernel core works, and it doesn't do things you want it to, then why
>>> not change it to work properly for you, or at the least, ASK ME!!!
>>
>> Ok, I'm asking you now.  There are two ways to solve this problem:
>>
>> 1) have kobject core create the lists linking the objects but defer
>> allocations and any interactions with sysfs until later in the boot
>> sequence, OR
>>
>> 2) my code can create a list of clks (the same way that clkdev does)
>> and defer kobject/sysfs stuff until later, which walks the list made
>> during early-boot
>>
>> #1 is most closely aligned with the code I have here, #2 presents
>> challenges that I haven't really though through.  I know that OMAP
>> uses the clk framework VERY early in it's boot sequence, but as long
>> as the per-clk data is properly initialized then it should be OK.
>>
>> What do you think?
>
> #3 - use debugfs and don't try to create a sysfs interface for the clock
> structures :)

I would prefer debugfs too, but for my own selfish reasons. In our 
current implementation, we have debugfs files: turn on/off a clock, to 
measure a clock (yeah, we have a "measuring" hw block inside the SoC), 
list the supported rates of a clock, etc. We use these files to test the 
clock driver. These certainly would not be acceptable candidates for sysfs.

If the common clock framework uses sysfs for the tree, then the mach-msm 
will have to have its own implementation of debugfs. That's not so nice 
for two reasons:
1. I think these files would be useful for other arch/machs too, but it 
would be odd for the common clock code to expose sysfs and debugfs files 
for each clock.
2. Since it won't be in the common code, each arch/mach will be 
repeating the debugfs code to expose their own enable/disable files.

To me, the ideal choice would be for each clocks to have a directory 
under /debug/clk/ without following the clock topology. Then, inside 
each clock specific directory, there will be an enable, rate, parent 
(symlink to parent clock dir under /debug/clk/) files.

The clock specific drivers will be able to get the handle to the clk 
specific debugfs directory and add their own extra files. Or could be 
made to pass a list of file/ops/perms as part of the 
clock_init/registration.

Thanks,
Saravana


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

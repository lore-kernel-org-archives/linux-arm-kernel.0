From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 19 Mar 2013 09:19:05 +0100
Subject: [PATCH] clk: add DT test clock consumer driver
In-Reply-To: <20130319015425.8663.84827@quantum>
References: <1363439376-21294-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201303161456.54246.arnd@arndb.de> <20130319015425.8663.84827@quantum>
Message-ID: <51481F79.40304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2013 02:54 AM, Mike Turquette wrote:
> Quoting Arnd Bergmann (2013-03-16 07:56:54)
>> On Saturday 16 March 2013, Sebastian Hesselbarth wrote:
>>> This driver adds a DT test clock consumer that exposes debugfs files to
>>> enable/disable and set/get rate of the attached programmable clock.
>>> During development of a i2c-attached clock generator I found it useful
>>> to debug the clock generator's internal pll settings by enforcing clock
>>> rates through debugfs.
>>>
>>> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>>
>> It sounds a little clumsy to have a device driver to match a device that
>> you create just for matching the driver.
>>
>> Would it be possible to separate the debugging logic from the platform
>> device logic? I think it may be useful to have a debugfs or sysfs
>> inteface for all clocks in the system, even if that is disabled by
>> default or only available after manually loading a module implementing
>> that functionality.
>>
>
> I agree that a generic approach is needed here.  I have been meaning to
> break the existing debugfs stuff out into clk-debug.c.  I'll do that
> soon and maybe you can add a new Kconfig entry for
> COMMON_CLK_DEBUG_USERSPACE (or something like that) which implements
> this?

Mike,

I agree with you and Arnd about clumsiness and a generic approach, but
this driver is a little different from controlling _all_ clocks within
the tree. It just adds one consumer that can _request_ a new rate.

Nevertheless, I can have a look at clk-debug and adding the functionality.

> On the other hand this sort of stuff really scares me.  I know for a
> fact that a debug interface to enable/disable clocks and set clock rate
> would ship on real devices.  Quite likely some android phones out there
> would be controlling hardware clocks from some horrible userspace
> utility.
>
> *shudder*

This will happen for sure.

> Sebastian, another small nitpick, can you change the "enable" attribute
> to be named "prepare_enable"?  This more accurately reflects what is
> going on.

On a generic approach I would rather have a look at the actual ops that
are provided and name the files accordingly. That will also allow us
_not_ to set the rate of crystal oscillators ;)

> I also wonder how simple it would be to add a "parent" attribute here
> that allows one to call clk_set_parent from the debugfs interface?  To
> make it easy on you, the interface could accept an integer as the index
> of the clk->parents[] array.  This is a bad interface design as it
> requires the user to look into the code to know which index corresponds
> to which parent clock; however I do not want people to use this
> interface for anything other than debug/testing, so I am ok with this
> interface being a PITA to use.

Sure, but it will not help much against userspace hardware clock
utilities ;)

Sebastian

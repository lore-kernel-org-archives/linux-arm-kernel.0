From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 03 Jul 2015 14:21:09 +0200
Subject: [PATCH v2 2/4] ARM: mvebu: Add standby support
In-Reply-To: <20150703141716.785a27c5@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>	<1435684740-24912-3-git-send-email-gregory.clement@free-electrons.com>	<20150701174709.2d55007d@free-electrons.com>	<55967485.2010607@free-electrons.com>
 <20150703141716.785a27c5@free-electrons.com>
Message-ID: <55967E35.8050002@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 03/07/2015 14:17, Thomas Petazzoni wrote:
> Gregory,
> 
> On Fri, 03 Jul 2015 13:39:49 +0200, Gregory CLEMENT wrote:
> 
>> Having 2 initcall does not work because, there is a dependency between these
>> 2 calls. And actually the suspend_ops is registered before the board specific
>> hook. As soon as the suspend_ops is registered, mvebu_pm_valid() is called but
>> at this point mvebu_board_pm_enter is NULL so PM_SUSPEND_MEM is not available.
> 
> And? It will become available soon afterwards.

No it is called during boot and if the method is not there then it is no
more available for the user. I made te test and with a cat on /sys/power/state
I only got "freeze" and "standby" but not "mem".


Thanks,

Gregory



> 
>> All the complexity of the original patch was to allow registering a handler
>> without needed to get the resource(gpio device) that are not available when using
>> arch_initcall(). However the device_initcall_sync comes latter enough to
>> get all the devices registered but it still happens before the late_initcall,
>> so I will use this one and I will add a comment around it.
> 
> I don't think we care about the order in which the initcalls are called.
> 
> If the SoC level init call registering the suspend_ops gets called
> first, then at the beginning there is only support for standby. The
> support for suspend to RAM will be enabled once the board-level init
> call gets called.
> 
> If the board level init call is called first, then it will set
> mvebu_board_pm_enter. It is not useful at this point. Until the SoC
> level init call registers the suspend_ops.
> 
> I believe that the ->valid() method of suspend_ops gets called when the
> user actually enters the suspend state by writing to /sys/power/state.
> And by that time, both init calls will have been called.
> 
> Best regards,
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

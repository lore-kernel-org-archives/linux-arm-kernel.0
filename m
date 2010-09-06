From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Sep 2010 09:56:50 +0100
Subject: [PATCH 0/2] ARM: factorise CPU hotplug code
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B181C7DC10D@EXDCVYMBSTM006.EQ1STM.local>
References: <1283515266-25374-1-git-send-email-sundar.iyer@stericsson.com>
	<33A307AF30D7BF4F811B1568FE7A9B181C7DC032@EXDCVYMBSTM006.EQ1STM.local>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7AF5@dbde02.ent.ti.com>
	<33A307AF30D7BF4F811B1568FE7A9B181C7DC10D@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <20100906085650.GA20903@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 06, 2010 at 09:15:57AM +0200, Sundar R IYER wrote:
> Hi Santosh,
> 
> >-----Original Message-----
> >From: Shilimkar, Santosh [mailto:santosh.shilimkar at ti.com]
> 
> >Generic Approach seems to be good but I think this might complicate few
> >scenario's regarding how _A_ platform wants to handle the hotplug.
> >
> 
> Yes. But the functions cpu_enter_lowpower and cpu_leave_lowpower()
> are still preserved in platform specific files. Only the top helpers
> are moved out.
>
> So, platforms can still work out their custom low power mode
> implementations; which I believe can vary according to the
> implementation of (say independent) power domains for each/
> multiple cores.

So what if a platform wants to completely power down a CPU?

You'd want to implement it such that platform_cpu_die() does all
the shutdown of the CPU except for power-off, and platform_cpu_kill()
waits for that to complete before turning power off.

With platform_cpu_kill() and platform_cpu_die() moved into generic
code, you can no longer do this.

Lastly, what if you want to allow CPU0 to be offlined, which is
possible, though its wake-up is a little more complex because it
must not be allowed to go through its normal boot?

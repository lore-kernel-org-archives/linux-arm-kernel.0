From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 27 Jul 2017 13:07:00 -0700
Subject: halting the kernel does not stop the CPU cores?
In-Reply-To: <VI1PR04MB1662099750F9EAFA0324C6538CBE0@VI1PR04MB1662.eurprd04.prod.outlook.com>
References: <VI1PR04MB1662099750F9EAFA0324C6538CBE0@VI1PR04MB1662.eurprd04.prod.outlook.com>
Message-ID: <26ccb0f7-0f78-27cd-cead-ddd810f4a33e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2017 07:38 AM, Heinz Wrobel wrote:
> Hi,
> 
> I noticed that when halting the kernel (intentionally or not), the cores effectively go into a while(1) loop and power consumption on larger devices really jumps up significantly to the point where, e.g., a ?crash? turns into ?crash and burn?.
> 
> I would assume that if a system is halted, you don?t want to dissipate more power than on a running system but go as silent as low power as reasonable.
> 
> Is there any specific reason why the cores would not go into a wfi loop like they do on idle?
> The patch to fix this seems to be easy at first glance, but is there a good reason *NOT* to do such a patch and to leave the plain while(1)?

In fact, if your platform supports CPU_HOTPLUG, I am not clear why
smp_send_stop() + ipi_send_stop() is not calling platform_cpu_kill()
which would be smp_ops.cpu_kill() but instead cpu_relax() was chosen?

The CPU is dead anyway so as you say, so it's not like there is a remote
chance to resume execution on these secondary cores?
--
Florian

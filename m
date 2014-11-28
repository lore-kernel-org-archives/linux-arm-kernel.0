From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 17:31:45 +0100
Subject: [PATCH v2 RESEND 1/2] ARM: vexpress: Remove non-DT code
In-Reply-To: <1417189984.4371.12.camel@arm.com>
References: <1416939455-1814-1-git-send-email-pawel.moll@arm.com>
 <20141128153026.GU3836@n2100.arm.linux.org.uk>
 <1417189984.4371.12.camel@arm.com>
Message-ID: <3935390.Q4yT7WfqCv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 15:53:04 Pawel Moll wrote:
> vmmc-supply is a defined as:
> 
>                                 vmmc-supply = <&v2m_fixed_3v3>;
> 
> which is:
> 
>                 v2m_fixed_3v3: fixedregulator at 0 {
>                         compatible = "regulator-fixed";
> 
> and arch/arm/mach-vexpress/Kconfig says:
> 
> menuconfig ARCH_VEXPRESS
> [...]
>         select REGULATOR_FIXED_VOLTAGE if REGULATOR
> 
> but it doesn't select REGULATOR in result of this discussion:
> 
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/223426/focus=223427
> 
> To summarize, I believe that setting CONFIG_REGULATOR=y (as in
> vexpress_defconfig) should solve your issue.

Well, there is clearly a bug somewhere. As you say, the mmc driver
now uses the regulator API to check the voltage instead of using
platform_data. But there is no dependency on having the regulator
support around, so it can't.

I would suggest applying your patch from
http://thread.gmane.org/gmane.linux.ports.arm.kernel/223426/focus=224128
after all, or just hardcoding regulator support like a lot of other
platforms do.

	Arnd

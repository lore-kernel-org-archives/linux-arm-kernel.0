From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Sep 2018 17:41:02 -0700
Subject: [PATCH] gpio: omap: Remove custom PM calls and use cpu_pm instead
In-Reply-To: <01f5b04a-82ed-fafe-5b90-3e662f21d0db@ti.com>
References: <20180911183729.17110-1-tony@atomide.com>
 <01f5b04a-82ed-fafe-5b90-3e662f21d0db@ti.com>
Message-ID: <20180912004102.GG5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [180912 00:33]:
> On 09/11/2018 01:37 PM, Tony Lindgren wrote:
> > +	switch (cmd) {
> > +	case CPU_CLUSTER_PM_ENTER:
> > +		/* Gets cleard on runtime_suspend */
> > +		bank->power_mode = OFF_MODE;
> 
> It has to be reset somewhere.

Oh good catch omap_gpio_runtime_suspend() only clears it
if (bank->power_mode != OFF_MODE).. This would certainly
introduce some unexpected latencies..

We can just clear it unconditionally at the end of
CPU_CLUSTER_PM_ENTER handler now.

Regards,

Tony

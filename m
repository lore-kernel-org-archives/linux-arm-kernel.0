From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 27 Jan 2013 21:33:04 +0530
Subject: [PATCH v3 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <20130127154212.GJ29973@lunn.ch>
References: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
 <1359281244-31455-2-git-send-email-andrew@lunn.ch>
 <CAKohpomWM41MhRjdhFixy-ELXc6QjE0BhCAHfTzovOD0CBPoOQ@mail.gmail.com>
 <20130127154212.GJ29973@lunn.ch>
Message-ID: <CAKohpomQJfsWBY5o3ep4r86fYYQ39JnMPswjoe8YFT37ekM20w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 January 2013 21:12, Andrew Lunn <andrew@lunn.ch> wrote:
> And how would the module get loaded? There is no hardware anchor to
> make the module load. No enumeration of some bus causing it to be
> loaded. In the ARM world, platform drivers are the norm.

The way you do it now is by creating a platform device for it in your
arch/arm/mach-* directory. And you are passing an IOMEM resource too.

I believe, normally we don't require any DT node or platform device from
arch/arm/mach-* for cpufreq drivers. This is something which should
always be initialized once it is selected in .config.

Because we will call the _probe() (or renamed as kirkwood_cpufreq_init)
from module_init() now, it will get initialized directly. No need to any
enumeration at all. Now, in case there are multiple values of IOMEM resource
depending on machine type, you can create properties in cpu node. Otherwise
just embed the address directly into driver as nobody else is going to use it.

Makes sense?

--
viresh

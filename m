From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 May 2014 22:52:45 -0400 (EDT)
Subject: CPU performance counters not working on big.LITTLE switcher
In-Reply-To: <CAPz6YkXsig6XornqoMyn5DtRd9NECyc+qgQo39RQK0sDeat34Q@mail.gmail.com>
References: <CAPz6YkXsig6XornqoMyn5DtRd9NECyc+qgQo39RQK0sDeat34Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1405052238230.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 May 2014, Sonny Rao wrote:

> Hi, we have the problem today that cpu based performance counters don't
> work when we're using the big.LITTLE switcher on Exynos 5420, and it
> doesn't look like code exists to deal with this in the switcher.
> 
> As it stands right now, if you put an A-15 or A-7 PMU node into your
> device-tree on an bl_switcher system it's very broken.  At the minimum, I
> think it should disable performance counters until there's some kind of
> proper implementation.
> 
> I looked into trying to make this work, but it turned out to not be as
> simple as just context switching counters from A-15 to A-7.  The biggest
> problem is that the PMUs are not architecturally compatible.  There are
> different events and differing numbers of counters on these two cores.
>  There's also the tangential issue of representing this in the device tree,
> but that's far less important.
> 
> My guess as to how to fix this is to create an "architectural" PMU which
> contains the intersection of the two performance monitor units with the
> minimum number of counters supported by either core (which in this case
> looks to be 4 on the A7).  However, I don't really have the bandwidth to
> work on this at  the moment.  I was mostly wondering, have other people run
> into this limitation and is there any sort of plan to work on it?

The Linaro kernel release from a year ago or so contained a hack to make 
PMUs available and cope with the switcher.

However, the ultimate solution is to add multi-PMU support in a generic 
way to the kernel and let user space see both A15 and A7 counters.  It 
is then up to the analysis tools to consolidate (some of) them if 
wanted.  And this would work whether the switcher is used, or even when 
the scheduler has learned to do proper task placement for b.L systems 
where tasks may migrate across clusters.

Someone at ARM indicated they'd be working on the multi-PMU support if I 
remember correctly.  For that reason, Linaro stopped maintaining the 
initial hack since it was a lot of work to keep it working on top of 
later kernels and a better solution was coming anyway.  I don't know 
what the status of that work is though.


Nicolas

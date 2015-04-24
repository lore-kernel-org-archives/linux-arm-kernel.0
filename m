From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Apr 2015 16:37:24 +0100
Subject: Programming the boundary between Inner and Outer caches on ARM
 architecture
In-Reply-To: <CAJWVF-xwBwjfQxV3+wEsNz0oDsR+VGVh2WMg+RdTE8_Lr1AJEA@mail.gmail.com>
References: <CAJWVF-w5YpZjRqnvbz1p70_WTBROL9vDkvYb_sG43nGp=s1vLg@mail.gmail.com>
 <20150420100119.GC24715@e104818-lin.cambridge.arm.com>
 <CAJWVF-xvca0MpKF1=GoyyffGTzxtvy_LoaZfjhwU27vSuyOHFA@mail.gmail.com>
 <20150421110038.GH30114@e104818-lin.cambridge.arm.com>
 <CAJWVF-wg1ROj_rwufJzszCR594NcJc89cW4R85ZSTQtissT4Bw@mail.gmail.com>
 <CAJWVF-xwBwjfQxV3+wEsNz0oDsR+VGVh2WMg+RdTE8_Lr1AJEA@mail.gmail.com>
Message-ID: <20150424153724.GK4918@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 12:39:02AM +0530, Bhaskara rao Budiredla wrote:
> > > 2. Configuration of the boundary between inner and outer caches is not
> > > needed for a system where in the inner and outer cacheable attributes
> > > are same. Does the current Linux kernel for ARM architecture assumes
> > > this?
> > 
> > The outer attributes are sent on the bus in case you have an L3 cache.
> > In general, I would set both inner and outer attributes the same. I
> > don't understand what your "specific requirement" is.
> 
> [Bhaskara] For all the Cortex-A series processors the CLIDR[8:6] bits
> set to b000, which indicates the type of cache implemented at level 3
> as "No Cache". Is this not an issue if any specific silicon vendor
> wants to integrate L3 cache on his/her SOC along with Coretx-Axx
> processor?

It's not a problem as long as the operating system does not need to know
about such L3 cache (it transparently handles cache maintenance by VA
issued by the CPU). One thing is the cache maintenance by set/way but we
are removing this from the kernel altogether since it isn't a safe
operation. The SoC-specific firmware would need to handle it
appropriately for boot or power management. I am aware of at least one
such L3 implementation (the Applied Micro ARMv8 CPU).

The ARMv8 ARM (revision E) also has a section on system level caches and
expected behaviour: D3.4.11

-- 
Catalin

From: okaya@kernel.org (Sinan Kaya)
Date: Fri, 3 Aug 2018 13:32:10 -0400
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <f0ab7c55-c104-241e-99d1-8247b2c567d1@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/3/2018 1:09 PM, Mikulas Patocka wrote:
>>> Most accelerated graphics drivers rely heavily on the ability to map
>>> the VRAM normal-non-cacheable (ioremap_wc, basically), and treat it as
>>> ordinary memory.
>> Yeah, I'd expect framebuffers to be mapped as normal NC. That should be
>> fine for prefetchable BARs, no?
>>
>> Will
> So - why does it corrupt data then? I've created this program that
> reproduces the data corruption quicky. If I run it on /dev/fb0, I get an
> instant failure. Sometimes a few bytes are not written, sometimes a few
> bytes are written with a value that should be 16 bytes apart.
> 
> I tried to run it on system RAM mapped with the NC attribute and I didn't
> get any corruption - that suggests the the bug may be in the PCIE
> subsystem.

Note that normal-NC gives you write combining whereas device
nGnRE doesn't have any write-combining support.
normal-NC is typically mapped to prefetchable BAR space where
write-combining is welcome.

It could be an issue on the SOC itself too. I suggest you contact your
board vendor.

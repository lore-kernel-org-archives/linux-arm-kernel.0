From: daniel.kiper@oracle.com (Daniel Kiper)
Date: Fri, 30 Oct 2015 21:36:14 +0100
Subject: arm64: iomem_resource doesn't contain all the region used
In-Reply-To: <5633B7D6.6020702@citrix.com>
References: <562A4B0F.2020603@citrix.com>
 <1445615112.2374.226.camel@citrix.com>
 <563106C6.8000603@citrix.com>
 <20151029163655.GJ3489@olila.local.net-space.pl>
 <5632565A.8050603@citrix.com>
 <20151030175322.GL3489@olila.local.net-space.pl>
 <5633B7D6.6020702@citrix.com>
Message-ID: <20151030203614.GO3489@olila.local.net-space.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 06:32:54PM +0000, Julien Grall wrote:

[...]

> > Ugh! I though that it is a requirement that every memory/io region user
> > must register it using relevant function. It looks that it is not true.
> > So, there is only one reliable way to get info about used io/memory regions.
> > You must look at DT. However, if driver may agree with a device other
> > config and move used io/memory regions to different place without updating
> > DT then we are lost.
>
> While the Linux folks are trying to describe all the device in the
> Device Tree, it not always the case.
>
> Also, browsing the device tree to find memory range is a pain and quite
> fragile. For instance we already do that in the hypervisor to map all
> the device to DOM0 (see arch/arm/domain_build.c) but we still do have
> bug report of platform not working with this solution.

I expected this. Do we have any other choice? Maybe we should discuss
this on wider forum somewhere and encourage devs to use relevant resource
management functions in drivers. Well, I saw somewhere that IanC doubts
it is feasible but I do not see better solution for this right now.

> >> TBH I don't see why you don't hit this issue on x86. Overall some of the
> >> drivers can be shared between the 2 architectures.
> >
> > Are you able to point out any (x86) driver which does not behave as it should?
>
> Just thinking that on x86 you have the e820 which describe the memory
> layout of the platform.
>
> Am I correct to say that every I/O regions are described in the e820 and
> therefore registered when Linux is booting?

No, as I saw regions used by devices are not listed on some (all?) machines.
I have a feeling that driver negotiates with device where a given I/O
region should be placed. So, this region is not known by BIOS or even UEFI
in advance. Sadly, I do not know in detail how this process works.

Daniel

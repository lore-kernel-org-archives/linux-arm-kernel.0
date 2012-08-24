From: matt@genesi-usa.com (Matt Sealey)
Date: Fri, 24 Aug 2012 13:00:13 -0500
Subject: [PATCH 4/5] DRM: add i.MX IPUv3 base driver
In-Reply-To: <806769921.2812305.1345819977325.JavaMail.root@advansee.com>
References: <1596192785.2810155.1345817566620.JavaMail.root@advansee.com>
 <806769921.2812305.1345819977325.JavaMail.root@advansee.com>
Message-ID: <CAKGA1bkjJXK8bUxLxRYz_4Rj9YW0mJxBMyg7ir+Hfo+s6Lza0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 9:52 AM, Beno?t Th?baudeau
<benoit.thebaudeau@advansee.com> wrote:
> Hi Sascha,
>
> On Thu, Jun 14, 09:43:26 EDT 2012, Sascha Hauer wrote:
>> The IPU is the Image Processing Unit found on i.MX51/53 SoCs. It
>> features several units for image processing, this patch adds support
>> for the units needed for Framebuffer support, namely:
>>
>> - Display Controller (dc)
>> - Display Interface (di)
>> - Display Multi Fifo Controller (dmfc)
>> - Display Processor (dp)
>> - Image DMA Controller (idmac)
>>
>> This patch is based on the Freescale driver, but follows a different
>> approach. The Freescale code implements logical idmac channels and
>> the handling of the subunits is hidden in common idmac code pathes
>> in big switch/case statements. This patch instead just provides code
>> and resource management for the different subunits. The user, in this
>> case the framebuffer driver, decides how the different units play
>> together.
>
> What is the status of this series, and especially of this patch, as to its
> integration into upstream? At some point, you were talking about pushing it to
> staging, but since things don't seem to have evolved.

DRM guys "don't have time to review it", apparently.

I can't find the patch series in any patchwork (I probably am not
looking hard enough) but the base driver should be an MFD or something
or placed somewhere other than in DRM directories as it has been in
the past. It might make it quicker to review the core driver.

Then there is a major problem here; Sascha's DRM helper functions are
also basically rejected again (which is a shame..) and nobody really
has a cohesive device tree binding that would let us individually
initialize and specify IPU units. It's not something easy to
"tree-ize". I thought about it and walked away as it made my head
hurt. Those two make it INCREDIBLY difficult to engineer a solution
whereby a modular, independent IPU subsystem can support modular,
independent encoder/connector pairs (which are usually 1:1 the same
chip) without making the encoder/connector itself entirely dependent
on the DRM driver underneath. In the case of the SII9022 which is on
the Efika MX, this driver would need to be written for the Efika MX,
have specific support for MX53 Quickstart, debouncing of hotplug or
not depending on the board, some Beagle clones and TI's OMAP3 EVK have
the chip too, and many others floating around. Nobody wants to write
the same driver 5 times, and while the Silicon Image controllers are
wonderfully generic with a common API ("TPI") and there could be a
generic MFD solution with shim drivers on top for DRM, nobody else's
are quite as nice.

DRM just doesn't support the passing of information that makes this
generic, even if you had the binding. I was thinking of hijacking the
"slave encoder" subsystem which is designed to help PCI/AGP cards
register i2c buses local to the card (i.e. after PCI probe is done,
while the DRM subsystem is handling things) and access i2c data like
EDID or just talk to external encoder chips on these cards which
change every 5 minutes. It would need to be told which i2c bus it
needs to talk on (maybe a phandle to a ddc@ node for generic access,
or a phandle
to a specific encoder if the DDC is bounded by some kind of locking or
access restriction during normal use like on SII9022 - each slave
encoder would need to supply it's DDC access functions or push in good
default ones from another driver, but at the time of init, it cannot
know the driver information to get this..). There are also several
known flaws in the way DRM works (you cannot validate mode ids at the
level you need to - it is a "connector" task, but it needs to be a
crtc task too especially for IPU where bandwidth is defined by the
IDMAC FIFO settings and units in use) which might require more than a
rudimentary rework of parts of DRM (more like, a new API entirely..)

It's horrible, hideous even, and could require several years of
development for something which nobody had the foresight to see, even
though the configurations required have existed since the early 90's -
a SoC with parallel or serial display bus, with transmitters to the
panels or connectors connected over i2c for configuration and EDID
data gathering. DRM just doesn't really support it in a generic way.

>> The IPU has other units missing in this patch:
>>
>> - CMOS Sensor Interface (csi)
>> - Video Deinterlacer (vdi)
>> - Sensor Multi FIFO Controler (smfc)
>> - Image Converter (ic)
>> - Image Rotator (irt)
>>
>> So expect more files to come in this directory.
>
> Do you have a schedule for that? Are you waiting for more customer projects at
> Pengutronix to do that?

Both Pengutronix and Genesi have slightly differing implementations of
these (especially csi, ic) which might need to be merged together and
coordinated. I am not sure what the schedule for this is, Genesi's
customer doesn't in the final result need actual Linux support (it's
just a better case for proof of concept development and feature
comparison/development than FSL's BSP code which is a spaghetti
factory).

> That would be great to finally have full IPU/VPU/GPU support for i.MX5 into
> upstream. As you already know, Linaro also have some video support for i.MX5 in
> this head:
> http://git.linaro.org/gitweb?p=landing-teams/working/freescale/kernel.git;a=shortlog;h=refs/heads/lt-3.2-imx5
>
> Matt, I think you also have video support for efikamx, don't you?

Well, here is the problem;

IPU, VPU and GPU are basically completely seperate. They do not need
to depend on each other for anything, but the most EXCITING uses would
coordinate these three units together through some userspace API (DRM
for IPU-DI and GPU access, dma_buf for sharing, v4l2 mem2mem for VPU
and IPU processing tasks..) such that you could send H.264 for example
to decode, deinterlace, rotate and colour convert it in IPU then use
it as a GPU texture (if only because the GPU doesn't support some
common YUV formats without expensive shader) without copying anything
around and just signalling your intent to the kernel.

That kind of coordination is simply missing from pretty much
everyone's SoCs right now except perhaps Samsung's Exynos5.

VPU would be better serviced by improving the CODA driver someone
submitted a month ago. The CODA driver ported uses the same v4l2
mem2mem API as Samsung's MFC video codec, but that codec is a
different core than CODA. This is Chips&Media IP core, roughly
compatible with it's various versions and included in i.MX series for
a long time.. it is also shared by *older* Exynos (I think Exynos3)
designs and probably exists in some lower-end ARM processor cores too
from other manufacturers). It may by that legacy be in the original
iPhone :)

GPU couldn't even get into mainline when developed by Qualcomm (same
GPU for i.MX51 and i.MX53 as their "Adreno 200") - some significant
coordination between companies here is required. Qualcomm uses a
custom GPU access API called "GSL" which does somewhat of the same job
as DRM could/should, but it needs porting, then there is a significant
problem here after that in that the userspace is completely closed.
Genesi has access to most of the source (some parts are still binaries
even to us), some other companies do too, but the terms of the NDA are
extremely restrictive. I cannot recommend Freedreno because I am
technically not even allowed to look at it, but it might be your best
chance for opensource here.

> Is there a plan to merge all these developments into upstream?

At some point. I would love to do it, but there's so much to actually
do. It would benefit far more here than just Freescale chips, except
the IPU, which would benefit far more than just a single Freescale SoC
(i.MX51, 53, 6 and onwards would be supported) anyway due to a pretty
much 99% shared API implementation with a few subtle but almost
irrelevant differences.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.

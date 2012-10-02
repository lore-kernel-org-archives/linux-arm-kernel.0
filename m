From: mporter@ti.com (Matt Porter)
Date: Tue, 2 Oct 2012 12:28:33 -0400
Subject: [alsa-devel] [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
In-Reply-To: <506A9C65.5040309@ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
 <20120922153313.GN4495@opensource.wolfsonmicro.com>
 <506A9C65.5040309@ti.com>
Message-ID: <20121002162833.GR5641@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 10:48:53AM +0300, Peter Ujfalusi wrote:
> On 09/22/2012 06:33 PM, Mark Brown wrote:
> > On Fri, Aug 31, 2012 at 06:20:58PM +0530, Hebbar, Gururaja wrote:
> > 
> >> +config SND_DAVINCI_HAVE_SRAM
> >> +	bool
> >> +	default y if ARCH_DAVINCI=y
> >> +	default n if ARCH_OMAP=y
> >> +
> > 
> > I've been sitting on this mostly since it seems like a step back from
> > multi-platform kernels (which is where we're trying to get to) and I've
> > been trying to decide what the best approach is.  I'm thinking that we
> > do want a generic API for allocating this stuff, it's a fairly generic
> > feature (there's TCMs as well).  
> > 
> > Adding ifdefs like this does just doesn't seem good.
> 
> I also agree that ifdef is not a good solution.
> It is better to have this information passed as device_data and via DT it can
> be decided based on the compatible property for the device.

The driver is going to be used by both !DT and DT only platforms for a
while so DT-centric solutions just don't make sense. There's a clean way
to do this that was used for uio_pruss.c. When davinci is further along
on DT conversion we can make use of the devicetree-based generic sram
driver that's progressing along right now [1]. It needs some minor help
to allow specifying the gen_pool allocation order, but it will work
nicely for getting access to the right sram pool.

-Matt

[1] https://patchwork.kernel.org/patch/1421961/

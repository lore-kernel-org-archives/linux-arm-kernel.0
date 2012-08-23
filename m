From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 23 Aug 2012 12:39:23 +0100
Subject: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP probe rather
 than as a device
In-Reply-To: <20120823092216.GA27264@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
 <20120823092216.GA27264@gmail.com>
Message-ID: <20120823113922.GZ7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 10:22:17AM +0100, Lee Jones wrote:

> > > Just thinking about this now. I converted it to the current format at
> > > the request of Mark. If this isn't the correct method I'm not quite
> > > sure what is. If you want it to be registered as a device, then it
> > > needs to go into the Device Tree, but Mark doesn't want it in there
> > > because it doesn't actually represent hardware.

> I've just taken a closer look at this with a view to finding the most
> suitable solution. My conclusion is that although the PCM doesn't
> contain any registers, or represent hardware it should be a device and
> therefore be present in the Device Tree.

Your assumption that being a device in Linux means that something should
appear in the device tree definitely doesn't follow.

> PCM devices already represented in DTs:
>   fsl,mpc5200-pcm - written by Grant Likely, the author of Device Tree
>   phytec,pcm030   - written by Grant Likely, the author of Device Tree

I suspect Mitch might have a word or two to say about the above...  in
any case, these are *really* old PowerPC bindings which means they're
not always a good model.  Though in this case if you look at the code
you'll also see that the driver is actually directly managing hardware
with register I/O rather than just purely proxying an underlying DMA
API.  Clearly if there's actual hardware control involved a device is
appropriate.

> PCM devices which register as actual devices (should be in DT):

These are all Linux platform devices, things that are OK for purely
internal Linux usage which we can rewrite at will aren't always
appropriate for a cross platform DT.

> I propose to represent the PCM in the Device Tree again and have it
> probe just like all the other PCM devices in sound/soc.

> If you give me the nod, I'll revert this patch, enable the PCM for DT
> again and resent the patch-set in full.

I say I don't understand the motivation for this change.  All the modern
DT bindings are perfectly happy handling this without an explicit shim
in the device tree to bodge things for Linux, adding them in seems like
it'd be a retrograde step.  What benefit do you believe this brings?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/1c0de982/attachment.sig>

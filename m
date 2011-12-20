From: rmorell@nvidia.com (Robert Morell)
Date: Mon, 19 Dec 2011 18:05:49 -0800
Subject: [Linaro-mm-sig] [RFC v2 1/2] dma-buf: Introduce dma buffer
 sharing mechanism
In-Reply-To: <201112131510.02785.arnd@arndb.de>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <4EE33EC2.6050508@redhat.com>
 <20111212224408.GD4355@morell.nvidia.com>
 <201112131510.02785.arnd@arndb.de>
Message-ID: <20111220020549.GQ6559@morell.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 07:10:02AM -0800, Arnd Bergmann wrote:
> On Monday 12 December 2011, Robert Morell wrote:
> > > 
> > > Doing a buffer sharing with something that is not GPL is not fun, as, if any
> > > issue rises there, it would be impossible to discover if the problem is either
> > > at the closed-source driver or at the open source one. At the time I was using
> > > the Nvidia proprietary driver, it was very common to have unexplained issues
> > > caused likely by bad code there at the buffer management code, causing X
> > > applications and extensions (like xv) to break.
> > >
> > > We should really make this EXPORT_SYMBOL_GPL(), in order to be able to latter
> > > debug future share buffer issues, when needed.
> > 
> > Sorry, I don't buy this argument.  Making these exports GPL-only is not
> > likely to cause anybody to open-source their driver, but will rather
> > just cause them to use yet more closed-source code that is even less
> > debuggable than this would be, to those without access to the source.
> 
> But at least the broken module then won't be interacting with other modules
> because it cannot share any buffers.

One of the goals of this project is to unify the fragmented space of the
ARM SoC memory managers so that each vendor doesn't implement their own,
and they can all be closer to mainline.

I fear that restricting the use of this buffer sharing mechanism to GPL
drivers only will prevent that goal from being achieved, if an SoC
driver has to interact with modules that use a non-GPL license.

As a hypothetical example, consider laptops that have multiple GPUs.
Today, these ship with onboard graphics (integrated to the CPU or
chipset) along with a discrete GPU, where in many cases only the onboard
graphics can actually display to the screen.  In order for anything
rendered by the discrete GPU to be displayed, it has to be copied to
memory available for the smaller onboard graphics to texture from or
display directly.  Obviously, that's best done by sharing dma buffers
rather than bouncing them through the GPU.  It's not much of a stretch
to imagine that we'll see such systems with a Tegra CPU/GPU plus a
discrete GPU in the future; in that case, we'd want to be able to share
memory between the discrete GPU and the Tegra system.  In that scenario,
if this interface is GPL-only, we'd be unable to adopt the dma_buffer
sharing mechanism for Tegra.

(This isn't too pie-in-the-sky, either; people are already combining
Tegra with discrete GPUs:
http://blogs.nvidia.com/2011/11/world%e2%80%99s-first-arm-based-supercomputer-to-launch-in-barcelona/
)

Thanks,
Robert

From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed, 27 Dec 2017 09:36:04 +0100
Subject: [GIT PULL] tee dynamic shm for v4.16
In-Reply-To: <6acdbda2-d1b1-127c-a6e4-df30dc5e200b@codeaurora.org>
References: <20171215132057.ang2xawtpzp5eb6o@jax>
 <CAK8P3a09za3vGW5P5xDExurTtB=s8adcvz_m-czrE4cZcorGmg@mail.gmail.com>
 <6acdbda2-d1b1-127c-a6e4-df30dc5e200b@codeaurora.org>
Message-ID: <20171227083602.zujn3phctvqie3ob@jax>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 25, 2017 at 01:22:18PM -0800, thomas zeng wrote:
> 
> 
> On 2017?12?21? 08:30, Arnd Bergmann wrote:
> > On Fri, Dec 15, 2017 at 2:21 PM, Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > > Hello arm-soc maintainers,
> > > 
> > > Please pull these tee driver changes. This implements support for dynamic
> > > shared memory support in OP-TEE. More specifically is enables mapping of
> > > user space memory in secure world to be used as shared memory.
> > > 
> > > This has been reviewed and refined by the OP-TEE community at various
> > > places on Github during the last year. An earlier version of this pull
> > > request is used in the latest OP-TEE release (2.6.0). This has also been
> > > reviewed recently at the kernel mailing lists, with all comments from
> > > Mark Rutland <mark.rutland@arm.com> and Yury Norov
> > > <ynorov@caviumnetworks.com> addressed as far as I can tell.
> > > 
> > > This isn't a bugfix so I'm aiming for the next merge window.
> > Given that Mark and Yury reviewed this, I'm assuming this is all
> > good and have now merged it. However I missed the entire discussion
> > about it, so I have one question about the implementation:
> > 
> > What happens when user space passes a buffer that is not
> > backed by regular memory but instead is something it has itself
> > mapped from a device with special page attributes or physical
> > properties? Could this be inconsistent when optee and user
> > space disagree on the caching attributes? Can you get into
> > trouble if you pass an area from a device that is read-only
> > in user space but writable from secure world?

Read-only memory is dealt with by calling get_user_pages_fast() with
the 'write' parameter set to 1.

Mismatch in cache attributes isn't addressed though. This is something
that should be checked in the OP-TEE driver, typically
drivers/tee/optee/core.c.

I would like to add another patch on top of this patch series to guard
against cache attributes which aren't normal cached memory. So far I
haven't been able to find a nice way of doing that, I'd appreciate any
advice of idea of how to deal with this.

> 
> Just recently, we have started to kick the tires of these "shm" related Gen
> Tee Driver patches.? And we have in the past encountered real world
> scenarios requiring some of the shared memory regions to be marked as
> "normal IC=0 and OC=0" in EL2 or SEL1, or else HW would misbehave. We worked
> around by hacking the boot code but that works if the regions are
> pre-allocated. Since now these regions can also be managed dynamically, we
> definitely agree with Arnd Bergmann that the dynamic registration SMC
> commands, and potention the SHM IOCTL commands, must convey cache
> intentions. Is it possible to take this requirement into consideration, in
> this iteration or the follow on?

I'd be happy to discuss using different cache attributes outside this
patch series. We have so far avoided specifying cache attributes by
calling it normal cached memory. Now that we have one use case we're
able take the next step here.

Thanks,
Jens

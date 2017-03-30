From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Mar 2017 16:32:49 +0200
Subject: [GIT PULL] generic TEE subsystem for v4.12
In-Reply-To: <20170314145305.GA12937@jax>
References: <20170314145305.GA12937@jax>
Message-ID: <8981963.xoBUojTFOS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 14, 2017 3:57:34 PM CEST Jens Wiklander wrote:
> Hi arm-soc maintainers,
> 
> Please consider this pull request for v4.12
> 
> This pull request contains version 16 of the generic TEE driver.
> 
> The TEE subsystem will contain drivers for various TEE implementations.
> A TEE (Trusted Execution Environment) is a trusted OS running in some
> secure environment, for example, TrustZone on ARM CPUs, or a separate
> secure co-processor etc.
> 
> The patch set has been reviewed by different people during the different
> versions. Now I think this has reached a state where it's mature enough
> to merge.
> 
> The v16 cover letter containing detailed revision history can be found at
> https://lkml.org/lkml/2017/3/10/1277
> 
> Thanks,
> Jens
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-drv-for-4.12
> 
> for you to fetch changes up to 14e21cb8f811100a2104e952b8f5bc0326a5e213:
> 
>   arm64: dt: hikey: Add optee node (2017-03-10 14:51:58 +0100)
> 
> ----------------------------------------------------------------
> Introduce generic TEE subsystem:
> - the TEE subsystem itself
> - an OP-TEE driver using the subsystem
> - optee bindings
> - optee node for hi6220-hikey.dts

(+Linus, FYI)

I've put this into a separate next/tee branch in arm-soc,
which means we will send this separately to Linus in the next
merge window for the introduction of a new kernel subsystem,
and I expect that future updates will get handled through the
next/drivers branch in arm-soc, like we do for reset controllers.

I have reviewed earlier versions in the past, and have reviewed
the latest version in person during Linaro Connect BUD17.

Here is my overall assessment of the subsystem:

* There is clearly demand for this, both for the generic
  infrastructure and the specific OP-TEE implementation.

* The code has gone through a large number of reviews,
  and the review comments have all been addressed, but
  the reviews were not coming up with serious issues any more
  and nobody volunteered to vouch for the quality.

* The user space ioctl interface is sufficient to work with the
  OP-TEE driver, and it should in principle work with other
  TEE implementations that follow the GlobalPlatform[1] standards,
  but it might need to be extended in minor ways depending on
  specific requirements of future TEE implementations

* The main downside of the API to me is how the user space
  is tied to the TEE implementation in hardware or firmware,
  but uses a generic way to communicate with it. This seems
  to be an inherent problem with what it is trying to do,
  and I could not come up with any better solution than what
  is implemented here.

      Arnd

[1] https://www.globalplatform.org/mediaguidetee.asp

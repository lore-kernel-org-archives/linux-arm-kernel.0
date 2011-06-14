From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jun 2011 07:59:29 +0200
Subject: [RFC] dmaengine: add new api for preparing simple slave transfer
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9403020B7B37@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940301FE2DED@dbde02.ent.ti.com>
	<20110609124723.GA24636@n2100.arm.linux.org.uk>
	<E0D41E29EB0DAC4E9F3FF173962E9E940301FE2EFB@dbde02.ent.ti.com>
	<20110609163206.GB24636@n2100.arm.linux.org.uk>
	<1307686397.10976.116.camel@vkoul-udesk3>
	<E0D41E29EB0DAC4E9F3FF173962E9E940301FE337F@dbde02.ent.ti.com>
	<20110610104318.GC24636@n2100.arm.linux.org.uk>
	<E0D41E29EB0DAC4E9F3FF173962E9E940301FE3452@dbde02.ent.ti.com>
	<20110610133338.GD24636@n2100.arm.linux.org.uk>
	<BANLkTimZ=v4W1hFJ7hvZRmyHMSU_3MmZEA@mail.gmail.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9403020B7B37@dbde02.ent.ti.com>
Message-ID: <BANLkTik5KP1Ro4be1g9e-dqUxjsu4F_6=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/14 Raju, Sundaram <sundaram@ti.com>:

> Yes, the hardware can skip over sequences like that.
> I also thought about your suggestion, at first before submitting the RFC.
> But I dint pursue this because, this ioctl() call has to be made before
> every single prepare call.

It's not an ioctl(), ioctl()s would be expensive since they involve
userspace to kernelspace context switches. It is just "ioctl()-like".
It is a simple, fast function call.

> I may have to end up using this if we decide not to change the API
> signature for prepare APIs.

Is it really so bad? It is a custom configuration after all. Even if
there were many DMACs out there supporting it, we'd probably
model it like this, just pass something like DMA_STRIDE_CONFIG
instead of something named after a specific slave controller.

This way DMACs that didn't support striding could NACK a
transfer for device drivers requesting it and then it could figure
out what to do.

If we can get some indication as to whether more DMACs can
do this kind of stuff, we'd maybe like to introduce
DMA_STRIDE_CONFIG already now.

Thanks,
Linus Walleij

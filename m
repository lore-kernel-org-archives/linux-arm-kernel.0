From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 31 Mar 2011 19:36:33 -0500
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
In-Reply-To: <20110331082601.GV7285@pengutronix.de>
References: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
	<20110330073651.GR7285@pengutronix.de>
	<AANLkTikf63wTfM1z2cpV+GuK28y1wrT7UWvw4TanBj4R@mail.gmail.com>
	<20110331082601.GV7285@pengutronix.de>
Message-ID: <AANLkTi=x=E2mSqFC-r7vC1hGBL+rJJ=XNWEY6a_UT-nE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a plan to port it to DRM, We even started for it. But it needs
to work first, so we can get our reference on. Ports like this are
best done slowly - you make it work, you do it piece by piece. We
already did the GEM allocation and unified IPU and GPU memory
allocation (after all framebuffer memory *is* texture memory on every
other graphics card and the IPU/VPU/GPU need to be able to access each
other's memory - they all share an EMI/AXI arbiter anyway). That in
itself allows us to lock down the GPU using the AMD MMU which defines
a 32MB-aligned window which the GPU can write into (otherwise the GPU
can touch system memory). Then we just need to do the command stream
stuff and properly port the IPU framebuffer to DRM Connectors and
Encoders, so XRandR will magically work, we can stop using fbdevhw
evil, and so on.

Since this code is all GPL anyway, there is no contention here.

Of course, what you get out of that is an awesome opensource DRM
driver with no userspace at all...

And we'd provide a closed source one, but leave it open for anyone to
reverse engineer it: not our problem, after all. We can't do it
ourselves though, we are under NDA, and the team of lawyers required
to coordinate Qualcomm, AMD, Freescale and whatever other vestiges
(nVidia owns one of the companies which contributed to the reference
implementation used) is probably going to have to be larger than the
development base of Linux kernel itself with all it's subsystems and
take 5 years to complete.

What it is, is simply not worth arguing about; all this is going to do
is allocate memory for the GPU, so other users (and our porting
effort) get easier. We'll add a "user" of the API later. Maybe a
simple 2D command stream thing. We gotta get this in first though, I'd
rather not delay as it means simply that: a delay.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.



On Thu, Mar 31, 2011 at 3:26 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Mar 30, 2011 at 05:23:12PM -0500, Matt Sealey wrote:
>> Sascha,
>>
>> Freescale has a driver. We have a driver since we're under NDA and
>> have the source.
>>
>> If you want it and want to boot Ubuntu on a Smartbook or Smarttop, we
>> can give you a package that will run on our kernel and load the GPU
>> module if present (we actually ship it as a module built inside the
>> kernel, it's not external and it's dual BSD/GPL licensed). Regardless
>> of where you've not seen it, it does exist. I want this code in there
>> - on the basis that we have a consumer product that ships and needs
>> it, and this is going to be a dependency for OpenGL, OpenVG, and
>> things on top like Flash which may depend on that.
>>
>> I dunno if I am in the "path" for this since I have the source code
>> for the driver for the kernel (it's on opensource.freescale.com/git in
>> drivers/mxc/amd-gpu somewhere after the 09.12 BSP ) and for the
>> userspace (it's NDA code) I don't believe there's any hard and fast
>> policy that says the kernel cannot have drivers referenced that are
>> not part of the mainline stack, otherwise no external module using USB
>> or any other pluggable module built externally, which Linus does not
>> disapprove of, would never be allowed to build against the kernel.
>
> With USB there is a clear API defined and exported from the kernel to
> userspace. This API can be used from source and yes, also from closed
> source drivers.
> The FSL gpu driver is different, its API has been defined for only one
> closed source driver. There is no way of making use of it without closed
> source. There is no way for kernel maintainers to test this API without
> closed source. There is also no way to ever change this API without
> having the source available.
> No, there is no place for this kind of stub drivers in the kernel.
> Otherwise we would also have nvidia binary driver stubs.
>
> In any way we can delay this until there is some code using it.
>
> Sascha
>
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 2 May 2018 16:19:35 +0200
Subject: [PATCH] gpio: zynq: Setup chip->base based on alias ID
In-Reply-To: <CACRpkdaNJzW+LO97oxavzYJwfkj0xu7wxTNRaGiaKm98ON5JMA@mail.gmail.com>
References: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
 <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
 <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
 <CACRpkdaxwRc0zoDKogVGisXTPJ0EwLbOQjHzz1pSEjvWCsSCTQ@mail.gmail.com>
 <cc8d864a-e8e6-d30d-ae54-91819e5d0b8d@xilinx.com>
 <CACRpkdYgw+HaC5bUCZKiD7j+2ZLYbCTG+DdPdAEkRDq0xF5b3w@mail.gmail.com>
 <60652f48-2a98-414b-5cff-25890a6da37f@xilinx.com>
 <CACRpkdaNJzW+LO97oxavzYJwfkj0xu7wxTNRaGiaKm98ON5JMA@mail.gmail.com>
Message-ID: <57e4bbdd-1e30-0352-f758-998b64a6b77f@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2.5.2018 15:56, Linus Walleij wrote:
> On Wed, May 2, 2018 at 3:41 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
>> If you don't want this patch I understand that and it will become just
>> another soc vendor patch out of mainline.
> 
> I don't really know what to do, so that is why I'm discussing.

me too. It is also interesting that I have met with the case with
zynq/zynqmp gpio driver and not gpio-xilinx.c which can have a lot of
instances.

> 
> It's one of those gray areas.
> 
> From one point of view there is the purist stance that we should
> only support what the mainline tree does, and be strict and
> consistent so we don't accumulate to many nasty hacks.

Also this expect that the first patch does everything right which is not
truth all the time.

> 
> On the other hand, it is completely possible that all users of this
> particular driver actually must have this patch, and then I just
> push them to use a deviant vendor tree for no good reason.
> 
> Would it be possible that I apply the patch, and somehow also
> establish some understanding with all users of the Xilinx
> platform that whatever legacy applications are out there
> must start to migrate towards using the character device so
> this reliance on the numberspace doesn't stick around forever?

When someone contacts me for asking guidance for gpio I am telling them
not to use legacy sysfs interface and use libgpiod. Last one was a week
ago in connection to Ultra96 and libmraa.

But even chardev is not supported there now.
https://github.com/intel-iot-devkit/mraa/issues/713

> 
> For example can we make a patch to some systems like
> arch/arm/boot/dts/zynq-*.dts
> adding proper GPIO line names to these device trees, such
> as was made in e.g. commit f6b1674d570aa1
> "arm64: dts: qcom: sbc: Name GPIO lines"

If you take a look at
arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
which is Ultra96 board gpio-line-names are filled there for the whole PS
part. Definitely take a look and let know if you find out any issue there.

zynq/zynqmp gpio controller contains PS pins (hard part) and PL pins
coming to logic.

I can't describe PL gpio pins because it can be whatever even I have
done that for one fixed hw design.

Interesting part on that sha1 you shared is how "NC" pin is described.

gpio pin 35 I have on zcu100 as "" but it should be maybe TP_PAD which
is really just a pad on real board. And the rest of "" gpio names are
connected to PL.

I am happy to take a look at existing platforms and use gpio-line-names
there. For example arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
I use in tca6416_u97 and u61 comments instead of this property.

> 
> After all that is what I strive for as maintainer, as the IETF
> motto says:
> "rough consensus and running code"

Thanks,
Michal

From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 8 Jul 2014 08:55:52 -0700
Subject: [PATCH v2 1/2] gpio: Add driver for Zynq GPIO controller
In-Reply-To: <CACRpkdYSU6NdFuab6rJS7eADSqORNDBzbFfJ65nFoJj3EZVd-g@mail.gmail.com>
References: <1403091577-10232-1-git-send-email-harinik@xilinx.com>
 <5cc8b89b-20ff-4fa9-92dd-bb2f6d3512d8@BY2FFO11FD030.protection.gbl>
 <CACRpkdb1M3-hrSKLKWz21LCJ1sMvsq5E-aqkpmVhy0NwOS5HhA@mail.gmail.com>
 <d1af864d-bf78-48bb-a545-8de3f9def75f@BL2FFO11FD037.protection.gbl>
 <CACRpkdYSU6NdFuab6rJS7eADSqORNDBzbFfJ65nFoJj3EZVd-g@mail.gmail.com>
Message-ID: <3adb614c-38ae-4b0c-9e50-99f071bbf4c5@BL2FFO11FD038.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, 2014-07-08 at 11:34AM +0200, Linus Walleij wrote:
> On Mon, Jul 7, 2014 at 6:08 PM, S?ren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
> >> So: what is the usecase for these GPIOs?
> >
> > Yea, in this case it was a button. I have to look at these drivers. It's
> > very likely that they cover what I want. But this case is trivial. I
> > really don't do anything but enabling the IRQ by writing to the edge
> > attribute and press the push-button connected to that GPIO line.
> 
> In case of a system using device tree it is very trivial to add a gpio
> key binding. After compiling in the gpio keys driver this small
> snipper type is all that is really needed in most cases:
> 
>         /* User key mapped in as "escape" */
>         gpio-keys {
>                 compatible = "gpio-keys";
>                 user-button {
>                         label = "user_button";
>                         gpios = <&gpio0 3 0x1>;
>                         linux,code = <1>; /* KEY_ESC */
>                         gpio-key,wakeup;
>                 };
>         };

Thanks for the example. I think for my cases these drivers are exactly
the right thing.

> 
> 
> > But as a general note: I think we have quite some customers trying to do
> > GPIO in userspace.
> 
> For what? I mean the use cases. Usually it is a bad idea, and
> as shown above, just using the right existing device driver with
> device tree is much easier, also for an end user, given they know
> how to alter DTs and compile in kernel modules.
> 
> > With Zynq's FPGA portion, a lot of things come down
> > to make signals accessible in Linux and a lot of people do not want or
> > need a full blown kernel driver and use GPIO. The request for 'how to
> > handle GPIO IRQs in userspace' is pretty common. Often this gets passed
> > on to UIO though.
> 
> The short answer is don't handle GPIO IRQs in userspace.
> 
> Userspace drivers is generally a bad idea and should not be written.
> The kernel is intended to handle hardware.
> 
> The above is doubly true for anything involving IRQs. Just think
> of what IRQs are. They are one of the reasons why we have a
> kernel and not just write all software on a system from scratch
> ourselves.

I fully agree and you don't have to convince me. But to a lot of our
customers that are used to use FPGAs, SOCs and Linux are pretty new. You
see a lot of scary stuff. Accessing /dev/mem seems to be a lot of
people's big hammer solution for everything. Then I always perceive it
as great progress if things like the sysfs interface are used instead.

	Thanks,
	S?ren

From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 13 Feb 2015 19:33:53 +0100
Subject: [PATCH 0/7] ARM: berlin: refactor the clock
In-Reply-To: <20150213191928.20f79ebf@free-electrons.com>
References: <1423845781-7480-1-git-send-email-antoine.tenart@free-electrons.com>
 <20150213173121.GG26475@lunn.ch> <20150213191928.20f79ebf@free-electrons.com>
Message-ID: <54DE4391.4080207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.02.2015 19:19, Thomas Petazzoni wrote:
> On Fri, 13 Feb 2015 18:31:21 +0100, Andrew Lunn wrote:
>> Something which needs to be discussed for both this patchset and the
>> previous one, is backwards compatibility of the device tree.
>>
>> As far as i can see, these changes are not backwards compatible.
>> Somebody trying to boot a new kernel with a old DT blob is going to
>> have trouble.
>>
>> How do we want to handle this?
>
> I think one thing that should really be taken into account here is that
> we have basically no usable datasheet for those SoCs. We only have very
> partial datasheets, and only fairly a vendor kernel tree. This makes it
> nearly impossible to have from the start up a clear picture of the
> hardware layout and how it should be represented in the DT. Antoine,
> and I guess Sebastian as well, are discovering progressively the layout
> of the registers, their functionality, depending on the features that
> are enabled.

Yup, the situation with usable information on Berlin SoCs for me is
even worse. The only reliable source of information is the GPL'd vendor
kernels for two or three boards and some left-over includes describing
some of the register bits.

> The DT backward compatibility requirement essentially requires either:
>
>   * A very clear picture of the hardware from the beginning, so that we
>     can be pretty sure when designing the first DT binding, that it is
>     going to be alright. This is clearly not something we have for the
>     Marvell Berlin platforms.

It is not only the clear picture of the hardware but you'll have to
have the driver layout in mind, too. I know that DT shouldn't follow
any specific kernel or bootloader, but a lot of decisions that we make, 
e.g. where we cut registers into separate nodes, are constantly driven 
by some driver in mind.

>   * Keep vast amount of legacy code to support old DTs, which nobody is
>     every going to test, which means that such code is guaranteed to
>     bitrot within 2 or 3 kernel releases, if not earlier.

That is even more true for Berlin. Remember that any device available
comes with some secure boot chain thingy. Not many ppl take their board
apart immediately and even less if the risk to brick it is as high as
for the Berlin devices.

> Instead, since I believe at this point Marvell doesn't care about DT
> backward compatibility for its platforms, could we instead declare the

I doubt that it is even possible to have them close. All we can do is
work out a sane binding in mainline and wait for Marvell to pick it up.
They want a fully working kernel for their SoC _way_ before we even
made up our mind on the binding.

> DT bindings of this platform as "unstable", just like the AT91 guys did
> for their DT bindings
> (http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/arm/Atmel/README#n100) ?

Sounds like a plan.

Sebastian

From: dianders@chromium.org (Doug Anderson)
Date: Wed, 10 Sep 2014 09:45:21 -0700
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <CACxGe6uBcTPMh4p=oi7m_TVpjUrkgbQvxbStAn27HXEJxYe5fw@mail.gmail.com>
References: <540C7F5B.6070307@gmail.com> <540C83DE.10505@collabora.co.uk>
 <540C8577.2070907@gmail.com> <20140908112112.GK26030@arm.com>
 <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
 <CAD=FV=VAqzvJQDQMjjeQ1p5okyDzE=ff_sguObZxh59qbzcaTQ@mail.gmail.com>
 <CACxGe6t_ex1bU=CvTpXR4VJgNf1hAq33hr6ykbHy_sMXEk4h-g@mail.gmail.com>
 <CAOesGMipX3MV6sMWLuY=D+bQ6qe8P17YFbTFwZOHPeSc3Pw9Cg@mail.gmail.com>
 <20140910143144.GF7960@sirena.org.uk>
 <CACxGe6u=QkGTKGfaE_jJ5VFMhdVKQNggp3qVBUgNP7rDbZss_A@mail.gmail.com>
 <20140910153919.GH7960@sirena.org.uk>
 <CACxGe6uBcTPMh4p=oi7m_TVpjUrkgbQvxbStAn27HXEJxYe5fw@mail.gmail.com>
Message-ID: <CAD=FV=W0qQZF58AvF8kZW+z4CsfnruQZLw_TA-eGy3fUruLbcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

On Wed, Sep 10, 2014 at 9:29 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Wed, Sep 10, 2014 at 4:39 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Wed, Sep 10, 2014 at 03:56:16PM +0100, Grant Likely wrote:
>>> On Wed, Sep 10, 2014 at 3:31 PM, Mark Brown <broonie@kernel.org> wrote:
>>
>>> > As far as I can tell the problem here is coming from the decision to
>>> > have simplefb use resources without knowing about them - can we agree
>>> > that this is a bad idea?
>>
>>> No, I don't think we can... there is a certain amount of "firmware got
>>> things working for us, and we're going to use it for a while" that is
>>> absolutely reasonable. simplefb is a good example, but there are
>>> certainly others.
>>
>> That bit is fine - I definitely think it's reasonable to have things
>> like this where the device is initialized prior to the kernel starting
>> and we use some simplified subset.  What I think is a big problem here
>> is that we're not being told what parts of the system state are relevant
>> to this initialization (worse, we're being told things that are actively
>> wrong for some of the resources).  This seems inherently fragile.
>>
>>> I /do/ think it would be better for the simplefb data to get embedded
>>> or linked into the node of the graphics controller so that it can be
>>> torn down appropriately, and we need a rule for how long boot-state
>>> can be considered valid so that a proper driver can either reserve the
>>> resources for a given SoC, or do a full handoff from the simplefb.
>>> Even without that though, we need to be able to handle the case of an
>>> anonymous simplefb node with no regulator information. If that means
>>> the default simplefb behaviour is to inhibit runtime pm on all
>>> resources until a real driver show up, then that might just be what we
>>> need to do.
>>
>> I think saying that it's a good idea to have an simplefb node without
>> resource management is exactly the problem here - if we start from the
>> assumption that this is a good idea we do get dragged down this path but
>> it seems like we took a wrong turn going that way in the first place.
>>
>> It's not just regulators - we've got exactly the same problem with
>> clocks on this system for example, they're also getting disabled because
>> they seem unused and users have to pass in a kernel command line bodge
>> to avoid that.  We'd also have an issue if something decided to change
>> the rates of some of the clocks, and power domains have the same problem
>> (Ulf's patches to genericise their code has the same behaviour with
>> regard to powering off unused domains, some of the existing
>> implementations do that already).
>>
>>> Two things should probably be changed from the current setup. 1)
>>> simplefb shouldn't be a platform driver. It is a boot thing that
>>> handles initial state from the graphics chip. By implementing it as a
>>> platform driver, it prevents the real driver from binding to the real
>>> device if the simplefb data embedded into it. 2) make sure that an SoC
>>> driver can protect the needed resources before they are automatically
>>> disabled. Either by putting them in an earlier initcall, or handling
>>> it in the subsystem code. I don't know enough about the regulator and
>>> clock runtime PM to know what the best way to do this is.
>>
>> Right, I agree with what you're saying here but what I'm saying is that
>> the way to ensure that the resources are protected is for the simplefb
>> node to tell the kernel what resources are being used, otherwise it
>> seems like we're just guessing and will fall over ourselves sooner or
>> later.
>>
>> We can't use initcall hacks as these only work in cases where we will at
>> some point hand over to a real driver and there seems to be a clear use
>> case for using simplefb prior to that driver being written; even where
>> we will hand over to a real driver we can't put a definite timescale on
>> that happening since in the distro case it might be being loaded from
>> disk at some point after userspace is running.
>
> What we can do is have an inhibit flag for
> simplefb/simpleuart/simplewhatever that holds off PM. When a real
> driver, or a stub that understands parsing the resource dependencies,
> takes ownership of the device (or userspace tells the kernel to stop
> caring) it can clear the inhibit.

This doesn't seem crazy, though it means that if you're planning on
using nothing but simplefb then you're never going to be able to get
any power savings anywhere.

Right now I know that clock disabling is supposed to be inhibited
during the early boot process.  I think regulators too?


> I don't want to build knowledge of resource dependencies into the
> simple case. We'll simply frequently get it wrong. For example: A
> future kernel will have better PM and will turn off more devices which
> isn't accounted for in an older DT.

In IRC I made a suggestion that perhaps the "simplefb" ought to be put
in the main in-kernel "dts" file but with no address information and
set to "disabled".  Then the firmware can do something very simple:
set to enabled and fill in the address.

Right now the firmware is taking a dts that it doesn't really own (it
grabs it from the kernel FIT image) and making changes to it to add
simplefb.  That's inherently pretty fragile.  If the kernel DTS file
adds regulators then as we saw things break.  I can imagine lots of
other breakages, too.  If the dts is in kernel then we can add
regulator / clock references very easily.  As regulators are added to
the kernel dts file then the references can be added to simplefb.

That doesn't solve the problem with people who have old copies of
U-Boot.  All of those people have already flashed a custom firmware
though, so it doesn't seem unreasonable (to me) to solve their problem
by giving them a new custom firmware.  I agree that something needs to
be done to help those people, but I don't feel like adding extra hacks
to the kernel is the right answer to solve people who are clearly
living on the bleeding edge.


Note that I haven't actually worked with simplefb or the custom
U-Boots, so perhaps there's something I'm missing...

-Doug

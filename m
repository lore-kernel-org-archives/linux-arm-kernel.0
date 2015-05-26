From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 26 May 2015 19:53:33 +0200
Subject: [PATCH 10/21] regulator: core: Probe regulators on demand
In-Reply-To: <20150526165458.GV21577@sirena.org.uk>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-11-git-send-email-tomeu.vizoso@collabora.com>
 <20150525173244.GE21577@sirena.org.uk>
 <CAAObsKDzKzYAx4_xsNm0reXzgSrJi7Q+aZGifmVxvSEQ=Qxjkw@mail.gmail.com>
 <20150526093601.GH21577@sirena.org.uk>
 <CAAObsKA_59z0qYmUqux7dMO38vOrLBUM_eWZ-QeJxEEmunq2ZQ@mail.gmail.com>
 <20150526165458.GV21577@sirena.org.uk>
Message-ID: <CAAObsKDDMxHPH+QB+SAPUwVa3WGrud61F+_ToB1mrY_FyFfZYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 May 2015 at 18:54, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 26, 2015 at 05:08:38PM +0200, Tomeu Vizoso wrote:
>> On 26 May 2015 at 11:36, Mark Brown <broonie@kernel.org> wrote:
>
>> > Yes, x86 based embedded systems use ACPI (and we really ought to be
>> > trying to help systems using board files too for that matter).
>
>> Yes, I see how registering devices on-demand could be implemented for
>> all those, but what I don't see is how they would benefit from it.
>
> You'd need to be clearer about what problem you're trying to solve
> there, which is something you left us guessing at!
>
>> I can see an hypothetical maintenance benefit in sharing as much code
>> as possible between these different scenarios, but in this case,
>> because this feature is so closely tied to machine description I think
>> complexity would be actually bigger.
>
> We've now got abstractions for common firmware operations (look at the
> fwnode stuff) and this isn't exactly deep introspection here.
>
> If you're trying to solve the probe order problem you can probably get a
> long way by just doing something that boils down to "try to instantiate
> everything referenced from this node" which could probably even be
> kicked from the driver core prior to probe and cover most cases.  Or put
> this into the node lookup interface so we try to instantiate everything
> we reference.
>
>> On machines that have ACPI, most of those devices aren't exposed to
>> the kernel and few or no deferred probes happen (though I have only
>> tested on qemu and Minnowboard MAX, both with no deferred probes).
>
> On the machines that you happen to have looked at; I would rather expect
> that x86 based phones will be in a similar situation once they move to
> ACPI which they should be doing this year if they didn't already, and
> the embedded systems will doubtless run into this once they have any
> meaningful hardware on them (the base Minnoboard isn't really
> interesting here, it's once you build a system on top of that).
>
>> On machines with board files, devices are registered in a
>> predetermined order, presumably without any deferred probes.
>
> No, not in the least.  Quite aside from anything else as soon as you
> allow things to be built as modules userspace is free to load things in
> whatever order amuses it.  Think about what's going on here - it's not
> just registration of devices, it's also about the order in which
> subsystems and drivers register themselves.
>
>> My understanding is that the problem I'm addressing is specific of
>> machines in which the kernel is in charge of pretty much everything
>> and that the information about what devices are present is given in an
>> arbitrary order.
>
> I don't think you've fully understood the problem space here.

Fair enough, what's your understanding of it?

Thanks,

Tomeu

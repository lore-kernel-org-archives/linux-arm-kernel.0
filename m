From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 26 May 2015 17:08:38 +0200
Subject: [PATCH 10/21] regulator: core: Probe regulators on demand
In-Reply-To: <20150526093601.GH21577@sirena.org.uk>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-11-git-send-email-tomeu.vizoso@collabora.com>
 <20150525173244.GE21577@sirena.org.uk>
 <CAAObsKDzKzYAx4_xsNm0reXzgSrJi7Q+aZGifmVxvSEQ=Qxjkw@mail.gmail.com>
 <20150526093601.GH21577@sirena.org.uk>
Message-ID: <CAAObsKA_59z0qYmUqux7dMO38vOrLBUM_eWZ-QeJxEEmunq2ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 May 2015 at 11:36, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 26, 2015 at 08:17:23AM +0200, Tomeu Vizoso wrote:
>> On 25 May 2015 at 19:32, Mark Brown <broonie@kernel.org> wrote:
>
>> > The obvious questions here based on the name are why we're doing
>> > something specific to platform devices and why this isn't something
>> > we're abstracting in the driver core (or at least generic firmware code)
>> > - we're going to have the same thing with ACPI.
>
>> I don't know how useful this is going to be in systems with ACPI. My
>> experience is limited to 32bit ARM, where the kernel has to manage
>> every regulator, clock, gpio, etc so the dependency tree is so big. Is
>> deferred probing a problem with ACPI as well?
>
> Yes, x86 based embedded systems use ACPI (and we really ought to be
> trying to help systems using board files too for that matter).

Yes, I see how registering devices on-demand could be implemented for
all those, but what I don't see is how they would benefit from it.

I can see an hypothetical maintenance benefit in sharing as much code
as possible between these different scenarios, but in this case,
because this feature is so closely tied to machine description I think
complexity would be actually bigger.

The problem I'm trying to address only manifests on systems with
dozens of devices that are currently registered in an arbitrary order
(as they are in the DT).

On machines that have ACPI, most of those devices aren't exposed to
the kernel and few or no deferred probes happen (though I have only
tested on qemu and Minnowboard MAX, both with no deferred probes).

On machines with board files, devices are registered in a
predetermined order, presumably without any deferred probes.

My understanding is that the problem I'm addressing is specific of
machines in which the kernel is in charge of pretty much everything
and that the information about what devices are present is given in an
arbitrary order.

Deferred probe gives us reliably a working system at the end for these
machines, but in the meantime some devices will have been deferred
several times and when they get to probe the user will have noticed
the delay.

Regards,

Tomeu

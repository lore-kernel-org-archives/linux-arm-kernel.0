From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 14 May 2012 16:13:36 +0900
Subject: [GIT PULL] Renesas ARM-based platforms: new boards support for
 v3.5
In-Reply-To: <CAOesGMj5op-U+-_dvP_cqMUQ7zgzbzvig2ueb2LQTf+4MSEc2Q@mail.gmail.com>
References: <201205112101.59949.rjw@sisk.pl>
 <CAOesGMgFWM6K6969Oz6xGewrRekyrJA-ztGBADxsqnB1w=V2QA@mail.gmail.com>
 <201205122307.20590.rjw@sisk.pl> <201205122323.14967.rjw@sisk.pl>
 <CAOesGMj5op-U+-_dvP_cqMUQ7zgzbzvig2ueb2LQTf+4MSEc2Q@mail.gmail.com>
Message-ID: <CANqRtoQTMKdKmATz5uxCtWaZcEPa2apt9WO4URdhiwEMnst5gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2012 at 3:29 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, May 12, 2012 at 2:23 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> Hi,
>>
>> Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3
>>
>> ? ?Linux 3.4-rc6
>>
>> with top-most commit a515be1ca7df947db0f6018a174f49507affcdbc
>>
>> ? ?Merge branch 'renesas-kzm9g' into renesas-board-new
>>
>> from the git repository at:
>>
>> ?git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git board-new
>>
>> to receive updates of the Renesas ARM-based boards support code for v3.5.
>> Included are:
>>
>> ?* Support for the KZM-A9-GT board from Kuninori Morimoto.
>>
>> ?* Support for the armadillo800eva board from Kuninori Morimoto.
>>
>> This is based on the Renesas core SoC code updates I've sent a separate pull
>> request for.
>
>
> Hi Rafael and Magnus,

Hej Olof!

> I know Renesas is very active in adding support for new ARM platforms
> upstream, and that's great. But we also need to figure out how it can
> best be done while still keeping a bound on platform complexity.
>
> This adds two new board files and two new defconfigs to the arm
> subtree. We have in general said that we are OK with the occasional
> new board file if the vendor is actively working on reducing the rest
> of the subdirectory contents and consolidating over into device tree
> based platforms. But we have also agreed that new (v7+) SoCs/boards
> should be targeting DT board files from introduction nowadays.
>
> Both these SoCs and boards seem to be A9-based, so they would match
> that requirement.

First of all, I'm glad to hear that you are positive to our work. This
means a lot to us. I personally agree with the DT direction and to
move things along we are multiple people working on improving both our
own situation (drivers, soc) and infrastructure that everyone in the
kernel community can use (PM, kexec). So I believe we are doing our
fair share there. At the same time we also need to provide some kind
of base code that is working as-is.

Regarding the new boards, you are correct that they are using Cortex
A9. I'm not sure if your policy considers other IP that is tied to the
ARM block, but in our case we have custom interrupt controllers. On
r8a7740 it's a A9 with our INTC used instead of the GIC, and on sh73a0
we make use of the GIC but we have our own cascaded interrupt
controllers. Unfortunately we don't have any long term DT solution
ready. I wrote a prototype myself to get other people started, but the
long term part is still being worked on by Paul Mundt - this since we
share the interrupt controller code with the SH architecture.

> The good news is that meeting the basic requirements for device tree
> probing is easy; using a DT_MACHINE_START() stanza and adding a small
> dts file is really all it takes for the real simple case. Building a
> zImage with the device tree appended (and ARM_ATAG_DTB_COMPAT=y) means
> you can use the same firmware as before and not modify it to handle
> device trees, if that is a limitation you have for your environments.

I'd be happy to add a DT_MACHINE_START() implementation for each SoC
if that make it easier for you guys to merge our code. From a
usability point of view, I'm quite certain that all our U-boot based
boards take uImages instead of zImage as kernel image format. I prefer
zImage myself, but unfortunately it is not my call.

I believe an uImage on ARM is basically a wrapped zImage.
Unfortunately I have not been able to find some simple way of
including DTB in the uImage. So to be able to use these kernels on our
existing boards that take uImage it seems that I will have to patch
the kernel locally somehow? I am fine using ARM_ATAG_DTB_COMPAT=y
during development - actually it is my preferred way - but I'm not so
comfortable asking our customers to patch their kernel source just to
be able to build an uImage.

Do you have any recommendation for me?

> Also, I would prefer to only see one or a couple of defconfigs that
> can provide full build coverage for the various SoCs and boards, that
> would contain the superset of the required drivers to boot the
> supported boards, etc.

I can check with my superiors if we can phase our sh7367 support. If
so then we have only A8 and A9 in tree which should be easy to support
with a single kernel configuration. Does that sound like something
that would simplify things for you?

> So, I'm going to hold off pulling in this branch right now until we
> can sort out some of the above items.

Ok. When can we retry?

Thanks,

/ magnus

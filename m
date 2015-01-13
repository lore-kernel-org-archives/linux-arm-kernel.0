From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 13 Jan 2015 17:02:37 +0000
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <20150112142358.GA23680@amd>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
 <CACxGe6vRN2Tc97=Sx05gri02goxBaHnZm30hR37q=002agFLAA@mail.gmail.com>
 <CACxGe6sbGu53x5rsx2sWVVVVCnnFvmkQAk3Se9ZGNOXCkqpi=A@mail.gmail.com>
 <20150112142358.GA23680@amd>
Message-ID: <CACxGe6upNdAx7aAVMK7n_pSiEjBk4CzufaKQw-p9u+ccyn+irA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

For the sake of argument, I'll respond to your points below, even
though we fundamentally disagree on what is required for a general
purpose server...

On Mon, Jan 12, 2015 at 2:23 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Sat 2015-01-10 14:44:02, Grant Likely wrote:
> Grant Likely published article about ACPI and ARM at
>
> http://www.secretlab.ca/archives/151
>
> . He acknowledges systems with ACPI are harder to debug, but because
> Microsoft says so, we have to use ACPI (basically).
>
> I believe doing wrong technical choice "because Microsoft says so" is
> a wrong thing to do.
>
> Yes, ACPI gives more flexibility to hardware vendors. Imagine
> replacing block devices with interpretted bytecode coming from
> ROM. That is obviously bad, right? Why is it good for power
> management?
>
> It is not.
>

Trying to equate a block driver with the things that are done by ACPI
is a pretty big stretch. It doesn't even come close to the same level
of complexity. ACPI is merely the glue between the OS and the
behaviour of the HW & FW. (e.g. On platform A, the rfkill switch is a
GPIO, but on platform B it is an i2c transaction to a
microcontroller). There are lots of these little details on modern
hardware, and most of them are pretty trivial aside from the fact that
support requires either a kernel change (for every supported OS) or
something like ACPI.

You just need to look at the x86 market to see that huge drivers in
ACPI generally doesn't happen. In fact, aside from the high profile
bad examples (we all like to watch a good scandal) the x86 market
works really well.

> Besides being harder to debug, there are more disadvantages:
>
> * Size, speed and complexity disadvantage of bytecode interpretter in
> the kernel.

The bytecode interpreter has been in the kernel for years. It works,
It isn't on the hot path for computing power, and it meets the
requirement for abstraction between the kernel and the platform.

> * Many more drivers. Imagine GPIO       switch, controlling rfkill
>   (for
>   example). In device tree case, that's few lines in the .dts
>   specifying
>   which GPIO that switch is on.
>
> In ACPI case, each hardware vendor initially implements rfkill switch
> in AML, differently. After few years, each vendor implements
> (different) kernel<->AML interface for querying   rfkill state and
> toggling it in software. Few years after that, we implement kernel
> drivers for those AML interfaces, to properly integrate     them in
> the
> kernel.

I don't know what you're trying to argue here. If an AML interface
works, we never bother with writing direct kernel support for it. Most
of the time it works. When it doesn't, we write a quirk in the driver
and move on.

> * Incompatibility. ARM servers will now be very different from other
> ARM systems.

If anything, ARM servers are an extension of the existing x86 server
market, not any of the existing ARM markets. They don't look like
mobile, and they don't look like embedded. The fact that the OS
vendors and the HW vendors are independent companies completely
changes how this hardware gets supported. The x86 market has figured
this out and that is a big reason why it is able to scale to the size
it has. ACPI is a direct result of what that kind of market needs.

> Now, are there some arguments for ACPI? Yes -- it allows hw vendors to
> hack half-working drivers without touching kernel
> sources. (Half-working: such drivers are not properly integrated in
> all the various subsystems).

That's an unsubstantiated claim. ACPI defines a model for the fiddly
bits around the edges to be implemented by the platform, and performed
under /kernel/ control, without requiring the kernel to explicitly
have code for each and every possibility. It is a very good
abstraction from that point of view.

> Grant claims that power management is
> somehow special, and requirement for real drivers is somehow ok for
> normal drivers (block, video), but not for power management. Now,
> getting driver merged into the kernel does not take that long -- less
> than half a year if you know what you are doing. Plus, for power
> management, you can really just initialize hardware in the bootloader
> (into working but not optimal state). But basic drivers are likely to
> merged fast, and then you'll just have to supply DT tables.

The reality doesn't play out with the scenario you're describing. We
have two major mass markets in the Linux world; Mobile and general
purpose computing. For mobile, we have yet to have a device on the
market that is well supported at launch by mainline. Vendors ship
their own kernel because they only support a single OS, and we haven't
figured out how to support their hardware at launch time (there is
plenty of blame to go around on this issue; regardless of who is to
blame, it is still a problem). The current mobile model doesn't even
remotely address the needs of server vendors and traditional Linux
distributions.

The general purpose (or in this case, the server subset), is the only
place where there is a large ecosystem of independent hardware and OS
vendors. For all the complaints about technical problems, the existing
x86 architecture using ACPI works well and it has spawned an awful lot
of very interesting hardware.

...

Personally, I think ACPI is the wrong thing to be getting upset over.
Even supposing ACPI was rejected, it doesn't say anything about
firmware that is completely out of visibility of the kernel. Both ARM
and x86 CPUs have secure modes that are the domain of firmware, not
the kernel, and have basically free reign on the machine.

ACPI on the other hand can be inspected. We know when the interpreter
is running, because the kernel controls it. We can extract and
decompile the ACPI tables. It isn't quite the hidden black box that
the rhetoric against ACPI claims it to be.

If you really want to challenge the industry, then push for vendors to
open source and upstream their firmware. Heck, all the necessary
building blocks are already open sourced in the Tianocore and ARM
Trusted Firmware projects. This would actually improve the visibility
and auditing of the platform behaviour. The really invisible stuff is
there, not in ACPI, and believe me, if ACPI (or similar) isn't
available then the vendors will be stuffing even more into firmware
than they are now.

g.

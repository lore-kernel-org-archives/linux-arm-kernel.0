From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 1 Aug 2013 16:04:16 -0500
Subject: [PATCH 1/7] dt: update PSCI binding documentation for v0.2
In-Reply-To: <CAL_JsqJ9khcUvdB7hkKyAyFJtbZmytk6NY+trGTjC265JJPXDQ@mail.gmail.com>
References: <20130730094920.GC28716@e106331-lin.cambridge.arm.com>
 <51F7B4C9.2060500@gmail.com>
 <20130730125650.GD28716@e106331-lin.cambridge.arm.com>
 <20130730134427.GE28716@e106331-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1307301528540.4893@kaball.uk.xensource.com>
 <1375195354.32691.55.camel@kazak.uk.xensource.com>
 <CAHCPf3vUA1bD+1xPch-KZX6fdDzxsWjnVpUD39AKC=ds+EKeHQ@mail.gmail.com>
 <20130731134917.GN29859@e106331-lin.cambridge.arm.com>
 <CAHCPf3svo2q3oCJFzGvU_EKrtvUgAzEgObaXc6aZw7AhuumePg@mail.gmail.com>
 <51F94E20.7020904@gmail.com>
 <20130801175106.GA19325@localhost.localdomain>
 <CAL_JsqJ9khcUvdB7hkKyAyFJtbZmytk6NY+trGTjC265JJPXDQ@mail.gmail.com>
Message-ID: <CAHCPf3ukWVO+=J8tZv7zLWiA=B5SbtWMgESHizmUKsPsuQdHDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>On Thu, Aug 1, 2013 at 2:02 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Aug 1, 2013 at 12:51 PM, Dave Martin <Dave.Martin@arm.com> wrote:
>> On Wed, Jul 31, 2013 at 12:49:20PM -0500, Rob Herring wrote:
>>> On 07/31/2013 12:24 PM, Matt Sealey wrote:
>>> > On Wed, Jul 31, 2013 at 8:49 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>
>>> [snip]
>>>
>>
>> The DT is about description, not policy.  If multiple usable flavours of
>> the PSCI interface exist, then they exist, and there's no special reason
>> to hide one of them from the DT that I can see.
>>
>> I take the point that we shouldn't describe useless or redundant
>> information for no good reason, though.

Good, that's the point I was trying to get across ;)

Ideally though, the DT describes what is there to be used, not what is
just there. If we had DT describing an entire SoC, on most of them
half of it would be redundant, disabled devices which cannot be muxed
out simultaneously with the active ones. There aren't many reasons to
do so (and electrically, very few ways you can even do it at runtime
anyway for the vast majority of things).

What I am trying to figure out is if someone implements PSCI 0.1, 0.2
or some future version, then the device tree could explain those - one
for each version. As Rob pointed out, you can status=disabled the ones
you don't want people to use (or, leave them all in...). Maybe the
idea here would be not to version the compatible property but use
"model" (standard property!) for the version of PSCI, or an encoded
version. If you parse PSCI nodes and find a 0.2 node, initialize it..
then stop looking. If your secure monitor guys didn't implement all of
PSCI 0.2 you should never have defined a node for it in the first
place. It's not useful to half-describe something in the device tree -
device trees are meant to remove the guesswork of just having some
chip and some firmware interface, and simplify finding and using the
correct functional blocks and interfaces.

I can't imagine a situation where someone would implement half of PSCI
0.2 and fall back to PSCI 0.1 in another node for other functions..

.. or implement half 32-bit and half 64-bit functions for a system,
except at the point PSCI specifically falls down in that (PSCI 0.2
p5.4.1);.

"""The SMC calling convention [4], provides support for calls using
only 32-bit parameters (SMC32), and for calls using 32 and 64-bit
parameters (SMC64). Some of the PSCI functions defined above use only
SMC32, some of the functions have both an SMC32 and an SMC64 version.

For PSCI functions that use only 32-bit parameters, the arguments are
passed in R0 to R3 (AArch32) or W0 to W3 (AArch64), with return values
in R0 or W0.

For versions using 64-bit parameters, the arguments are passed in X0
to X3, with return values in X0/W0 (depending on the return parameter
size)."""

Yes, some of them aren't defined as smc64 functions. This sooooo needs
to be fixed for PSCI 0.3.. in essence the spec implies that 64-bit
variants are a second cousin twice removed of the really important
32-bit ABI. The spec itself dictates that the function IDs are
identical except for the magic 64-bit 'bit'.

>> Wouldn't a hypervisor always rip out and replace PSCI node(s) with
>> its own?  Allowing the firmware's PSCI interface to "show through" to a
>> guest VM sounds unwise.
>
> Perhaps. Minimally, the hypervisor could just replace smc with hvc for
> the method.

And that would be a special case for the hypervisor. Since the calling
convention is *identical* apart from the instruction that causes that
privilege level jump, this is quite easily afforded by the
implementation.

I still think that, as documented, hypervisors should just trap smc as
the way in. It may be a pain in the backside to decode the immediate
value, but this all got discussed and changed with syscalls and svc
anyway a long while back - that immediate value is a monster and since
there are some defined for very specific vendor interfaces (like
semi-hosting) it is unwise to even use it in case some other magic
firmware/debug/emulation process decides it is going to override your
trap and go do something else than you intended. I don't think the smc
calling convention really takes that into account, it just assumes
you're trustworthy enough to not implement things like that and take
it all into account. PSCI actually recommends you use 0 for that
immediate value..

Same section as above:

"""In line with the SMC calling convention, the immediate value used
with an SMC instruction must be 0.

ARM recommends that a hypervisor providing a PSCI functions through an
HVC conduit uses the same approach to the immediate value and
parameter passing. This aids the generalization of client code."""

So, no need to decode smc #imm4, just do what it says in the
registers. And no need for a Xen DomU to know it is even under a
hypervisor, either, by having special code to cover the case.

For what a particular hypervisor needs to do, if it intends to run on
ARM, it should be tending to use a particular range of SMC function
IDs (OEM services?) which are in any event going to be hypervisor
specific anyway (Xen, QEMU, OKL4, whatever) and PSCI specifically
keeps well away from them..

>> I'm not sure why having multiple nodes makes this easier.
>>
>> Having two nodes just moves information around.  Does it really simplify
>> anything?
>
> You can add 'status = "disabled";' easily and have it apply to the
> whole node. Also, if you split-up by method, then it is clear which
> properties apply to which method. I don't really care for the <none>,
> -32 and -64 distinction on function ID properties.
>
>> With the multiple nodes approach, you might actually need 3 nodes if
>> you are providing backwards compatible support for psci-0.1 callers: one
>> for psci-0.2 32-bit, one for psci-0.2 64-bit, and one for psci-0.1.
>> Maybe not though ... I'd have to think about it a bit more.
>
> I'd hope we can transition away from psci-0.1. The things that rely on
> it are not really mature anyway.

Right, but I have to agree with Mark that backwards compatibility is a
key concept here too. It can be left in - if you supply psci-0.2
nodes, new kernels that support it can use those. Older kernels will
find the older nodes and keep working. Even newer kernels with even
newer nodes will use those.. in my opinion it shouldn't bind to
psci-0.3 and psci-0.2 at the same time, though, and the trade-off is
at the vendor level. If you want to have psci-0.2 ONLY, then they'd
have to either provide patches for older kernels or just put a lower
limit on the version you support.

The whole "there are 64-bit functions but some of them aren't" thing
is just a mess waiting to happen, though. Who's responsible for the
spec? :D

-- Matt

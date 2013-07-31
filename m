From: neko@bakuhatsu.net (Matt Sealey)
Date: Wed, 31 Jul 2013 12:24:20 -0500
Subject: [PATCH 1/7] dt: update PSCI binding documentation for v0.2
In-Reply-To: <20130731134917.GN29859@e106331-lin.cambridge.arm.com>
References: <20130730094920.GC28716@e106331-lin.cambridge.arm.com>
 <51F7B4C9.2060500@gmail.com>
 <20130730125650.GD28716@e106331-lin.cambridge.arm.com>
 <20130730134427.GE28716@e106331-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1307301528540.4893@kaball.uk.xensource.com>
 <1375195354.32691.55.camel@kazak.uk.xensource.com>
 <CAHCPf3vUA1bD+1xPch-KZX6fdDzxsWjnVpUD39AKC=ds+EKeHQ@mail.gmail.com>
 <20130731134917.GN29859@e106331-lin.cambridge.arm.com>
Message-ID: <CAHCPf3svo2q3oCJFzGvU_EKrtvUgAzEgObaXc6aZw7AhuumePg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 8:49 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>
> If we force the use of said bit, then new kernels cannot necessarily
> work on existing PSCI implementations (which may not handle the use of
> said bit as you expect). If we make the binding for psci-0.2 explicitly
> require the use of this bit, then future firmware/virtualisation code
> cannot provide new functionality withoot breaking backwards compatiblity
> with existing kernels, as an "arm,psci-0.2" node would be incompatible
> with an "arm,psci" node (which is all an existing kernel can handle).

Okay so fighting backwards compatibility.. what I wasn''t suggesting
was just giving bits and then knowing what the function type was from
the bit - the SMC ABI in play calls that shot. But you don't need to
(Rob's suggestion) supply two function ids for each in one property or
provide two properties for each function variant in the same node.
Doesn't that complicate parsing a little too much?

>> * An AArch64 guest under an AArch32 hypervisor/sm seems pretty weird
>> and in any case, the device tree would use the 32-bit convention (any
>> SMC64 call in 32-bit state should return "Unknown SMC Function
>> Identifier" if that bit is set)
>
> This is not allowed by the architecture.

Understood..

>> * An AArch32 guest under an AArch32  hypervisor/sm would use the
>> 32-bit convention
>> * An AArch32 guest under an AArch64 hypervisor/sm would use the 32-bit
>> convention
>
> Both of these cases are trivially mandated by the architecture.
>
>> * An AArch64 guest under an AArch64 hypervisor/sm would use the 64-bit
>> convention or the 32-bit convention depending on how the sm is
>> written, but it doesn't matter which is used if both can be
>> supported.. but you'd only want to use one of them.
>
> Not all implementation will implement both, so there needs to be a way
> to describe that. Which is actually used is up to the OS.

Okay but putting both ways in a single node, and describing two
function ids (per property or with two properties) is what I was
getting at.. for the one case where you can use both at once, the
device tree description is king here.

I am a little concerned that the support for this is going down the
route of telling the OS all possible ways to do the same thing instead
of trying to get into using a single, preferred way in the common
cases.

Putting both call methods in the same node, doubling the function id
property lengths, or suffixing function id properties to do it seems
like putting information in the tree purely for the sake of it. In
what cases would it (uncommon cases only being existing, pre-PCSI
pre-SMC-conventions potentially for other things). In the case of PSCI
there's an opportunity to be strict about it.. why would it be sane to
allow a mixed implementation? Dictate that either support all the
64-bit versions or all the 32-bit versions or both? And if both are
supported, dictate in the device tree which the OS should be using.

What about having two nodes? There is nothing in device trees that
says you can't have two psci { compatible="arm,psci-0.2" } nodes, one
with method=smc and one with method=smc64 or hvc64 or what have you.
Parsing and setup of the PSCI code can be quit early if it's not the
"desirable" method for the OS (i.e. 64-bit on a 32-bit kernel). Then
each node follows the exact same definition, and the differentiator is
the call method and not the property names or complicating their
contents.

> As far as I can tell, no-one was arguing against this strategy. However,
> for those cases where functionality is implemented for only one
> register-width, or requires a different ID per register-width, this
> needs to be described somehow.

Do implementations like this really exist and who do we need to
waterboard to make them stop doing it? :)

-- 
Matt

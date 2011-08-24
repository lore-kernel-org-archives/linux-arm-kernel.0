From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Aug 2011 13:43:27 +0200
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20110823174203.GI3895@n2100.arm.linux.org.uk>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
	<20110823174203.GI3895@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbmqYQsxFRf7V6bDMMMgGnkHVr6JSZDVxX_j3ea+X8_Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 7:42 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Aug 23, 2011 at 06:17:04PM +0100, Catalin Marinas wrote:
>> Maybe we could allow (b) if SoC vendors don't provide a different API
>> to set the HVBAR. But it means that kernels not aware of this feature
>> would fail.
>
> Oh, does this mean that ARM Ltd are starting to see the light in having
> a common defined secure API at last - at least a subset - something which
> I've mentioned several times...

I've discussed this internally at ST-Ericsson at times.

There is something called the Trusted Execution Environment
(TEE) which is standardized by Global Platform, a consortia
where ARM are members, as are ST, Ericsson, NXP, Renesas,
and TI (etc):
http://www.globalplatform.org/membershipcurrentfull.asp

For Ux500 we have a driver for this API which can be found in
an out-of-tree git, basically for Ux500 the ROM implements
the service tunnel, and we call into the ROM to perform them.
The ROM in turn will issue an SMC to execute the actual
call to the secure world.

The TEE defines Trusted Applications (TA:s) that can be
called, they use a GUID identifier on each side as handle.
I think of it as some exec() call which returns the result in
a pipe ... (I don't know if this analogy is correct)

Right now these TEE calls are mostly for performing this or
that cryptographic operation on some buffer of data, keeping
the secret crypto keys in the secure world. These calls are
done from userspace with the kernel driver simply
mediating them.

The basic question to which I have no answer is whether
TEE is or is not intended to be used for low-level services
like l2x0 on/off or so. Or if the idea never even crossed the
minds of the people devising TEE, like say if they were
having totally different use cases in their mind when they
cooked it up.

If it was intended for such stuff, we/GlobalPlatform could
define a few standard "TAs" that all platforms would
implement, unless it's by nature too heavyweight for that.

Would be fun if someone with insight could fill in on
this...

[TEE experts, smack my fingers if I got some detail
wrong in here.]

Yours,
Linus Walleij

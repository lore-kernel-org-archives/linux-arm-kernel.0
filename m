From: robherring2@gmail.com (Rob Herring)
Date: Thu, 30 Aug 2012 14:07:18 -0500
Subject: [PATCH 1/6] ARM: move ARCH config definitions into mach dirs
In-Reply-To: <20120830164551.GY18957@n2100.arm.linux.org.uk>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
 <1346280600-29395-2-git-send-email-robherring2@gmail.com>
 <20120829233159.GS18957@n2100.arm.linux.org.uk> <503F845C.10406@gmail.com>
 <20120830164551.GY18957@n2100.arm.linux.org.uk>
Message-ID: <503FB9E6.7020102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2012 11:45 AM, Russell King - ARM Linux wrote:
> On Thu, Aug 30, 2012 at 10:18:52AM -0500, Rob Herring wrote:
>> Then what do you suggest? I can think of a few alternatives.
>>
>> Leave the current name and make the hidden option a new name like
>> ARCH_xx_OPTIONS. This would require renaming ARCH_xxx for each platform
>> all over the tree. I don't care to sign up for that task...
> 
> Well, requiring everyone to spend hours redoing their configuration also
> isn't practical either.
> 
>> Move platforms one by one out of the choice as they are converted. I
>> can't think of a reason for a platform to be in both places except we
>> would have to figure out something for getting DEBUG_LL to work.
> 
> No you don't.  We've already decided how we're going to deal with
> DEBUG_LL, and we are _not_ going to make that multi-platform.  You
> select one of the output options, and that is it.  We've already
> been moving in that direction, albiet slowly.  Again, anyone who wants
> to be part of a multiplatform kernel better use the provided choice
> or they will get no DEBUG_LL facility - simples.

Right. The problem is with current patches (and Arnd's version) you
cannot select even 1 DEBUG_LL choice as mach/debug-macro.S is not in the
include path any more when multi-plat is enabled. If we move platforms
out of the choice, then we need some way to enable DEBUG_LL.

> 
> That also means we can start to think about moving the mach/debug-macros.S
> header elsewhere, remembering that this facility is shared between the
> decompressor for debugging and the kernel.

I was thinking we could convert the phys and virt addresses to config
values and then the DEBUG_LL choices could just be "Use PL01x uart" and
"Use 8250 uart". This would cut down the number of debug-macro.S files
and choices.

Using a fixed virtual address for all platforms might also help simplify
DEBUG_LL.

But I'd like to find a more simple solution to get past enabling
multi-platform and deal with a more complex change later.

Rob

> Remember that DEBUG_LL is the low-level *debug* facility.  It is not
> the early console, even if it ended up being used as such (which is
> not something I really care for.)  Read the previous discussions on
> this subject if you disagree, but I'm not changing my position over
> DEBUG_LL because that will just require me to re-invent the facility
> yet again (which is what DEBUG_LL is there to stop.)  It was _never_
> intended to be an early console facility.
> 

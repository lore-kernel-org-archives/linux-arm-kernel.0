From: steve.capper@arm.com (Steve Capper)
Date: Thu, 14 Jul 2016 02:08:16 +0100
Subject: [PATCH] arm64: Add config to limit user space to 47bits
In-Reply-To: <578668D3.6010406@suse.de>
References: <1468424567-15925-1-git-send-email-agraf@suse.de>
 <CAKv+Gu_QH=sZi--FVqHebd1P+6UMzEqWQQ1u3Y170B7cND8Kgw@mail.gmail.com>
 <578668D3.6010406@suse.de>
Message-ID: <20160714010812.GA17138@e103986-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

Thanks for posting this.

On Wed, Jul 13, 2016 at 06:14:11PM +0200, Alexander Graf wrote:
> On 07/13/2016 05:59 PM, Ard Biesheuvel wrote:
> >On 13 July 2016 at 17:42, Alexander Graf <agraf@suse.de> wrote:
> >>Some user space applications are known to break with 48 bits virtual
> >known by whom? At least I wasn't aware of it, so could you please
> >share some examples?
> 
> Sure! Known to me so far are:
> 
>   * mozjs17
>   * mozjs24
>   * mozjs38
>   * js-1.8.5
>   * java-1.7 (older JITs, fixed in newer ones)
> 
> I'm not sure if there are more, but the fact that I've run into this
> problem more than once doesn't make me incredibly happy :).
> 

I came across this too: on bootup via polkitd (which pulled in mozJS) :-(.

> >
> >>address space. As interim step until the world is healed and everyone
> >>embraces correct code, this patch allows to only expose 47 bits of
> >>virtual address space to user space.
> >>
> >Is this a code generation/toolchain issue?
> 
> mozjs uses a single 64bit value to combine doubles, ints and
> pointers into a single variable. It is very smart and uses the upper
> 17 bits for metadata such as "which type of variable is this".
> Coincidentally those bits happen to overlap the "double is an
> infinite number" bits, so that you can also express a NaN with it.
> When using such a value, the upper 17 bits get masked out.
> 
> That one was fixed upstream by force allocating the javascript heap
> starting at a fixed location which is below 47 bits.
> 
> js-1.8.5 has the same as above, but also uses pointers to .rodata as
> javascript pointers, so it doesn't only use the heap, it also uses
> pointers to the library itself, which gets mapped high up the
> address space. I don't have a solution for that one yet.

Is this Spidermonkey 1.8.5? I wasn't aware of this issue.

> 
> IcedTea for java-1.7 had a bug where it incorrectly caused an
> overflow when trying to calculating a relative adrp offset from
> <address high up> to <address really low>, so that the resulting
> pointer had the upper bits set as 1s. That one is long fixed
> upstream, we only ran into it because we used an ancient IcedTea
> snapshot.

I would recommend updating the sources used for OpenJDK anyway as there
have been a few other stability and performance fixes put in over the
last year to my knowledge.

> 
> My main concern however is with code that I do not know is broken today.
> 

I think if we set the 47-bit VA we are just ignoring the fundamental
problem and even allowing the problem to get worse (as future code may
adopt unsafe pointer tagging); thus I agree with Mark Rutland's NAK.

Personally, I would only ever tag bits in the VA space that I control
(i.e. at the bottom of the pointer if I enforce alignment).

Cheers,
-- 
Steve

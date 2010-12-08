From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 8 Dec 2010 18:09:14 +0000
Subject: [PATCH] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
In-Reply-To: <603978.51278.qm@web180303.mail.gq1.yahoo.com>
References: <AANLkTin8r4-ooAUsf-T5SnM_QDHdY_c3XfRL4o=nZkHC@mail.gmail.com>
	<603978.51278.qm@web180303.mail.gq1.yahoo.com>
Message-ID: <AANLkTinxHKnSk3=q2e1RkTJ_eA6CB2N6RZzNe6upnGFe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 8, 2010 at 4:38 PM, David Brownell <david-b@pacbell.net> wrote:
> So to recapitulate ... you're agreeing with me on
> my key point -- that ARM1156, a V6T2 core with
> ?Thumb2 support (used in fact to introduce
> Thumb2), should ?work for some in-kernel Thumb2
> usage, degree TBD, but obviously the v7 cores
> are more capable (with SIMD support in T2, etc).

To be strictly accurate, 1156 is not an ARMv6 core -- it's an ARMv6T2
core, so it's debatable whether CPU_V6 should be set in this case.  A
separate config item, such as CPU_V6T2 might be needed to express this
distinction if support for 1156 were to be added.

I believe if multiple CPU_* are defined, this usually means a kernel
configured to support multiple platforms in the same binary; this is
supported by some mach tress.  A kernel binary intended to execute on
a set of platforms including a plain v6 platform (indicated by CPU_V6
being set) most not be built in Thumb-2, since it then wouldn't work
on those v6 platforms.

>
> And no, *I* never said anything about a V7M Linux,
> that was your words. ?I'm used to the advantages of using MMUs with fork() and mprotect(), etc.
>
>
> But the updated reason you gave for not allowing V6T2 is
> that it's an uncommon architecture (one core, not
> widely manufactured today) ... not impossibility.

Agreed.  Out of interest, do you know of anyone working with 1156 of
patches to support it?  This would be a different story, since then it
would be clearer how CONFIG_THUMB2_KERNEL should integrate in this
case.

>
> In short, the basic premise of $PATCH is wrong, as
> I pointed out, but there may be other reasons to
> merge it, related to V6T2 chip availability not the
> actual architecture specs from ARM.

Well, the statement "Thumb-2 code can't execute on anything prior to
ARMv7" was a generalisation; the commit message can certainly be made
clearer.  Really, what I meant was something like "Thumb-2 code can't
execute on any common architecture prior to ARMv7", but I'm happy to
make it clearer to explain the v6T2 case.

>
> A similar argument would be that making the ASM code
> cope with core variants would get ugly/messy. ?At
> least the GNU assembler is, as I recall, aware of
> which instructions which cores support, so it would
> provide clean errors if given instructions that are
> Thumb2 (some flavor) but not accepted by the target.
> But Linux code shouldn't trigger such errors in the
> first place, even if they're a good backstop (and
> that implies ugly core-driven conditional code.
>

That's why I prefer not to allow CONFIG_THUMB2_KERNEL to be turned on
in situations where it won't work.

If you have a cleaner solution, feel free to suggest it.

Cheers
---Dave

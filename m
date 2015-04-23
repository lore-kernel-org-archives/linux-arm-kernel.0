From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 23 Apr 2015 10:49:50 -0700
Subject: [PATCH] arm64: errata: add workaround for cortex-a53 erratum
 #845719
In-Reply-To: <20150423110025.GE1652@arm.com> (Will Deacon's message of "Thu,
 23 Apr 2015 12:00:25 +0100")
References: <1427792898-22297-1-git-send-email-will.deacon@arm.com>
 <CAMAWPa_NnQ7RSds7jM3bULqC+oMOy5HC6DNTT39Tez8C4MGc=Q@mail.gmail.com>
 <20150423110025.GE1652@arm.com>
Message-ID: <7hfv7q7n0h.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

>> On Tue, Mar 31, 2015 at 2:08 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > When running a compat (AArch32) userspace on Cortex-A53, a load at EL0
>> > from a virtual address that matches the bottom 32 bits of the virtual
>> > address used by a recent load at (AArch64) EL1 might return incorrect
>> > data.
>> >
>> > This patch works around the issue by writing to the contextidr_el1
>> > register on the exception return path when returning to a 32-bit task.
>> > This workaround is patched in at runtime based on the MIDR value of the
>> > processor.
>> >
>> > Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>> > Tested-by: Mark Rutland <mark.rutland@arm.com>
>> > Signed-off-by: Will Deacon <will.deacon@arm.com>
>> 
>> Curious if you are planning to flag this for v3.19-stable?  I also
>> noticed that the recent one from Bo Yan[1] for A57 might also be
>> missing from stable/linux-3.19.y.  A quick check suggests they both
>> apply cleanly to stable/linux-3.19.y
>
> I wasn't planning on it, but if somebody wants it for 3.19 they could
> certainly send it to Greg.

OK, I'll take care of that.

>> Speaking of stable, is anyone at ARM working on getting these into
>> older versions of stable?
>
> No; although I was under the impression that Linaro had been tasked to do
> the backports for LSK.

Exactly why I'm asking.  The preferred path for LSK is via the stable
tree, so I'd like to see them there first if at all possible.

>> For v3.18, I did a quick backport (and simple boot test on qemu) of
>> Andre's framework plus the errata I'm aware of to stable/linux-3.18.y,
>> and it seems to work (kernel reports "alternative: enabling workaround
>> for ARM erratum 832075) so getting the framework plus errata into
>> stable/linux-3.18.y seems like a good idea too and pretty straight
>> forward too.
>
> Backporting the entire alternatives framework to -stable sounds pretty
> heavyweight to me, particularly if we have to go back as far as 3.10. 

3.18 was very straighforward, direct cherry-picks worked cleanly, so I'm
thinking of sending that series to stable as well.

But your right, further back gets a bit more cumbersome.  So far, I've
manged to do it for 3.14[1] with a bit more headaches, but it's not too
bad.  The other LSK is 3.10, and it's probably going to be quite a bit
more headache.  IMO neither 3.14 or 3.10 is probably a good candidate to
send to stable, so may end up being LSK only.

That being said, I'd still like to see future errata show up in stable
for at least >= v3.18, since it will be easy to do.

> We could unconditionally backport the errata workarounds, but that
> would require us to assess the performance impact on a variety of CPUs
> for each of the backports, which I don't think is a good idea.

Any other suggestions?  Maybe simple compile-time ifdefs for 3.10 will
be simplest.

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git wip/v3.14/arm64-errata

From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 18 Dec 2015 09:06:29 -0800
Subject: [PATCH 0/3] Batched user access support
In-Reply-To: <20151218094452.GA32455@gmail.com>
References: <alpine.LFD.2.20.1512171016510.27310@i7>
 <20151218094452.GA32455@gmail.com>
Message-ID: <CA+55aFx=KibdQAc6_UQkBNbCaYzJPu7VL-gRX7cVin8JmnW6EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 1:44 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> On the 'make -j' test on a fully built kernel, strncpy_from_user() was
>> about 1.5% of all CPU time. And almost two thirds of that was just the
>> SMAP overhead.
>
> Just curious: by how much did the overhead shift after your patches?

So just in case you want to reproduce this, here's what I do:

 (a) configure a maximal kernel build:

      make allmodconfig

 (b) build the kernel fully (not timing this part):

      make -j16

 (c) profile the now empty kernel re-build:

      perf record -e cycles:pp make -j

 (d) look at just the kernel part of the profile, by zooming into the
kernel DSO when doing

      perf report --sort=symbol

That empty kernel rebuild is one of my ways to check for somewhat real
VFS path-lookup performance. It's a real load, and fairly relevant:
most of my kernel builds are reasonably empty (ie when I pull from
people, I always rebuild, but if it's a small pull, it's not
necessarily rebuilding very much).

Anyway, on that profile, what you *should* normally see is that the
path walking is the hottest part by far, because most of the costs
there is "make" doing a lot of "stat()" calls to get the timestamps of
all the source and object files. It has a long tail - "make" does
other things too, but the top kernel entry should basically be
"__d_lookup_rcu()", with "link_path_walk()" and
"selinux_inode_permission()" being up there too.

Those are basically the three hottest path lookup functions (and yes,
it's sad how high selinux_inode_permission() is, but it's largely
because it's the first place where we start touching the actual inode
data, so you an see in the instruction profiles how much of it are
those first accesses).

With SMAP and the stac/clac on every access, in my profiles I see
strncpy_from_user() being neck-and-neck with link_path_walk() and
selinux_inode_permission(). And it definitely shouldn't be there.
Don't get me wrong: it's a function that I expect to see in the
profiles - copying the pathname from user space really is a noticeable
part of pathname lookup - but it shouldn't be in the top three.

So for me, without that patch-series, "strncpu_from_user()" was the
third-hottest function (ok, looked at my numbers again, and it wasn't
1.5%, it was 1.2% of all time).

And looking at the instruction profile, the overhead of _just_ the
stac/clac instructions (using "cycles:pp" in the profile) was 60% of
that 1.2%.

Put another way: just those two instructions used to be 0.7% of the
whole CPU cost of that empty "make -j".

Now, as I'm sure you have seen many many times, instruction-level
profiling isn't "real performance". It shifts around, and with
out-of-order CPU's, even with the nice precise PEBS profiling, the
fact that 0.7% of all time is *accounted* to the instructions doesn't
mean that you really spend that much on it. But it's still a pretty
big sign.

Anyway, *with* the patches, strncpu_from_user() falls from third place
and 1.2% of the cost down to ninth place, and 0.52% of the total cost.
And the stac/clac instructions go from 60% of the cost to 33%. So
overall, those two stac/clac instructions went from 0.7% of the whole
build cost down to 0.17%.

So the whole strncpy_from_user() function sped up by between a factor
of two and three, and that's because the cost of just the stac/clac
was cut by almost a factor of five.

And all the numbers fluctuate, so take all of the above with a pinch
of salt. But they are repeatable enough for me to be a reasonable
ballpark, even if they do fluctuate a bit.

I think you have a Skylake machine too, so you can redo the above.

                           Linus

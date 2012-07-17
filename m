From: tytso@mit.edu (Theodore Ts'o)
Date: Tue, 17 Jul 2012 17:42:19 -0400
Subject: [PATCH -next] random: Remove remaining relicts of
 rand_initialize_irq()
In-Reply-To: <CACRpkdZe48FrDJx1p8ojfqwVBE95hSJipE8rViAi=E28uumYOQ@mail.gmail.com>
References: <1342524793-2522-1-git-send-email-sedat.dilek@gmail.com>
 <20120717171251.GD6049@thunk.org>
 <CACRpkdZe48FrDJx1p8ojfqwVBE95hSJipE8rViAi=E28uumYOQ@mail.gmail.com>
Message-ID: <20120717214219.GF6049@thunk.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 08:57:19PM +0200, Linus Walleij wrote:
> So the IRQ will be auto-sampled now or something?
> 
> Sorry for not quite following, which commit do I look at to
> understand this now...

Yes, there was a huge discussion on LKML about two weeks ago.  The
key commit that will be going in during the next merge window is:

http://git.kernel.org/?p=linux/kernel/git/tytso/random.git;a=commitdiff;h=775f4b297b780601e61787b766f306ed3e1d23eb

There are a whole lot of other changes, of course, but that's the key
change which IRQF_SAMPLE_RANDOM a no-op.  People have tested this
under extreme conditions (high speed networking tests with no
interrupt mitigations, etc.) and the patch as tweaked had no
measurable overhead, so we can simply sample every single commit with
a low-overhead fast path which uses per-cpu buffers, and then mix into
the /dev/random entropy pool less frequently (which is still fast, but
requires a few more memory accesses to shared memory that may incur
delays due to cache line bounces).

					- Ted

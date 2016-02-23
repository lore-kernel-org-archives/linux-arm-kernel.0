From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 23 Feb 2016 09:46:08 -0800
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <20160223103221.GA1418@node.shutemov.name>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
 <20160223103221.GA1418@node.shutemov.name>
Message-ID: <CA+55aFxh5P57Qg2xPYbTekAXzpWWON2qw76ZtC93ZQKqaqBA6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 2:32 AM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> I still worry about pmd_present(). It looks wrong to me. I wounder if
> patch below makes a difference.

Let's hope that's it, but in the meantime I do want to start the
discussion about what to do if it isn't. We're at rc5, and 4.5 is just
a few weeks away, and so far this issue hasn't gone anywhere.

So the *good* scenario is that your pmd_present() patch fixes it, and
we can all take a relieved breath.

But if not, what then? It looks like we have two options:

 (a) do a (hopefully minimal) revert.

     I say "hopefully minimal", but I suspect the revert is going to
have to undo pretty much all of the core THP changes. I'd hate to see
that, because I really liked the cleanups.

 (b) mark THP as "depends on !S390" in the 4.5 release

The (b) option is obviously much simpler, but it's a regression. I
really don't like it, even if it generally shouldn't be the kind of
regression that is actually user-noticeable (apart from performance).
I also hate the fact that while the problem only seems to happen on
s390, we don't even understand it, so maybe it's a more generic issue
that for some reason just ends up being *much* more noticeable on one
odd architecture that happens to be a bit different.

I'm inclined to think of (b) as just a "give us more time to figure it
out" thing, but I'm also worried that it will then make people not
pursue this issue.

How big is a revert patch that makes THP work on s390 again? Can we do
a revert that keeps the infrastructure intact and makes it easy to
revisit the THP cleanups later? Or is the revert inevitably going to
be all the core patches in that series?

                   Linus

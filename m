From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Fri, 31 Aug 2018 14:42:44 +0100
Subject: [PATCH v6 11/11] arm64: annotate user pointers casts detected by
 sparse
In-Reply-To: <20180831081123.6mo62xnk54pvlxmc@ltop.local>
References: <cover.1535629099.git.andreyknvl@google.com>
 <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <20180831081123.6mo62xnk54pvlxmc@ltop.local>
Message-ID: <20180831134244.GB19965@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 10:11:24AM +0200, Luc Van Oostenryck wrote:
> On Thu, Aug 30, 2018 at 01:41:16PM +0200, Andrey Konovalov wrote:
> > This patch adds __force annotations for __user pointers casts detected by
> > sparse with the -Wcast-from-as flag enabled (added in [1]).
> > 
> > [1] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292
> 
> Hi,
> 
> It would be nice to have some explanation for why these added __force
> are useful.

	It would be even more useful if that series would either deal with
the noise for real ("that's what we intend here, that's what we intend there,
here's a primitive for such-and-such kind of cases, here we actually
ought to pass __user pointer instead of unsigned long", etc.) or left it
unmasked.

	As it is, __force says only one thing: "I know the code is doing
the right thing here".  That belongs in primitives, and I do *not* mean the
#define cast_to_ulong(x) ((__force unsigned long)(x))
kind.

	Folks, if you don't want to deal with that - leave the warnings be.
They do carry more information than "someone has slapped __force in that place".

Al, very annoyed by that kind of information-hiding crap...

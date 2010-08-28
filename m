From: peterz@infradead.org (Peter Zijlstra)
Date: Sat, 28 Aug 2010 16:16:09 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <201008281558.23501.hverkuil@xs4all.nl>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<201008281508.19756.hverkuil@xs4all.nl>
	<1283002486.1975.3479.camel@laptop>
	<201008281558.23501.hverkuil@xs4all.nl>
Message-ID: <1283004969.1975.3530.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-08-28 at 15:58 +0200, Hans Verkuil wrote:
> > Isn't the proposed CMA thing vulnerable to the exact same problem? If
> > you allow sharing of regions and plug some allocator in there you get
> > the same problem. If you can solve it there, you can solve it for any
> > kind of reservation scheme.
> 
> Since with cma you can assign a region exclusively to a driver you can ensure
> that this problem does not occur. Of course, if you allow sharing then you will
> end up with the same type of problem unless you know that there is only one
> driver at a time that will use that memory.

I think you could do the same thing, the proposed page allocator
solutions still needs to manage pageblock state, you can manage those
the same as you would your cma regions -- the difference is that you get
the option of letting the rest of the system use the memory in a
transparent manner if you don't need it.


> There is obviously a trade-off. I was just wondering how costly it is.
> E.g. would it be a noticeable delay making 64 MB memory available in this
> way on a, say, 600 MHz ARM. 

Right, dunno really, rather depends on the memory bandwidth of your arm
device I suspect. It is something you'd have to test. 

In case the machine isn't fast enough, there really isn't anything you
can do but keep the memory empty at all times; unless of course the
device in question needs it.

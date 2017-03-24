From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 24 Mar 2017 13:49:47 -0400 (EDT)
Subject: [PATCH 0/3] minitty: a minimal TTY layer alternative for embedded
 systems
In-Reply-To: <20170324135317.GA26769@kroah.com>
References: <20170323210304.2181-1-nicolas.pitre@linaro.org>
 <20170324065015.GA17226@kroah.com>
 <alpine.LFD.2.20.1703240819370.2304@knanqh.ubzr>
 <20170324135317.GA26769@kroah.com>
Message-ID: <alpine.LFD.2.20.1703241215540.2304@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Mar 2017, Greg Kroah-Hartman wrote:

> On Fri, Mar 24, 2017 at 08:31:45AM -0400, Nicolas Pitre wrote:
> > That's the crux of the argument: touching the current TTY layer is NOT 
> > going to help keeping it stable. Here, not only I did remove features, 
> > but the ones I kept were reimplemented to be much smaller and 
> > potentially less scalable and performant too.  The ultimate goal here is 
> > to have the smallest code possible with very simple locking and not 
> > necessarily the most scalable code. That in itself is contradictory with 
> > the regular TTY code and warrants a separate implementation. And because 
> > it is so small, it is much easier to understand and much easier to 
> > maintain.
> 
> So, what you are really saying here is "the current tty layer is too
> messy, too complex, too big, and not understandable, so I'm going to
> route around it by rewriting the whole thing just for my single-use-case
> because I don't want to touch it."

That's not exactly what I'm saying.

Yes, the current TTY code is big. It has to, given that it is extremely 
flexible, it can scale up and still be robust, and it covers a large 
amount of use cases. Because of those characteristics, it fundamentally 
cannot be made small. You just can't have it all.

I'm not saying that the current code is not understandable. I spent 
considerable amount of my time understanding it, first and foremost to 
get to know what I'm talking about, and find ways to shrink its memory 
footprint initially. It is certainly complex because of the flexibility 
and robustness it provides. My code most likely wouldn't perform as well 
in the presence of multiple high-throughput channels for example.  But 
that's not my concern.

I'm concerned about small embedded systems where 85% of that code is 
useless. In some cases the ability to change baudrate is also unneeded 
so I intend to make that part configurable too.

But in the end there is simply no way I could achieve the same footprint 
reduction with the existing code.  This is clearly impossible.

For example, my code perform line discipline handling in the very same 
buffer where the RX interrupt is storing new data. The existing TTY code 
has up to 3 buffering layers because of the needed modularisation to 
support swappable line discipline modules, etc.  It is simply 
unreasonable to expect that the later can be turned into the former 
without either breaking things or severely restricting its scope.

Let's be honest here: the existing code _could_ possibly be reduced of 
course. That would require a lot of efforts to gain 50% reduction maybe?  
What I'm looking at with my proposal here is a 6x reduction factor and 
I'm still not done with it. There is no way I could do that with the 
existing code.

Let me give you some background as to what my fundamental motivation is, 
and then maybe you'll understand why I'm doing this.

What is the biggest buzzword in the IT industry right now? It is IOT.

Most IOT targets are so small that people are rewriting new operating 
systems from scratch for them. Lots of fragmentation already exists. 
We're talking about systems with less than one megabyte of RAM, 
sometimes much less.  Still, those things are being connected to the 
internet. And this is going to be a total security nightmare.

I wish to be able to leverage the Linux ecosystem for as much of the IOT 
space as possible to avoid the worst of those nightmares.  The Linux 
ecosystem has a *lot* of knowledgeable people around it, a lot of 
testing infrastructure and tooling available already, etc.  If a 
security issue turns up on Linux, it has a greater chance of being 
caught early, or fixed quickly otherwise, and finding people with the 
right knowledge is easier on Linux than it could be on any RTOS out 
there. Still with me so far?

Yes we have tools that can automatically reduce the kernel size. We can 
use LTO with the compiler, etc.  LTO is pretty good already. It can 
typically reduce the kernel size by 20%.  If all system calls are 
disabled except for a few ones, then LTO can get rid of another 20%.  
The minimal kernel I get is still 400-500 KB in size.  That's still too 
big. Part of the size is this 60 KB of TTY + serial driver code just to 
send some debugging messages out or do simple shell interactions!  Now 
with this mini TTY and one of the existing UART driver I'm down to 20 
KB and there is still room for more reduction.

There is also this 120 KB of VFS code that is always there even though 
there is no real filesystem at all configured in the kernel. There is 
that other 100 KB of core driver support code despite the fact that the 
set of drivers I'm using are very simple and basic. Etc.

For Linux to be suitable, it has to be small, damn small. My target is 
256 KB of RAM.  And if you look at the kind of application those 256 KB 
systems are doing, it's basically one main task typically acquiring 
sensor data and sending it in some crypted protocol over a wireless 
network on the internet, and possibly accepting commands back.  So what 
do you need from the OS to achieve that?  A few system calls, a minimal 
scheduler, minimal memory management, minimal filesystem structure and 
minimal network stack. And your user app.

So, why not having each of those blocks be created using the existing 
Linux syscall interface and internal API?  At that point, it should be 
possible to take your standard full-featured Linux workstation and 
develop your user app on it, run it there using all the existing native 
debugging tools, etc. Also, it should be possible to swap some of those 
kernel blocks for the tiny alternative in your kernel config and still 
be able to boot such a kernel on your PC workstation and validate them 
there, test them with the existing fuzers, etc.  That's what I have here 
with this mini TTY implementation. In the end you just take the mini 
version of everything for the final target and you're done.  And you 
don't have to learn a whole new development environment and program 
model, etc.

I hope you'd agree with me that for such a goal, I cannot just try to 
shrink the existing code. There has to be a parallel implementation of 
some blocks alongside the main one that preserves the existing API but 
that provides much less scalability and fewer features. Next on my list 
would be a cache-less, completely serialized VFS alternative that has 
only what's needed to make the link between the read/write syscalls, a 
filesystem driver and a block driver. And by being really small, the 
maintenance cost of a parallel implementation isn't very high, certainly 
much less than trying to maintain a single version that can scale to 
both extremes.

Hence this series, which I hope could be the beginning of a trend for
allowing Linux into the largest computing device deployment to come.


Nicolas

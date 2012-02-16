From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 16 Feb 2012 13:29:21 -0500 (EST)
Subject: ftp.arm.linux.org.uk now using dumb http git protocol
In-Reply-To: <20120216131144.GM13673@n2100.arm.linux.org.uk>
References: <20120216131144.GM13673@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1202161309450.24536@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Feb 2012, Russell King - ARM Linux wrote:

> A couple of days I disabled the smart git protocol over http on
> ftp.arm.linux.org.uk because the smart git protocol over http is
> far too heavyweight for the poor x86 machine.  It's now using the
> lighter-weight dumb http file serving stuff instead.  This has made
> the machine load go back to virtually zero instead of skyrocketing.
> 
> It's revealed something rather interesting though: people _have_ been
> updating their trees from my tree without first ensuring that their tree
> is up to date with Linus' tree.  I suspect people have been cloning
> the tree as well.

I think there is a way to block wholesale clones with a hook script.

> This action puts more load on the server, load it can do without.
> 
> So, as of a couple of days ago, it's now using the dumb http stuff,
> which means if you abort it, you _will_ get corrupted pack files in
> your .git/objects/pack directory.
> 
> You can avoid much of that pain by following what you should've been
> doing in the first place: first update your trees by pulling from
> Linus' tree.  Then, and only then, update your tree from my tree.
> Doing that will minimise the time you have to wait, and minimise the
> chance of a corrupted pack file.

That will work only if Linus' tree is contained in a pack of its own on 
the server, and your stuff not mixed up with it.  This is because, by 
its dumb nature, the dumb protocol may only transfer whole pack files.  
If a client end up needing only one object which is part of a big pack, 
then the entire big pack has to be transferred.

So you need to ensure that Linus' tree is repacked separately from your 
own objects, and marked with .keep to prevent further repacking while 
you repack again to remove duplicated objects found in Linus' pack from 
your own.  This is some annoyance that can be scripted, but still 
something that you'll have to be diligent about on your side.

In that case, people up to date with Linus' tree should get 
only your objects, and potentially more than strictly required if they 
were already partially up to date with you.  But that should be in an 
order of magnitude smaller than if mainline objects are fetched.

Not the ideal solution in any case.


Nicolas

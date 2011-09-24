From: mh@glandium.org (Mike Hommey)
Date: Sat, 24 Sep 2011 11:35:44 +0200
Subject: I-cache/D-cache inconsistency issue with page cache
In-Reply-To: <20110923193941.GQ17169@n2100.arm.linux.org.uk>
References: <20110923115721.GA7013@glandium.org>
	<20110923193941.GQ17169@n2100.arm.linux.org.uk>
Message-ID: <20110924093544.GA5724@glandium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 08:39:41PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 23, 2011 at 01:57:21PM +0200, Mike Hommey wrote:
> > We've been hitting random crashes at startup with Firefox on tegras
> > (under Android), and narrowed it down to a I-cache/D-cache
> > inconsistency. A reduced testcase of the issue looks like the following
> > (compile as ARM, not Thumb):
> 
> If you write code at run time, you need to use the sys_cacheflush
> API to ensure that it's properly synchronized with the I-cache.  It's
> a well known issue, and it applies to any harvard cache structured
> CPU which doesn't automatically ensure coherence (which essentially
> means all ARMs.)

I do agree it's reasonable to have applications doing that to handle
cache synchronization themselves. I wrote such in my message. But I
think the kernel should make sure that its page cache is fresh when 
it maps it PROT_EXEC. I think it's unreasonable to expect applications
doing mmap(PROT_WRITE), inflate, munmap, something, mmap(PROT_EXEC),
and execute something there to have to handle cache synchronisation
themselves. Especially when it's very CPU dependent (the testcase does
not even fail on all ARMs, only tegras, apparently). I'm not talking
actual code generation here, which needs platform-dependent behaviour.

Mike

From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 28 Feb 2014 09:11:38 -0500
Subject: change kmalloc into vmalloc for large memory allocations
In-Reply-To: <35FD53F367049845BC99AC72306C23D102844605F38C@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D102844605F38C@CNBJMBX05.corpusers.net>
Message-ID: <20140228091138.39b90f52@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Feb 2014 16:15:23 +0800
"Wang, Yalin" <Yalin.Wang@sonymobile.com> wrote:

> Kfree(ptr)
> {
> 	If (is_vmalloc_addr(ptr))
> 		Vfree(ptr);
> 	Else
> 		Kfree(ptr);
> }
> 
> 
> But we need add some flags to ensure always use kmalloc for
> Some special use (dma etc..)
> 
> How do you think of it ?

But vmalloc also takes up tlb entries. The more vmalloc space you have,
the more tlb entries that will need to be used, which will have a
performance affect on the entire system.

I would be against making kmalloc() secretly doing a vmalloc. If it is
better for a driver to use a vmalloc on large items, than change the
driver. Don't change a core function.

-- Steve

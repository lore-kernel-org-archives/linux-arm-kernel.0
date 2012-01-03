From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 09:09:24 +0000
Subject: init_kprobes() takes too much time during boot up
In-Reply-To: <1324641249.2215.25.camel@linaro1>
References: <CAMPhdO8T5wwPBYp_n15A88o8YxkXv2t8WOumRyni6WDhJinS3A@mail.gmail.com>
 <alpine.LFD.2.02.1112222212140.2907@xanadu.home>
 <1324641249.2215.25.camel@linaro1>
Message-ID: <20120103090924.GC2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2011 at 11:54:09AM +0000, Jon Medhurst (Tixy) wrote:
> Does Linux have some general IPI interface we could use to synchronize
> CPU rather than stop_machine? All we need to do is interrupt other cores
> and make them wait until we write a new instruction to memory and do a
> cache flush and relevant barrier instructions.

Maybe smp_call_function().  I'm not sure whether making the called
function spin until the calling CPU sets a flag is a good idea though -
that sounds like it could cause lockups by preventing other IPIs
happening.  Bear in mind that calling flush_* functions from IPIs is
not a good idea because they'll want to IPI themselves - you have to
use the local_flush_* stuff instead.

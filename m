From: phil.sutter@viprinet.com (Phil Sutter)
Date: Tue, 6 Sep 2011 13:05:03 +0200
Subject: [PATCH] af_packet: flush complete kernel cache in packet_sendmsg
In-Reply-To: <20110906095722.GK6619@n2100.arm.linux.org.uk>
References: <20110505141107.GC30443@orbit.nwl.cc>
	<1314961686-30870-1-git-send-email-phil.sutter@viprinet.com>
	<1314971179.3092.159.camel@deadeye>
	<20110902172850.GB6619@n2100.arm.linux.org.uk>
	<20110905195714.GC29025@philter>
	<20110906095722.GK6619@n2100.arm.linux.org.uk>
Message-ID: <20110906110503.GE29025@philter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 10:57:22AM +0100, Russell King - ARM Linux wrote:
> > The code in question uses __get_free_pages(), and if that fails uses
> > vmalloc() (see alloc_one_pg_vec_page() for reference). Both code paths
> > show result in the same faulty behaviour.
> 
> So, what you're wanting is cache coherency between vmalloc() and
> userspace.  There is no API in the kernel to do that, and you'll see
> the same failures of this interface not only on ARM but also other
> architectures with virtual caches.
> 
> It sounds like we need an API to flush the cache using both the
> userspace address, plus the kernel side address be that in the direct
> map or the vmalloc map areas.
> 
> Or maybe the right solution is to simply disable AF_PACKET MMAP support
> for virtual cached architectures - it may be that adding cache flushing
> calls makes the thing too expensive and the benefits of mmap over normal
> read/write are lost.

OK, that's horrible. Of course we depend on just this combination to
work flawlessly, i.e. PACKET_MMAP && VIVT. :(

Another userspace-interface I'm working on uses a different solution:
memory is allocated in userspace and accessed from kernelspace using
get_user_pages(). I did not explicitly search for the earlier described
fault pattern, but we didn't notice any problem with this approach on
the very same hardware either. I already see myself writing TPACKET_V3.
;)

What do you think?

Greetings, Phil

-- 
Viprinet GmbH
Mainzer Str. 43
55411 Bingen am Rhein
Germany

Zentrale:     +49-6721-49030-0
Durchwahl:    +49-6721-49030-134
Fax:          +49-6721-49030-209

phil.sutter at viprinet.com
http://www.viprinet.com

Sitz der Gesellschaft: Bingen am Rhein
Handelsregister: Amtsgericht Mainz HRB40380
Gesch?ftsf?hrer: Simon Kissel

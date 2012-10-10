From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Oct 2012 11:07:40 +0000
Subject: [Xen-devel] [PATCH 5/9] ARM: Xen: fix initial build problems:
In-Reply-To: <1349862394.10070.23.camel@zakaz.uk.xensource.com>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <201210091819.34310.arnd@arndb.de>
 <1349862394.10070.23.camel@zakaz.uk.xensource.com>
Message-ID: <201210101107.40898.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 October 2012, Ian Campbell wrote:
> > * implement your own cmpxchg wrapper that may be implemented using a spinlock
> >   rather than cmpxchg if ARMv6 is enabled.
> 
> Even if ARMv6 is enabled the grant table code will never be running on
> one so so it might be ok to just have our own wrapper which
> unconditionally uses the v7 instruction? That might upset gas though.

Yes, that would be possible. You can tell gas to ignore the instruction
set in this case. If you do this, you can implement the update functions
more efficiently using direct ldrexh/strexh in assembler to avoid doing
two nested loops. I assume that you don't need the v1 grant table
code on ARM anyway, so the only code you need to look at is

        while (!((flags = *pflags) & GTF_transfer_committed)) {
                if (sync_cmpxchg(pflags, flags, 0) == flags)
                        return 0;
                cpu_relax();
        }

which should transform nicely into a few lines of inline assembly.

	Arnd

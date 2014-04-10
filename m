From: rabin@rab.in (Rabin Vincent)
Date: Thu, 10 Apr 2014 21:34:46 +0200
Subject: [PATCH 2/2] arm: use fixmap for text patching when text is RO
In-Reply-To: <1396879071.3654.43.camel@linaro1.home>
References: <1396646870-29695-1-git-send-email-rabin@rab.in>
 <1396646870-29695-2-git-send-email-rabin@rab.in>
 <1396879071.3654.43.camel@linaro1.home>
Message-ID: <20140410193433.GA22746@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 02:57:51PM +0100, Jon Medhurst (Tixy) wrote:
> How does fixmap cope with cache colouring? Looking at the implementation
> it looks like it doesn't and so fixmap use on ARM is possibly buggy.
> 
> For the text patching case where we know there are no writeable mappings
> [1] this should be OK if we used set_fixmap_nocache here, so long as we
> also invalidated the dcache later for the proper virtual address.

OK.  The dcache invalidation for the proper virtual address is btw
already there via the call to flush_icache_range().

> [1] Can we know there are no writeable mappings though, the ftrace code
> modifying patches from Kees Cook have there own way of modifying text
> code permissions.

The ftrace patches does the modifications and the cache cleaning in
stop_machine(), so there should not be any dirty cache lines from those
writable mappings when we set up and write to these fixmaps.  Do you
still see a problem?

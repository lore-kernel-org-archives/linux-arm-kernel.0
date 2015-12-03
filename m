From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 3 Dec 2015 16:06:20 +0000
Subject: [PATCH v12 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <1449090513.6139.63.camel@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151127131306.GE23908@dhcppc13.redhat.com>
 <1448909475.31214.27.camel@infradead.org>
 <20151201021615.GA5704@dhcppc13.redhat.com>
 <20151201190337.GG29045@leverpostej>
 <1449090513.6139.63.camel@infradead.org>
Message-ID: <20151203160619.GA3527@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 01:08:33PM -0800, Geoff Levand wrote:
> Hi Mark,
> 
> On Tue, 2015-12-01 at 19:03 +0000, Mark Rutland wrote:
> > You can validly perform maintenance while the cache may allocate for a
> > region of memory, it's just that afterwards the cache may hold a clean
> > entries for that region.
> > 
> > You can clean/clean+invalidate to push data to the PoC, or you can
> > invalidate/clean+invalidate to ensure that no asynchronous writebacks
> > occur later (so long as you do not make a cacheable write to said
> > cacheline).
> > 
> > The only thing that you cannot guarantee is that there is not some clean
> > cacheline allocated for a region of memory to which cacheable accesses
> > may be performed.
> > 
> > Note that the kernel only requires its Image to be clean to the PoC. So
> > long as this is true, we know that there will not be asynchrnoous
> > writebacks, and can invalidate as necessary as part of the boot process.

I've realised that my wording here is somewhat confusing.

When I say "clean to the PoC", I mean that for a given PA the cache can
either:
* Not hold an entry (i.e. be invalid).
* Hold a clean entry, where the data is identical to that at the PoC.

> In v10, which worked for Mustang and Qualcomm, we had:
> 
>   clean+invalidate to PoC all source pages
>   disable d-cache
>   loop {
>     invalidate to PoC destination page
>     copy page source->destination
>   }
>   enter new image
> 
> In v11 I changed this, and it did not work for those platforms:
>  
>   clean+invalidate to PoC all source pages
>   clean+invalidate to PoC all destination pages
>   disable d-cache
>   loop {
>     copy page source->destination
>   }
>   enter new image
> 
> Based on your comments above I would think both should work OK.

No.

In the latter case, clean lines can be allocated before cacheable data
accesses are inhibited. So stale clean lines can shadow the data copied
via non-cacheable accesses.

While the cache is clean, it isn't clean to the PoC.

Thanks,
Mark.

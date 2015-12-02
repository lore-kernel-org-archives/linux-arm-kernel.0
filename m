From: geoff@infradead.org (Geoff Levand)
Date: Wed, 02 Dec 2015 13:08:33 -0800
Subject: [PATCH v12 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <20151201190337.GG29045@leverpostej>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151127131306.GE23908@dhcppc13.redhat.com>
 <1448909475.31214.27.camel@infradead.org>
 <20151201021615.GA5704@dhcppc13.redhat.com>
 <20151201190337.GG29045@leverpostej>
Message-ID: <1449090513.6139.63.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 2015-12-01 at 19:03 +0000, Mark Rutland wrote:
> You can validly perform maintenance while the cache may allocate for a
> region of memory, it's just that afterwards the cache may hold a clean
> entries for that region.
> 
> You can clean/clean+invalidate to push data to the PoC, or you can
> invalidate/clean+invalidate to ensure that no asynchronous writebacks
> occur later (so long as you do not make a cacheable write to said
> cacheline).
> 
> The only thing that you cannot guarantee is that there is not some clean
> cacheline allocated for a region of memory to which cacheable accesses
> may be performed.
> 
> Note that the kernel only requires its Image to be clean to the PoC. So
> long as this is true, we know that there will not be asynchrnoous
> writebacks, and can invalidate as necessary as part of the boot process.

In v10, which worked for Mustang and Qualcomm, we had:

  clean+invalidate to PoC all source pages
  disable d-cache
  loop {
    invalidate to PoC destination page
    copy page source->destination
  }
  enter new image

In v11 I changed this, and it did not work for those platforms:
 
  clean+invalidate to PoC all source pages
  clean+invalidate to PoC all destination pages
  disable d-cache
  loop {
    copy page source->destination
  }
  enter new image

Based on your comments above I would think both should work OK.

-Geoff
  

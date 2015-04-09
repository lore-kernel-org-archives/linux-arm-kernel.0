From: jim.epost@gmail.com (Jim Davis)
Date: Thu, 9 Apr 2015 16:22:41 -0700
Subject: [PATCH] mempool: add missing include
In-Reply-To: <alpine.DEB.2.10.1504091608410.21208@chino.kir.corp.google.com>
References: <3302342.cNyRUGN06P@wuerfel>
 <alpine.DEB.2.10.1504091230400.11370@chino.kir.corp.google.com>
 <6079838.EgducKeYG3@wuerfel>
 <alpine.DEB.2.10.1504091608410.21208@chino.kir.corp.google.com>
Message-ID: <CA+r1Zhjq0UNnEKMz4mMgki_qCoo-zpSd7pxVYCNw6aXK2dJ=Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 9, 2015 at 4:12 PM, David Rientjes <rientjes@google.com> wrote:
> On Thu, 9 Apr 2015, Arnd Bergmann wrote:
>
>> > > This is a fix^3 for the mempool poisoning patch, which introduces
>> > > a compile-time error on some ARM randconfig builds:
>> > >
>> > > mm/mempool.c: In function 'check_element':
>> > > mm/mempool.c:65:16: error: implicit declaration of function 'kmap_atomic' [-Werror=implicit-function-declaration]
>> > >    void *addr = kmap_atomic((struct page *)element);
>> > >
>> > > The problem is clearly the missing declaration, and including
>> > > linux/highmem.h fixes it.
>> > >
>> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > > Fixes: a3db5a8463b0db ("mm, mempool: poison elements backed by page allocator fix fix")
>> >
>> > Acked-by: David Rientjes <rientjes@google.com>
>> >
>> > Thanks!  Can you confirm that this is because CONFIG_BLOCK is disabled and
>> > not something else?
>>
>> Unfortunately I've lost the information which build was responsible
>> for this error (normally I keep it, but my script failed here because the
>> same config introduced two new regressions). CONFIG_BLOCK sounds plausible
>> here.
>>
>> If necessary, I can repeat the last few hundred builds without this
>> patch to find out what it was.
>>
>
> Ok, thanks.  The only reason I ask is because if this is CONFIG_BLOCK then
> it shouldn't be arm specific and nothing else has reported it.

The random configuration file included in
http://marc.info/?l=linux-mm&m=142851035816974&w=2 doesn't have
CONFIG_BLOCK set.  That build failure was on an x86_32 system.

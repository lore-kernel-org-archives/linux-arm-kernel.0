From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Thu, 9 Feb 2017 10:59:56 +0100
Subject: [RFC][PATCH] treewide: Move set_memory_* functions away from
 cacheflush.h
In-Reply-To: <1486501816-27600-1-git-send-email-labbott@redhat.com>
References: <1486501816-27600-1-git-send-email-labbott@redhat.com>
Message-ID: <20170209095956.GB4159@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 01:10:16PM -0800, Laura Abbott wrote:
> The set_memory_* APIs came out of a desire to have a better way to
> change memory attributes. Many of these attributes were linked to cache
> functionality so the prototypes were put in cacheflush.h. These days,
> the APIs have grown and have a much wider use than just cache APIs. To
> support this growth, split off set_memory_* and friends into a separate
> header file to avoid growing cacheflush.h for APIs that have nothing to
> do with caches.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> This came out of a comment Russell made while reviewing RODATA test cases
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/480855.html
> While the final result of that series was the rodata code was refactored into
> its own header file, the set_memory_* APIs are still out of place.
> 
> This is a simple attempt at moving all the API stubs to their own file.
> Another idea I had was throwing set_memory_{x,nx,ro,rw} in an asm-generic
> file since those are commonly used for module setting across all arches.
> 
> This is an RFC to see if this is actually beneficial. The diffstat is not
> negative unfortunately due to header guards in newer files.
> I have patches to convert call sites over to set_memory.h instead of
> cacheflush.h if there is sufficient interest.
> ---
>  arch/arm/include/asm/cacheflush.h   |  21 +-------
>  arch/arm/include/asm/set_memory.h   |  32 ++++++++++++
>  arch/arm64/include/asm/cacheflush.h |   6 +--
>  arch/arm64/include/asm/set_memory.h |  26 ++++++++++
>  arch/s390/include/asm/cacheflush.h  |   6 +--
>  arch/s390/include/asm/set_memory.h  |   9 ++++
>  arch/x86/include/asm/cacheflush.h   |  96 +---------------------------------
>  arch/x86/include/asm/set_memory.h   | 100 ++++++++++++++++++++++++++++++++++++
>  8 files changed, 171 insertions(+), 125 deletions(-)
>  create mode 100644 arch/arm/include/asm/set_memory.h
>  create mode 100644 arch/arm64/include/asm/set_memory.h
>  create mode 100644 arch/s390/include/asm/set_memory.h
>  create mode 100644 arch/x86/include/asm/set_memory.h

For s390:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

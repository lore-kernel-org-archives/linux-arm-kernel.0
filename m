From: mpe@ellerman.id.au (Michael Ellerman)
Date: Fri, 23 Jun 2017 17:01:42 +1000
Subject: [PATCH 3/4] powerpc: Reduce ELF_ET_DYN_BASE
In-Reply-To: <1498154792-49952-4-git-send-email-keescook@chromium.org>
References: <1498154792-49952-1-git-send-email-keescook@chromium.org>
 <1498154792-49952-4-git-send-email-keescook@chromium.org>
Message-ID: <87podvp4q1.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kees Cook <keescook@chromium.org> writes:

> Now that explicitly executed loaders are loaded in the mmap region,
> position PIE binaries lower in the address space to avoid possible
> collisions with mmap or stack regions. For 64-bit, align to 4GB to
> allow runtimes to use the entire 32-bit address space for 32-bit
> pointers.

The change log and subject are a bit out of whack with the actual patch
because previously we used 512MB.

How about?

  powerpc: Move ELF_ET_DYN_BASE to 4GB / 4MB
  
  Now that explicitly executed loaders are loaded in the mmap region,
  we have more freedom to decide where we position PIE binaries in the
  address space to avoid possible collisions with mmap or stack regions.
  
  For 64-bit, align to 4GB to allow runtimes to use the entire 32-bit
  address space for 32-bit pointers. On 32-bit use 4MB.


Is there any particular reasoning behind the 4MB value on 32-bit?


I gave this a quick spin and it booted OK on all my test boxes, which
covers 64-bit/32-bit kernel and userspace. So seems to work!

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Apr 2014 11:45:03 +0100
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <5347655B.3080307@linaro.org>
References: <1397023132-10313-1-git-send-email-victor.kamensky@linaro.org>
 <1397023132-10313-2-git-send-email-victor.kamensky@linaro.org>
 <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
Message-ID: <20140423104503.GA2212@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 11:45:31PM -0400, David Long wrote:
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 04709b6..2e976fb 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -241,7 +241,7 @@ static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, in
>  static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
>  {
>  	void *kaddr = kmap_atomic(page);
> -	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
> +	copy_to_user_page(NULL, page, vaddr, kaddr + (vaddr & ~PAGE_MASK), src, len);
>  	kunmap_atomic(kaddr);
>  }

Rather than changing all the architectures to be able to pass a NULL vma
to copy_to_user_page(), you can create a dummy vma on the stack with the
VM_EXEC flag and pass a pointer to it.

-- 
Catalin

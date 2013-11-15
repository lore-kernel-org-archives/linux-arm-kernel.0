From: dave@sr71.net (Dave Hansen)
Date: Fri, 15 Nov 2013 07:53:34 -0800
Subject: [RFC PATCH 3/4] mm/vmalloc.c: Allow lowmem to be tracked in
 vmalloc
In-Reply-To: <5285A896.3030204@codeaurora.org>
References: <1384212412-21236-1-git-send-email-lauraa@codeaurora.org>
 <1384212412-21236-4-git-send-email-lauraa@codeaurora.org>
 <52850C37.1080506@sr71.net> <5285A896.3030204@codeaurora.org>
Message-ID: <5286437E.6040905@sr71.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2013 08:52 PM, Laura Abbott wrote:
> free (ptr) {
>     if (is_vmalloc_addr(ptr)
>         vfree
>     else
>         kfree
> }
> 
> so my hypothesis would be that any path would have to be willing to take
> the penalty of vmalloc anyway. The actual cost would depend on the
> vmalloc / kmalloc ratio. I haven't had a chance to get profiling data
> yet to see the performance difference.

Well, either that, or these kinds of things where it is a fallback:

>         hc = kmalloc(hsize, GFP_NOFS | __GFP_NOWARN);
>         if (hc == NULL)
>                 hc = __vmalloc(hsize, GFP_NOFS, PAGE_KERNEL);

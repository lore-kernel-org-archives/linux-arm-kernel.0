From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Nov 2013 00:13:15 +0000
Subject: [RFC 0/4] Intermix Lowmem and vmalloc
In-Reply-To: <1384212412-21236-1-git-send-email-lauraa@codeaurora.org>
References: <1384212412-21236-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20131112001315.GD16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 03:26:48PM -0800, Laura Abbott wrote:
> Hi,
> 
> This is an RFC for a feature to allow lowmem and vmalloc virtual address space
> to be intermixed. This has currently only been tested on a narrow set of ARM
> chips.
> 
> Currently on 32-bit systems we have
> 
> 
>                   Virtual                             Physical
> 
>    PAGE_OFFSET   +--------------+     PHYS_OFFSET   +------------+
>                  |              |                   |            |
>                  |              |                   |            |
>                  |              |                   |            |
>                  | lowmem       |                   |  direct    |
>                  |              |                   |   mapped   |
>                  |              |                   |            |
>                  |              |                   |            |
>                  |              |                   |            |
>                  +--------------+------------------>x------------>
>                  |              |                   |            |
>                  |              |                   |            |
>                  |              |                   |  not-direct|
>                  |              |                   | mapped     |
>                  | vmalloc      |                   |            |
>                  |              |                   |            |
>                  |              |                   |            |
>                  |              |                   |            |
>                  +--------------+                   +------------+
> 
> Where part of the virtual spaced above PHYS_OFFSET is reserved for direct
> mapped lowmem and part of the virtual address space is reserved for vmalloc.

Minor nit...

ITYM PAGE_OFFSET here.  vmalloc space doesn't exist in physical memory.

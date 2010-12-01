From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Dec 2010 20:14:40 +0000
Subject: bad pmd
In-Reply-To: <4CF6A7F2.80206@sdgsystems.com>
References: <4CF6A7F2.80206@sdgsystems.com>
Message-ID: <20101201201440.GD29347@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 02:54:26PM -0500, Aric D. Blumer wrote:
> Hi.  I'm using the long-term stable kernel 2.6.32 on a PXA320 platform,
> and I'm seeing errors like the following:
> 
> /home/aric/sdg/git/linux/mm/memory.c:144: bad pmd 8040542e.
> 
> I have seen these messages on both the 2.6.32.15 and 2.6.32.24 kernels
> (haven't tried others).  Can someone tell me what the message means?  I
> suspect memory is being clobbered.  One interesting thing is that
> whenever that message is printed, the 8040542e is always the same.  I
> have not been able to establish any correlation yet with what causes it.

A pmd value of 0x8040542e is a section mapping, which the generic MM
code will not understand.

It is for address 0x80400000, is read/writable from SVC mode, inaccessible
from user mode, domain 1 (which is normally for 'user' memory), and has
a memory type of TEXCB=10111.

As standard mainline doesn't create mappings with TEX=101, and we don't
create mappings with the 'user' domain using sections, the question this
immediately raises is: have you modified this kernel?

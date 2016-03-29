From: joseph@codesourcery.com (Joseph Myers)
Date: Tue, 29 Mar 2016 15:54:52 +0000
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <3298847.t7vI4YM3gJ@wuerfel>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <20160329120147.GA3551@yury-N73SV> <56FA816D.60101@huawei.com>
 <3298847.t7vI4YM3gJ@wuerfel>
Message-ID: <alpine.DEB.2.10.1603291551420.20115@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Mar 2016, Arnd Bergmann wrote:

> In glibc, I think we need to define fewer entry points, not more.
> Instead of having both lseek and lseek64, only one of them should
> be provided, and that should always take a 64-bit offset, calling
> into the kernel with the _llseek syscall entry.

lseek64 is part of the public API, on all platforms.  It should be aliased 
to lseek where possible.

Strictly, it would be possible to provide it in the API without it being 
part of the ABI, by arranging the headers so that calls to lseek64 result 
in objects with a reference to lseek (because it uses the off64_t typedef, 
it's not valid to declare it yourself rather than including a header that 
declares it).  I don't think it would be a good idea for a new 
sub-architecture port to try introducing such a difference from all other 
ports, however.

-- 
Joseph S. Myers
joseph at codesourcery.com

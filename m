From: jhogan@kernel.org (James Hogan)
Date: Thu, 12 Apr 2018 22:51:50 +0100
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
Message-ID: <20180412215149.GA27802@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 08:55:04AM -0400, Sinan Kaya wrote:
> While a barrier is present in writeX() function before the register write,
> a similar barrier is missing in the readX() function after the register
> read. This could allow memory accesses following readX() to observe
> stale data.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>

Both patches look like obvious improvements to me, so I'm happy to apply
to my fixes branch.

I'm guessing the case of a write to DMA buffer (i.e. reusing it) after a
MMIO readX() (checking DMA complete) being visible to DMA reads prior to
the readX() is precluded by a control dependency (you shouldn't reuse
buffer until you've checked DMA is complete).

But why don't we always use wmb() in the writeX() case? Might not the
cached write to DMA buffer be reordered with the uncached write to MMIO
register from the coherent DMA point of view? I'm waiting on feedback
from MIPS hardware folk on this topic.

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/086384f7/attachment.sig>

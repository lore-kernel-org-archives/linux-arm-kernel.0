From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Oct 2012 15:03:55 +0100
Subject: bug with 3.4.6, 3.5.3, 3.6.1
In-Reply-To: <5076D12A.1070700@xenomai.org>
References: <50765D3B.6000909@xenomai.org>
 <20121011103637.GC30598@mudshark.cambridge.arm.com>
 <5076CA56.3020006@xenomai.org>
 <20121011135905.GL30598@mudshark.cambridge.arm.com>
 <5076D12A.1070700@xenomai.org>
Message-ID: <20121011140355.GM30598@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2012 at 03:01:14PM +0100, Gilles Chanteperdrix wrote:
> On 10/11/2012 03:59 PM, Will Deacon wrote:
> > On Thu, Oct 11, 2012 at 02:32:06PM +0100, Gilles Chanteperdrix wrote:
> >> So, PHYS_OFFSET is 0x80000000 that is, 2GB.
> > 
> > Argh, then there's something fishy with the interaction between the idmap
> > and swapper. The overwritten entries *should* be identical, but something is
> > causing us to corrupt the initial tables from pgd_alloc(). Perhaps something
> > to do with us mapping in sections...
> > 
> > I'll have to do some digging and get back to you.
> 
> To satisfy my curiosity, what is the difference between VMSPLIT_3G and
> VMSPLIT_2G? The fact that with VMSPLIT_2G with have physical == virtual?

Yup, but we still create an idmap in that case (we could detect this case
and avoid doing it instead) and somehow it's corrupting the underlying
kernel mapping, despite mapping the same stuff.

Will

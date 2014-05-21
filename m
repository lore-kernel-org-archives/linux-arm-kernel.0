From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 21 May 2014 10:02:03 +0100
Subject: [PATCH v9 14/14] virt: arm: support hip04 gic
In-Reply-To: <CAD6h2NRv3hUa7vhbxVb1LhYi9K5OMVf01pyqp6yUC-+0zU8jkQ@mail.gmail.com>
References: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
 <1400591427-21922-15-git-send-email-haojian.zhuang@linaro.org>
 <20140520134441.GK5292@lvm>
 <CAD6h2NQyG1GSneWMpHmYxD-dPS7w9w2fe8vDdj-f834T2yqn1w@mail.gmail.com>
 <20140520140153.GL5292@lvm>
 <CAD6h2NQZGBa5U0-tmj=wtsFpcqnV2tHx+_vESrx8+3r7dGpHjQ@mail.gmail.com>
 <20140520150518.GA39503@lvm>
 <CAD6h2NRv3hUa7vhbxVb1LhYi9K5OMVf01pyqp6yUC-+0zU8jkQ@mail.gmail.com>
Message-ID: <20140521090203.GB39503@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 11:39:12PM +0800, Haojian Zhuang wrote:
> On 20 May 2014 23:05, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Tue, May 20, 2014 at 10:16:22PM +0800, Haojian Zhuang wrote:
> >> On 20 May 2014 22:01, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> >> It's the implementation of gich_apr in arm32.
> >>
> >> We needn't add or change anything in struct vgic_cpu. And both the
> >> assembly code and the code could be much easier.
> >>
> >
> > But we do end up with an extra memory access from EL2 in the critical
> > path, and I believe Marc's concern here is that if we cross a cache
> > line, this might really hurt performance.
> >
> 
> Sorry. Do we may cross a cache line or a TLB entry?
> 
> I think that you're concerning to cross TLB entries. The reason is in
>  below.
> 
> 1. If the problem is on crossing cache line, it's caused by too much
> instructions. Either the packing nr_lr or the gich_apr adds some
> instructions. The packing nr_lr needs a little more instructions.

I don't see why this argument is valid.  If you have a separate
instruction and data cache, you may be loading from a different cache
line when placing the static value close to your instructions.  If you
add a variable to the vcpu struct, all of the fields may no longer fit
in a single data cache line and you may cause the memory subsystem to
have to fetch another cache line.  I believe the latter is Marc's
concern, and I suspect he would be equally concerned about the former.

I'm not too concerned about a TLB entry here, that works at a 4K
granularity and with the proper alignment of the struct and hyp code,
that shouldn't be a concern.  Without it, of course, there's a risk of
requiring another TLB entry as well.


> 
> 2. ldr instruction is a pseudo instruction. So it's parsed into operation
> on PC register.

Eh, it just means that it does a load relative from the PC address, and
if the offset is too far to be encoded in the immediate field, then it
does an indirect load through a literal pool, if I understand what you
are referring to.  In any case, there will be at least one actual ldr
instruction issued on the PE.

> Now I put gich_apr in interrupts_head.S, it results
> in gich_apr variable before __kvm_hyp_code_start. It may cross the
> TLB entries.
> How about to declare gich_apr after __kvm_cpu_return in interrupts.S?
> Since save_vgic_state & restore_vgic_state is only used once, declaring
> gich_apr just after the code could avoid crossing TLB entry.
> 

Again, all the fields in the vcpu struct are quite likely to be aligned
within a single data cache line, I don't believe that's the case if you
stick some data in between the the hyp code.

-Christoffer

From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 17 Jul 2018 14:31:05 +0900
Subject: [PATCH v11 03/15] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
In-Reply-To: <20180716122412.GA7160@dhcp-128-65.nay.redhat.com>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-4-takahiro.akashi@linaro.org>
 <20180714015223.GA2745@dhcp-128-65.nay.redhat.com>
 <2a4ec965-5258-5835-3022-8f403a2f6bdd@arm.com>
 <20180716122412.GA7160@dhcp-128-65.nay.redhat.com>
Message-ID: <20180717053104.GB11258@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Mon, Jul 16, 2018 at 08:24:12PM +0800, Dave Young wrote:
> On 07/16/18 at 12:04pm, James Morse wrote:
> > Hi Dave,
> > 
> > On 14/07/18 02:52, Dave Young wrote:
> > > On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
> > >> Memblock list is another source for usable system memory layout.
> > >> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
> > >> other memblock-based architectures, particularly arm64, can also utilise
> > >> it. A moved function is now renamed to kexec_walk_memblock() and merged
> > >> into the existing arch_kexec_walk_mem() for general use, either resource
> > >> list or memblock list.
> > >>
> > >> A consequent function will not work for kdump with memblock list, but
> > >> this will be fixed in the next patch.
> > 
> > >> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > 
> > >> @@ -513,6 +563,10 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> > >>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > >>  			       int (*func)(struct resource *, void *))
> > >>  {
> > >> +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> > >> +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> > >> +		return kexec_walk_memblock(kbuf, func);
> > > 
> > > AKASHI, I'm not sure if this works on all arches, for example I chekced
> > > the .config on my Nokia N900 kernel tree, there is HAVE_MEMBLOCK=y and
> > > no CONFIG_ARCH_DISCARD_MEMBLOCK, in 32bit arm code no arch_kexec_walk_mem()
> > By doesn't work you mean it's a change in behaviour?
> > I think this is fine because 32bit arm doesn't support KEXEC_FILE, (this file is
> > kexec_file specific right?).
> 
> Ah, replied on a train, I forgot this is only for kexec_file, sorry
> about that.  Please ignore the comment.
> 
> But since we have a weak function arch_kexec_walk_mem, adding another
> condition branch within this weak function looks not good.
> Something like below would be better:

I see your concern here, but


> int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> {
>         int ret;
> 
> 	+ if use memblock
> 	+	ret = kexec_walk_memblock()
> 	+ else
>         	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> 
>         return ret == 1 ? 0 : -EADDRNOTAVAIL;
> }

what if yet another architecture comes to kexec_file and wanna
take a third approach? How can it override those functions?
Depending on kernel configuration, it might re-define either
kexec_walk_memblock() or arch_kexec_walk_mem(). It sounds weird to me.

Thanks,
-Takahiro AKASHI

> 
> > 
> > It only affects architectures with MEMBLOCK and KEXEC_FILE: powerpc, s390 and
> > soon arm64. s390 keeps its behaviour because it provides arch_kexec_walk_mem(),
> > and powerpc's is copied in here as its generic 'memblock describes my memory'
> > stuff. The implementation would be the same on arm64, so we're doing this to
> > avoid duplicating otherwise generic arch code. I think 32bit arm should be able
> > to use this too if it gets KEXEC_FILE support. (32bit arms' KEXEC already
> > depends on MEMBLOCK).
> > 
> > 
> > Thanks,
> > 
> > James
> 
> Thanks
> Dave

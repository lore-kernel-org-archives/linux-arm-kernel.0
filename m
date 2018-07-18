From: dyoung@redhat.com (Dave Young)
Date: Wed, 18 Jul 2018 14:45:19 +0800
Subject: [PATCH v11 03/15] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
In-Reply-To: <20180718064041.GI11258@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-4-takahiro.akashi@linaro.org>
 <20180714015223.GA2745@dhcp-128-65.nay.redhat.com>
 <2a4ec965-5258-5835-3022-8f403a2f6bdd@arm.com>
 <20180716122412.GA7160@dhcp-128-65.nay.redhat.com>
 <20180717053104.GB11258@linaro.org>
 <20180717074923.GA8591@dhcp-128-65.nay.redhat.com>
 <20180718053818.GF11258@linaro.org>
 <20180718061350.GA5086@dhcp-128-65.nay.redhat.com>
 <20180718064041.GI11258@linaro.org>
Message-ID: <20180718064519.GB5324@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/18 at 03:40pm, AKASHI Takahiro wrote:
> On Wed, Jul 18, 2018 at 02:13:50PM +0800, Dave Young wrote:
> > Hi AKASHI,
> > 
> > On 07/18/18 at 02:38pm, AKASHI Takahiro wrote:
> > > Dave,
> > > 
> > > On Tue, Jul 17, 2018 at 03:49:23PM +0800, Dave Young wrote:
> > > > Hi AKASHI,
> > > > On 07/17/18 at 02:31pm, AKASHI Takahiro wrote:
> > > > > Hi Dave,
> > > > > 
> > > > > On Mon, Jul 16, 2018 at 08:24:12PM +0800, Dave Young wrote:
> > > > > > On 07/16/18 at 12:04pm, James Morse wrote:
> > > > > > > Hi Dave,
> > > > > > > 
> > > > > > > On 14/07/18 02:52, Dave Young wrote:
> > > > > > > > On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
> > > > > > > >> Memblock list is another source for usable system memory layout.
> > > > > > > >> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
> > > > > > > >> other memblock-based architectures, particularly arm64, can also utilise
> > > > > > > >> it. A moved function is now renamed to kexec_walk_memblock() and merged
> > > > > > > >> into the existing arch_kexec_walk_mem() for general use, either resource
> > > > > > > >> list or memblock list.
> > > > > > > >>
> > > > > > > >> A consequent function will not work for kdump with memblock list, but
> > > > > > > >> this will be fixed in the next patch.
> > > > > > > 
> > > > > > > >> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > > > 
> > > > > > > >> @@ -513,6 +563,10 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> > > > > > > >>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > > > > > > >>  			       int (*func)(struct resource *, void *))
> > > > > > > >>  {
> > > > > > > >> +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> > > > > > > >> +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> > > > > > > >> +		return kexec_walk_memblock(kbuf, func);
> > > > > > > > 
> > > > > > > > AKASHI, I'm not sure if this works on all arches, for example I chekced
> > > > > > > > the .config on my Nokia N900 kernel tree, there is HAVE_MEMBLOCK=y and
> > > > > > > > no CONFIG_ARCH_DISCARD_MEMBLOCK, in 32bit arm code no arch_kexec_walk_mem()
> > > > > > > By doesn't work you mean it's a change in behaviour?
> > > > > > > I think this is fine because 32bit arm doesn't support KEXEC_FILE, (this file is
> > > > > > > kexec_file specific right?).
> > > > > > 
> > > > > > Ah, replied on a train, I forgot this is only for kexec_file, sorry
> > > > > > about that.  Please ignore the comment.
> > > > > > 
> > > > > > But since we have a weak function arch_kexec_walk_mem, adding another
> > > > > > condition branch within this weak function looks not good.
> > > > > > Something like below would be better:
> > > > > 
> > > > > I see your concern here, but
> > > > > 
> > > > > 
> > > > > > int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> > > > > > {
> > > > > >         int ret;
> > > > > > 
> > > > > > 	+ if use memblock
> > > > > > 	+	ret = kexec_walk_memblock()
> > > > > > 	+ else
> > > > > >         	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> > > > > > 
> > > > > >         return ret == 1 ? 0 : -EADDRNOTAVAIL;
> > > > > > }
> > > > > 
> > > > > what if yet another architecture comes to kexec_file and wanna
> > > > > take a third approach? How can it override those functions?
> > > > > Depending on kernel configuration, it might re-define either
> > > > > kexec_walk_memblock() or arch_kexec_walk_mem(). It sounds weird to me.
> > > > 
> > > > I also feel this weird, but it is slightly better because currently no
> > > > user need another overriding requirement, and I feel it is not expected to have in
> > > > the future for the memblock use.
> > > > 
> > > > Rethinking about this issue, we can just remove the weak function and
> > > > just use general function.
> > > 
> > > Do you really want to remove "weak" attribute?
> > > 
> > > > Currently with your patch applied only s390 use arch_kexec_walk_mem like
> > > > below:
> > > > /*
> > > >  * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
> > > >  * and provide kbuf->mem by hand.
> > > >  */
> > > > int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > > >                         int (*func)(struct resource *, void *))
> > > > {
> > > >         return 1;
> > > > }
> > > > 
> > > > AFAIK, all other users initialize kbuf->mem as NULL, so we can check
> > > 
> > > As a matter of fact, nobody initializes kbuf->mem before calling
> > > kexec_add_buffer (in turn, kexec_locate_mem_hole()).
> > 
> > Not sure we understand each other..
> > Let's take an example in arch/x86/kernel/kexec-bzimage64.c:
> > bzImage64_load() :
> > 	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
> > 				.top_down = true };
> > 
> > Except the three fields above other members will be initialized as zero
> > when compiling including the kbuf->mem
> 
> Ah, you're right.
> (My armr64 patch doesn't use struct initializer, though.)
> 
> > > 
> > > > kbuf->mem in int kexec_locate_mem_hole:
> > > > 
> > > > if (kbuf->mem)
> > > > 	return 0;
> > > > 
> > > > if use memblock
> > > > 	kexec_walk_memblock
> > > > else
> > > > 	kexec_walk_mem
> > 
> > kexec_walk_resource will be better than kexec_walk_mem
> > 
> > > 
> > > I think that your solution will work for existing architectures
> > > with appropriate patches, but to take your approach, as I said above,
> > > we will have to modify every call site on all kexec_file-capable architectures.
> > > 
> > > If this is what you expect, I will work on it, but I don't think
> > > that it would be a better idea.
> 
> So you would expect me to modify my own arm64 code as well as s390.

Yes :)  But I had not get time to read all your patches so I was not
aware the struct initialization in arm64 code so I assumed only s390
need a change..

Thanks
Dave

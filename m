From: gleb@redhat.com (Gleb Natapov)
Date: Wed, 16 Jan 2013 18:21:40 +0200
Subject: [PATCH v5 07/14] KVM: ARM: World-switch implementation
In-Reply-To: <CANM98qLtf0i1LA3KT3xT0ivS3U9ioA_HkKQHwe6ZzXHNuYOONw@mail.gmail.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183924.46302.65998.stgit@ubuntu>
 <20130115094312.GI11529@redhat.com>
 <CANM98q+qScaXniyYjrd9QEZzWKzj3PkCE0YNFUp2ijnCfS_v4w@mail.gmail.com>
 <20130116121238.GS11529@redhat.com>
 <CANM98q+jpzVWfg8drE+azcbDF1Q1suphZyJrij04b+OB4ZX4Dw@mail.gmail.com>
 <20130116155212.GX11529@redhat.com>
 <CANM98qLtf0i1LA3KT3xT0ivS3U9ioA_HkKQHwe6ZzXHNuYOONw@mail.gmail.com>
Message-ID: <20130116162140.GZ11529@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 11:17:06AM -0500, Christoffer Dall wrote:
> On Wed, Jan 16, 2013 at 10:52 AM, Gleb Natapov <gleb@redhat.com> wrote:
> > On Wed, Jan 16, 2013 at 10:42:02AM -0500, Christoffer Dall wrote:
> >> [...]
> >>
> >> >
> >> >> read side RCU protects against is the memslots data structure as far
> >> >> as I can see, so the second patch pasted below fixes this for the code
> >> >> that actually accesses this data structure.
> >> > Many memory related functions that you call access memslots under the
> >> > hood and assume that locking is done by the caller. From the quick look
> >> > I found those that you've missed:
> >> > kvm_is_visible_gfn()
> >> > kvm_read_guest()
> >> > gfn_to_hva()
> >> > gfn_to_pfn_prot()
> >> > kvm_memslots()
> >> >
> >> > May be there are more. Can you enable RCU debugging in your kernel config
> >> > and check? This does not guaranty that it will catch all of the places,
> >> > but better than nothing.
> >> >
> >>
> >> yeah, I missed the call to is_visible_gfn and friends, this fixes it:
> >>
> > Thank you. One more kvm_read_guest() in emulate.c.
> >
> 
> this one is going out for now (see the i/o discussion).
> 
I thought there wasn't resolution yet. Guess I missed something. If
kvm_read_guest() is removed from emulator then the patch looks good to me.

--
			Gleb.

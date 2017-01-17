From: mbenes@suse.cz (Miroslav Benes)
Date: Tue, 17 Jan 2017 14:53:06 +0100 (CET)
Subject: arm: Add livepatch arch specific code
In-Reply-To: <20170117002239.GF9045@packer-debian-8-amd64.digitalocean.com>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
 <1481043967-15602-2-git-send-email-abelvesa@linux.com>
 <alpine.LSU.2.20.1701161733531.17768@pobox.suse.cz>
 <20170117002239.GF9045@packer-debian-8-amd64.digitalocean.com>
Message-ID: <alpine.LSU.2.20.1701171452030.20563@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > But apply_relocate_add() is not implemented on arm yet. I guess it would
> > nice to have it... otherwise we could get to an unpleasant situation.
> > Livepatch module can rely on its livepatching relocations (that is, there
> > are some). apply_relocate_add() returns 0 on arm, so everything seems to
> > be nice and then boom some time later.
> 
> Doesn't it return -ENOEXEC? MODULES_USE_ELF_RELA is not defined
> on arm, I think (see moduleloader.h).

You're right. It confused me too.
 
> > The question is what happens with normal modules. There are no SHT_RELA
> > records probably.
> 
> For arm, I think there are only SHT_REL relocation sections
> (MODULES_USE_ELF_REL is set instead of MODULES_USE_ELF_RELA), so
> during apply_relocations() in load_module(), only apply_relocate()
> should be called, and not apply_relocate_add().

True.

> Hm, I guess that means if we want livepatch support for the
> architectures that don't support RELA relocations, we would have to
> check if the section is SHT_REL or SHT_RELA before calling the right
> apply_relocate* function.

Agreed.

Miroslav

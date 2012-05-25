From: ohaugan@codeaurora.org (Olav Haugan)
Date: Thu, 24 May 2012 17:24:01 -0700
Subject: mm: fix faulty initialization in vmalloc_init()
In-Reply-To: <20120524151231.e3a18ac5.akpm@linux-foundation.org>
References: <001c01cd3987$d1a71a50$74f54ef0$%cho@samsung.com>
 <20120524151231.e3a18ac5.akpm@linux-foundation.org>
Message-ID: <002c01cd3a0c$aef39530$0cdabf90$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> On Thu, 24 May 2012 17:32:56 +0900
> KyongHo <pullip.cho@samsung.com> wrote:
> 
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1185,9 +1185,10 @@ void __init vmalloc_init(void)
> >  	/* Import existing vmlist entries. */
> >  	for (tmp = vmlist; tmp; tmp = tmp->next) {
> >  		va = kzalloc(sizeof(struct vmap_area), GFP_NOWAIT);
 > -		va->flags = tmp->flags | VM_VM_AREA;
> > +		va->flags = VM_VM_AREA;
> 
> This change is a mystery.  Why do we no longer transfer ->flags?

I was actually debugging the same exact issue today. This transfer of flags
actually causes some of the static mapping virtual addresses to be
prematurely freed (before the mapping is removed) because VM_LAZY_FREE gets
"set" if tmp->flags has VM_IOREMAP set. This might cause subsequent
vmalloc/ioremap calls to fail because it might allocate one of the freed
virtual address ranges that aren't unmapped. 

--
Olav Haugan

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

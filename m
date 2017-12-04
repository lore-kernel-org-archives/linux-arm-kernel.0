From: ar@linux.vnet.ibm.com (Andrea Reale)
Date: Mon, 4 Dec 2017 11:34:12 +0000
Subject: [PATCH v2 0/5] Memory hotplug support for arm64 - complete
 patchset v2
In-Reply-To: <20171130145734.c62ggrx3r7335etc@dhcp22.suse.cz>
References: <cover.1511433386.git.ar@linux.vnet.ibm.com>
 <20171123160258.xmw5lxnjfch2dxfw@dhcp22.suse.cz>
 <20171123173331.GA15535@samekh>
 <20171130145734.c62ggrx3r7335etc@dhcp22.suse.cz>
Message-ID: <20171204113412.GB6373@samekh>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Thu 30 Nov 2017, 15:57, Michal Hocko wrote:
> On Thu 23-11-17 17:33:31, Andrea Reale wrote:
> > On Thu 23 Nov 2017, 17:02, Michal Hocko wrote:
> > 
> > Hi Michal,
> > 
> > > I will try to have a look but I do not expect to understand any of arm64
> > > specific changes so I will focus on the generic code but it would help a
> > > _lot_ if the cover letter provided some overview of what has been done
> > > from a higher level POV. What are the arch pieces and what is the
> > > generic code missing. A quick glance over patches suggests that
> > > changelogs for specific patches are modest as well. Could you give us
> > > more information please? Reviewing hundreds lines of code without
> > > context is a pain.
> > 
> > sorry for the lack of details. I will try to provide a better
> > overview in the following. Please, feel free to ask for more details
> > where needed.
> > 
> > Overall, the goal of the patchset is to implement arch_memory_add and
> > arch_memory_remove for arm64, to support the generic memory_hotplug
> > framework. 
> > 
> > Hot add
> > -------
> > Not so many surprises here. We implement the arch specific
> > arch_add_memory, which builds the kernel page tables via hotplug_paging()
> > and then calls arch specific add_pages(). We need the arch specific
> > add_pages() to implement a trick that makes the satus of pages being
> > added accepted by the asumptions made in the generic __add_pages. (See
> > code comments).
> 
> Actually I would like to see exactly this explained. The arch support of
> the hotplug should be basically only about arch_add_memory and add_pages
> resp. arch_remove_memory and __remove_pages. Nothing much more, really.
> The core hotplug code should take care of the rest. Ideally you
> shouldn't be really forced to touch the generic code. If yes than this
> should be called out explicitly.

For what concerns hot add, there are no changes to the core hotplug code
whatsoever; just arch_add_memory and add_pages.

For what concerns hot remove, there are two changes to generic code, as
described in the second part of https://lkml.org/lkml/2017/11/23/456.
The first is the removal of the BUG() call in arch_remove_memory and
moving it to ACPI code: I think we agree that calling BUG() from
arch_remove_memory is undesirable. I have to develop a better
understanding on how to get rid of it from ACPI as well.

The second are the memblock changes for vmemmap removal. 
I'll try to discuss this change in more details in a follow up email.

Thanks,
Andrea

> -- 
> Michal Hocko
> SUSE Labs
> 

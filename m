From: mhocko@kernel.org (Michal Hocko)
Date: Mon, 4 Dec 2017 13:33:56 +0100
Subject: [PATCH v2 4/5] mm: memory_hotplug: Add memory hotremove probe
 device
In-Reply-To: <20171204115129.GD6373@samekh>
References: <cover.1511433386.git.ar@linux.vnet.ibm.com>
 <22d34fe30df0fbacbfceeb47e20cb1184af73585.1511433386.git.ar@linux.vnet.ibm.com>
 <20171130144905.ntpovhy66gekj6e6@dhcp22.suse.cz>
 <20171204115129.GD6373@samekh>
Message-ID: <20171204123355.4tam7pfv34zmwzyu@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 04-12-17 11:51:29, Andrea Reale wrote:
> On Thu 30 Nov 2017, 15:49, Michal Hocko wrote:
> > On Thu 23-11-17 11:14:52, Andrea Reale wrote:
> > > Adding a "remove" sysfs handle that can be used to trigger
> > > memory hotremove manually, exactly simmetrically with
> > > what happens with the "probe" device for hot-add.
> > > 
> > > This is usueful for architecture that do not rely on
> > > ACPI for memory hot-remove.
> > 
> > As already said elsewhere, this really has to check the online status of
> > the range and fail some is still online.
> > 
> 
> This is actually still done in remove_memory() (patch 2/5) with
> walk_memory_range. We just return an error rather than BUGing().
> 
> Or are you referring to something else?

But you are not returning that error to the caller, are you?

[...]
> > > +	nid = memory_add_physaddr_to_nid(phys_addr);
> > > +	ret = lock_device_hotplug_sysfs();
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	remove_memory(nid, phys_addr,
> > > +			 MIN_MEMORY_BLOCK_SIZE * sections_per_block);
> > > +	unlock_device_hotplug();
> > > +	return count;

-- 
Michal Hocko
SUSE Labs

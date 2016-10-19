From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 19 Oct 2016 19:01:27 +0200
Subject: [PATCH 00/10] mm: adjust get_user_pages* functions to explicitly
 pass FOLL_* flags
In-Reply-To: <5807A427.7010200@linux.intel.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161018153050.GC13117@dhcp22.suse.cz>
 <20161019085815.GA22239@lucifer>
 <20161019090727.GE7517@dhcp22.suse.cz>
 <5807A427.7010200@linux.intel.com>
Message-ID: <20161019170127.GN24393@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 19-10-16 09:49:43, Dave Hansen wrote:
> On 10/19/2016 02:07 AM, Michal Hocko wrote:
> > On Wed 19-10-16 09:58:15, Lorenzo Stoakes wrote:
> >> On Tue, Oct 18, 2016 at 05:30:50PM +0200, Michal Hocko wrote:
> >>> I am wondering whether we can go further. E.g. it is not really clear to
> >>> me whether we need an explicit FOLL_REMOTE when we can in fact check
> >>> mm != current->mm and imply that. Maybe there are some contexts which
> >>> wouldn't work, I haven't checked.
> >>
> >> This flag is set even when /proc/self/mem is used. I've not looked deeply into
> >> this flag but perhaps accessing your own memory this way can be considered
> >> 'remote' since you're not accessing it directly. On the other hand, perhaps this
> >> is just mistaken in this case?
> > 
> > My understanding of the flag is quite limited as well. All I know it is
> > related to protection keys and it is needed to bypass protection check.
> > See arch_vma_access_permitted. See also 1b2ee1266ea6 ("mm/core: Do not
> > enforce PKEY permissions on remote mm access").
> 
> Yeah, we need the flag to tell us when PKEYs should be applied or not.
> The current task's PKRU (pkey rights register) should really only be
> used to impact access to the task's memory, but has no bearing on how a
> given task should access remote memory.

The question I had earlier was whether this has to be an explicit FOLL
flag used by g-u-p users or we can just use it internally when mm !=
current->mm

-- 
Michal Hocko
SUSE Labs

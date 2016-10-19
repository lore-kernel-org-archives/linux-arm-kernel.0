From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 19 Oct 2016 10:13:52 +0200
Subject: [PATCH 08/10] mm: replace __access_remote_vm() write parameter
 with gup_flags
In-Reply-To: <20161019075903.GP29967@quack2.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-9-lstoakes@gmail.com>
 <20161019075903.GP29967@quack2.suse.cz>
Message-ID: <20161019081352.GB7562@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 19-10-16 09:59:03, Jan Kara wrote:
> On Thu 13-10-16 01:20:18, Lorenzo Stoakes wrote:
> > This patch removes the write parameter from __access_remote_vm() and replaces it
> > with a gup_flags parameter as use of this function previously _implied_
> > FOLL_FORCE, whereas after this patch callers explicitly pass this flag.
> > 
> > We make this explicit as use of FOLL_FORCE can result in surprising behaviour
> > (and hence bugs) within the mm subsystem.
> > 
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> 
> So I'm not convinced this (and the following two patches) is actually
> helping much. By grepping for FOLL_FORCE we will easily see that any caller
> of access_remote_vm() gets that semantics and can thus continue search

I am really wondering. Is there anything inherent that would require
FOLL_FORCE for access_remote_vm? I mean FOLL_FORCE is a really
non-trivial thing. It doesn't obey vma permissions so we should really
minimize its usage. Do all of those users really need FOLL_FORCE?

Anyway I would rather see the flag explicit and used at more places than
hidden behind a helper function.
-- 
Michal Hocko
SUSE Labs

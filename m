From: dave.hansen@linux.intel.com (Dave Hansen)
Date: Wed, 19 Oct 2016 10:23:55 -0700
Subject: [PATCH 00/10] mm: adjust get_user_pages* functions to explicitly
 pass FOLL_* flags
In-Reply-To: <20161019170127.GN24393@dhcp22.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161018153050.GC13117@dhcp22.suse.cz> <20161019085815.GA22239@lucifer>
 <20161019090727.GE7517@dhcp22.suse.cz> <5807A427.7010200@linux.intel.com>
 <20161019170127.GN24393@dhcp22.suse.cz>
Message-ID: <5807AC2B.4090208@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2016 10:01 AM, Michal Hocko wrote:
> The question I had earlier was whether this has to be an explicit FOLL
> flag used by g-u-p users or we can just use it internally when mm !=
> current->mm

The reason I chose not to do that was that deferred work gets run under
a basically random 'current'.  If we just use 'mm != current->mm', then
the deferred work will sometimes have pkeys enforced and sometimes not,
basically randomly.

We want to be consistent with whether they are enforced or not, so we
explicitly indicate that by calling the remote variant vs. plain.

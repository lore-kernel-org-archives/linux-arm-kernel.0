From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 9 Apr 2013 14:04:32 -0700
Subject: [PATCH v3] [RESEND] mm: Make snapshotting pages for stable
 writes a per-bio operation
In-Reply-To: <20130409180617.GB8907@blackbox.djwong.org>
References: <20130409180617.GB8907@blackbox.djwong.org>
Message-ID: <20130409140432.cd69f999302a02caf73788fc@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Apr 2013 11:06:17 -0700 "Darrick J. Wong" <darrick.wong@oracle.com> wrote:

> +		 * Here we write back pagecache data that may be mmaped. Since
> +		 * we cannot afford to clean the page and set PageWriteback
> +		 * here due to lock ordering (page lock ranks above transaction
> +		 * start), the data can change while IO is in flight. Tell the
> +		 * block layer it should bounce the bio pages if stable data
> +		 * during write is required.

I think there are already ab/ba deadlocks between lock_page() and
journal_start().  iirc one path was write(), I forget which was the
other path.  This was 10+ years ago and nobody else noticed and I
didn't know how to fix it so I didn't tell anyone ;)

It would be neat to be able to hook things like journal_start() into
lockdep but I don't think that lockdep has easy provision for wiring
oddball things into its mechanisms.

From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jul 2018 15:37:28 +0100
Subject: [PATCH v5 00/20] APEI in_nmi() rework and arm64 SDEI wire-up
In-Reply-To: <20180626170116.25825-1-james.morse@arm.com>
References: <20180626170116.25825-1-james.morse@arm.com>
Message-ID: <20180704143727.GI4828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Tue, Jun 26, 2018 at 06:00:56PM +0100, James Morse wrote:
> The aim of this series is to wire arm64's SDEI into APEI.
> 
> On arm64 we have three APEI notifications that are NMI-like, and
> in the unlikely event that all three are supported by a platform,
> they can interrupt each other.
> The GHES driver shouldn't have to deal with this, so this series aims
> to make it re-entrant.
> 
> To do that, we refactor the estatus queue to allow multiple notifications
> to use it, then convert NOTIFY_SEA to always be described as NMI-like,
> and to use the estatus queue.
> 
> From here we push the locking and fixmap choices out to the notification
> functions, and remove the use of per-ghes estatus and flags. This removes
> the in_nmi() 'timebomb' in ghes_copy_tofrom_phys().
> 
> Things get sticky when an NMI notification needs to know how big the
> CPER records might be, before reading it. This series splits
> ghes_estatus_read() to let us peek at the buffer. A side effect of this
> is the 20byte header will get read twice. (how does it work today? it
> reads the records into a per-ghes worst-case sized buffer, allocates
> the correct size and copies the records. in_nmi() use of this per-ghes
> buffer needs eliminating).
> 
> One alternative was to trust firmware's 'max raw data length' and use
> that to allocate 'enough' memory. We don't use this value today, so its
> probably wrong on some sytem somewhere.
> 
> Since v4 patches 5,8-15 are new, otherwise changes are noted in the patch.

The little bits touching arch/arm64/ all look fine to me here, but it looks
like other patches need review separately and ultimately I suspect you're
going to route it via some other tree.

Let me know if you need me to help with anything.

Will

From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jul 2014 10:45:15 +0100
Subject: [PATCH v2 1/3] arm64: spin-table: handle unmapped
 cpu-release-addrs
In-Reply-To: <CAKv+Gu8ne8k2NV12SyWye5aYJKHG0wHKAO+=V=1L89_hvyGopw@mail.gmail.com>
References: <1406717944-24725-1-git-send-email-ard.biesheuvel@linaro.org>
 <1406717944-24725-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140730113013.GL12239@arm.com>
 <CAKv+Gu8ne8k2NV12SyWye5aYJKHG0wHKAO+=V=1L89_hvyGopw@mail.gmail.com>
Message-ID: <20140731094515.GE26853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 08:17:02PM +0100, Ard Biesheuvel wrote:
> ]On 30 July 2014 13:30, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Jul 30, 2014 at 11:59:02AM +0100, Ard Biesheuvel wrote:
> >> From: Mark Rutland <mark.rutland@arm.com>
> >>
> >> In certain cases the cpu-release-addr of a CPU may not fall in the
> >> linear mapping (e.g. when the kernel is loaded above this address due to
> >> the presence of other images in memory). This is problematic for the
> >> spin-table code as it assumes that it can trivially convert a
> >> cpu-release-addr to a valid VA in the linear map.
> >>
> >> This patch modifies the spin-table code to use a temporary cached
> >> mapping to write to a given cpu-release-addr, enabling us to support
> >> addresses regardless of whether they are covered by the linear mapping.
> >>
> >> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> >> Tested-by: Mark Salter <msalter@redhat.com>
> >> [ardb: added (__force void *) cast]
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/kernel/smp_spin_table.c | 22 +++++++++++++++++-----
> >>  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > I'm nervous about this. What if the spin table sits in the same physical 64k
> > frame as a read-sensitive device and we're running with 64k pages?
> >
> 
> Actually, booting.txt requires cpu-release-addr to point to a
> /memreserve/d part of memory, which implies DRAM (or you wouldn't have
> to memreserve it)
> That means it should always be covered by the linear mapping, unless
> it is located before Image in DRAM, which is the case addressed by
> this patch.

But if it's located before before the Image in DRAM and isn't covered by
the linear mapping, then surely the /memreserve/ is pointless too? In which
case, this looks like we're simply trying to cater for platforms that aren't
following booting.txt (which may need updating if we need to handle this).

Will

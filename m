From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Aug 2018 18:40:05 +0100
Subject: [PATCH] arm64: implement x86-compatible KPTI cmdline options
In-Reply-To: <1535110807-9104-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1535110807-9104-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20180828174005.GD20375@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 02:40:07PM +0300, Stanislav Kholmanskikh wrote:
> Both x86 and arm64 have KPTI. On both the archs the KPTI state
> can be controlled via kernel cmdline, but using different options.
> For x86 there are 'pti' and 'nopti', for arm64 - the undocumented 'kpti'
> option.
> 
> Having two distinct options for one feature seems to be unnecessary,
> and may complicate things a bit in mixed environments, so unification
> here seems to be a good idea.
> 
> I think x86 is a better candidate to serve as the common basis, since
> a) its options are already documented, b) it has KPTI merged earlier,
> c) it's more popular platform.
> 
> This patch implements 'pti' and 'nopti' for arm64, keeping 'kpti'
> for backwards compatibility.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    4 +-
>  arch/arm64/kernel/cpufeature.c                  |   41 +++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 2 deletions(-)

Is there a real need for this? Most architectures don't have parity on
command-line options, and the ship has already sailed for this option.
We didn't deliberately diverge, but by the time we realised that x86 had
chosen 'pti', we'd already grown backports (e.g. Android) using 'kpti'.
For a while we had 'kaiser', but that got changed early enough.

The important thing is that it defaults safe, so I'm not really inclined
to merge this patch.

Will

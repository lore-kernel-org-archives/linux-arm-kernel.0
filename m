From: drjones@redhat.com (Andrew Jones)
Date: Thu, 4 May 2017 15:05:20 +0200
Subject: [PATCH] KVM: arm/arm64: Move shared files to virt/kvm/arm
In-Reply-To: <20170504123311.25252-1-cdall@linaro.org>
References: <20170504123311.25252-1-cdall@linaro.org>
Message-ID: <20170504130520.qltxwf4zytehpn6k@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 02:33:11PM +0200, Christoffer Dall wrote:
> For some time now we have been having a lot of shared functionality
> between the arm and arm64 KVM support in arch/arm, which not only
> required a horrible inter-arch reference from the Makefile in
> arch/arm64/kvm, but also created confusion for newcomers to the code
> base, as was recently seen on the mailing list.
> 
> Further, it causes confusion for things like cscope, which needs special
> attention to index specific shared files for arm64 from the arm tree.

I'll probably still want the same cscope alias[*] to ensure I don't miss
ARM code when writing patches, but anyway, YAY to this patch!

[*] alias cs_arm64="make ALLSOURCE_ARCHS='arm64 arm' cscope"

> 
> Move the shared files into virt/kvm/arm and move the trace points along
> with it.  When moving the tracepoints we have to modify the way the vgic
> creates definitions of the trace points, so we take the chance to
> include the VGIC tracepoints in its very own special vgic trace.h file.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>
> ---
> Hi Marc,
> 
> What do you think of this?  If you like it, I think we should include it
> for this merge window.
> 
> Thanks,
> -Christoffer
> 
>  arch/arm/kvm/Makefile                 |   7 +-
>  arch/arm/kvm/trace.h                  | 247 ----------------------------------
>  arch/arm64/kvm/Makefile               |   5 +-
>  {arch/arm/kvm => virt/kvm/arm}/arm.c  |   0
>  {arch/arm/kvm => virt/kvm/arm}/mmio.c |   0
>  {arch/arm/kvm => virt/kvm/arm}/mmu.c  |   0
>  {arch/arm/kvm => virt/kvm/arm}/perf.c |   0
>  {arch/arm/kvm => virt/kvm/arm}/psci.c |   0
>  virt/kvm/arm/trace.h                  | 246 +++++++++++++++++++++++++++++++--
>  virt/kvm/arm/vgic/trace.h             |  37 +++++
>  virt/kvm/arm/vgic/vgic.c              |   2 +-
>  11 files changed, 280 insertions(+), 264 deletions(-)
>  rename {arch/arm/kvm => virt/kvm/arm}/arm.c (100%)
>  rename {arch/arm/kvm => virt/kvm/arm}/mmio.c (100%)
>  rename {arch/arm/kvm => virt/kvm/arm}/mmu.c (100%)
>  rename {arch/arm/kvm => virt/kvm/arm}/perf.c (100%)
>  rename {arch/arm/kvm => virt/kvm/arm}/psci.c (100%)
>  create mode 100644 virt/kvm/arm/vgic/trace.h
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 

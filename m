From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 6 May 2015 16:12:49 +0200
Subject: [RFC] ARM/ARM64: KVM: Implement KVM_FLUSH_DCACHE_GPA ioctl
In-Reply-To: <1430817191-6231-1-git-send-email-j.fanguede@virtualopensystems.com>
References: <1430817191-6231-1-git-send-email-j.fanguede@virtualopensystems.com>
Message-ID: <20150506141249.GA6796@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J?r?my,

On Tue, May 05, 2015 at 11:13:11AM +0200, J?r?my Fangu?de wrote:
> To maintain cache coherency on ARM, we may need a mechanism to flush
> the data cache.

In addition to generally just making this functionality available (see
below), do you have an actual use case in mind for this?  To solve the
VGA issue, for example, we already have a patch series from Drew trying
to address this.  Does that not work for you?

There was a long discussion about this here:
https://lists.cs.columbia.edu/pipermail/kvmarm/2015-February/013593.html

Drew then created a patch set, here:
https://lists.nongnu.org/archive/html/qemu-devel/2015-03/msg01254.html

and replied to himself, here:
https://www.marc.info/?l=android-virt&m=142670523929132&w=3

Which basically says that he doesn't like having to do flushes all over
QEMU (IIUC), so he sent this version instead:
https://lists.cs.columbia.edu/pipermail/kvmarm/2015-March/014027.html

Which he now said he'd respin.

Meanwhile there was also the idea of simply convincing the guest to
access devices as coherent through added DT properties etc., but I'm not
sure where that landed.

I think it would be better to agree to the overall approach before
sending out further patches.

On this particular patch, it does feel like sidestepping general kernel
functionality for arm64 through KVM, which I think is a bit weird.  I'd
like to hear Will and Catalin's thoughts on this before we'd go ahead
with something like this.

> 
> This patch implements KVM_FLUSH_DCACHE_GPA vm ioctl which flushes the
> data cache at a specified address range. The input argument is a
> struct kvm_mem_addr containing the guest physical address and the
> length.
> 
> Signed-off-by: J?r?my Fangu?de <j.fanguede@virtualopensystems.com>
> ---
>  arch/arm/kvm/arm.c       | 13 +++++++++++++
>  include/uapi/linux/kvm.h |  6 ++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index d9631ec..8638fd2 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -886,6 +886,19 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  
>  		return 0;
>  	}
> +	case KVM_FLUSH_DCACHE_GPA: {
> +		struct kvm_mem_addr mem_addr;
> +		hva_t hva;
> +		gpa_t gpa;
> +
> +		if (copy_from_user(&mem_addr, argp, sizeof(mem_addr)))
> +			return -EFAULT;
> +
> +		gpa = mem_addr.addr;
> +		hva = gfn_to_hva(kvm, gpa_to_gfn(gpa)) | (gpa & ~PAGE_MASK);
> +		kvm_flush_dcache_to_poc((void *)hva, mem_addr.len);

In case you end up moving further with this, see the following commit:

0d3e4d4 (arm/arm64: KVM: Use kernel mapping to perform invalidation on
page fault, 2015-01-05)

I think you end up with the same problem here.

-Christoffer

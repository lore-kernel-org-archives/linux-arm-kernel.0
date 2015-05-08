From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 May 2015 11:19:53 +0200
Subject: [PATCH v3 01/12] KVM: add comments for kvm_debug_exit_arch struct
In-Reply-To: <1430929407-3487-2-git-send-email-alex.bennee@linaro.org>
References: <1430929407-3487-1-git-send-email-alex.bennee@linaro.org>
 <1430929407-3487-2-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150508091953.GA24744@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 05:23:16PM +0100, Alex Benn?e wrote:
> Bring into line with the comments for the other structures and their
> KVM_EXIT_* cases. Also update api.txt to reflect use in kvm_run
> documentation.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> 
> ---
> 
> v2
>   - add comments for other exit types
> v3
>   - s/commentary/comments/
>   - add rb tags
>   - update api.txt kvm_run to include KVM_EXIT_DEBUG desc
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 9fa2bf8..cb90025 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -3070,11 +3070,13 @@ data_offset describes where the data is located (KVM_EXIT_IO_OUT) or
>  where kvm expects application code to place the data for the next
>  KVM_RUN invocation (KVM_EXIT_IO_IN).  Data format is a packed array.
>  
> +		/* KVM_EXIT_DEBUG */
>  		struct {
>  			struct kvm_debug_exit_arch arch;
>  		} debug;
>  
> -Unused.
> +If the exit_reason in KVM_EXIT_DEBUG, then a vcpu is processing a debug event

s/in/is/

> +for which architecture dependant information is returned.

s/dependant/dependent/  (but maybe architecture specific is better)

>  
>  		/* KVM_EXIT_MMIO */
>  		struct {
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 4b60056..70ac641 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -237,6 +237,7 @@ struct kvm_run {
>  			__u32 count;
>  			__u64 data_offset; /* relative to kvm_run start */
>  		} io;
> +		/* KVM_EXIT_DEBUG */
>  		struct {
>  			struct kvm_debug_exit_arch arch;
>  		} debug;
> @@ -285,6 +286,7 @@ struct kvm_run {
>  			__u32 data;
>  			__u8  is_write;
>  		} dcr;
> +		/* KVM_EXIT_INTERNAL_ERROR */
>  		struct {
>  			__u32 suberror;
>  			/* Available with KVM_CAP_INTERNAL_ERROR_DATA: */
> @@ -295,6 +297,7 @@ struct kvm_run {
>  		struct {
>  			__u64 gprs[32];
>  		} osi;
> +		/* KVM_EXIT_PAPR_HCALL */
>  		struct {
>  			__u64 nr;
>  			__u64 ret;
> -- 
> 2.3.5
> 

otherwise:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
